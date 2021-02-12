import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/storage/index.dart';

import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/rpc_provider/ws/event_emitter.dart';
import 'package:polkadot_dart/types/interfaces/jsonrpc.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';
import '../../metadata/v12/v12.dart';
import 'types.dart';

const INTERVAL = 1000;

// ignore: non_constant_identifier_names
final SUBSCRIPTIONS = jsonrpc.values
    .map((section) =>
        section.values.where((element) => element.isSubscription).map((e) => e.jsonrpc).toList())
    .toList()
    .expand((element) => element)
    .toList()
      ..add('chain_subscribeNewHead');

final keyring = createTestKeyring(KeyringOptions(type: 'ed25519'));

class MockProvider implements ProviderInterface {
  // export type MockStateDb = Record<string, Uint8Array>;
  Map<String, Uint8List> db = {};
  // export type MockStateRequests = Record<string, (db: MockStateDb, params: any[]) => string>;

  EventEmitter emitter = EventEmitter();

  bool isUpdating = true;

  Registry registry;

  BigInt prevNumber = BigInt.from(-1);

  Map<String, Function> requests;

  Map<String, dynamic> rpcMetadata;
  Map<String, dynamic> rpcSignedBlock;
  Map<String, dynamic> rpcHeader;

  void _setRequests() {
    this.requests = Map<String, Function>.from({
      "chain_getBlock": (Map<String, Uint8List> storage, List params) =>
          this.registry.createType('SignedBlock', rpcSignedBlock["result"]).toJSON(),
      "chain_getBlockHash": (Map<String, Uint8List> storage, List params) => '0x1234',
      "chain_getFinalizedHead": (Map<String, Uint8List> storage, List params) =>
          this.registry.createType('Header', rpcHeader["result"]).hash,
      "chain_getHeader": (Map<String, Uint8List> storage, List params) =>
          this.registry.createType('Header', rpcHeader["result"]).toJSON(),
      "rpc_methods": (Map<String, Uint8List> storage, List params) => [],
      "state_getKeys": (Map<String, Uint8List> storage, List params) => [],
      "state_getKeysPaged": (Map<String, Uint8List> storage, List params) => [],
      "state_getMetadata": (Map<String, Uint8List> storage, List params) => v12,
      "state_getRuntimeVersion": (Map<String, Uint8List> storage, List params) =>
          this.registry.createType('RuntimeVersion').toHex(),
      "state_getStorage": (Map<String, Uint8List> storage, List params) =>
          u8aToHex(storage[(params[0] as String)]),
      "system_chain": (Map<String, Uint8List> storage, List params) => 'mockChain',
      "system_name": (Map<String, Uint8List> storage, List params) => 'mockClient',
      "system_properties": (Map<String, Uint8List> storage, List params) => ({"ss58Format": 42}),
      "system_version": (Map<String, Uint8List> storage, List params) => '9.8.7'
    });
  }

  Map<String, Map<String, dynamic>> subscriptions;

  void _setSubscriptions() {
    var result = SUBSCRIPTIONS.fold(Map<String, Map<String, dynamic>>.from({}), (subs, name) {
      subs[name] = {"callbacks": {}, "lastValue": null};
      return subs;
    });

    subscriptions = result;
  }

  int subscriptionId = 0;

  Map<int, String> subscriptionMap = {};

  MockProvider(Registry registry, {this.rpcMetadata, this.rpcHeader, this.rpcSignedBlock}) {
    this.registry = registry;

    this.init();
  }

  void init() {
    this._setRequests();
    this._setSubscriptions();

    const emitEvents = ['connected', 'disconnected'];

    var emitIndex = 0;
    var newHead = this.makeBlockHeader();
    var counter = -1;

    final metadata = Metadata(this.registry, rpcMetadata);

    this.registry.setMetadata(metadata);

    final query = decorateStorage(this.registry, metadata.asLatest, metadata.version);

    Timer.periodic(Duration(microseconds: INTERVAL), (timer) {
      if (!this.isUpdating) {
        return;
      }
      // create a new header (next block)
      newHead = this.makeBlockHeader();

      var kps = keyring.getPairs();

      kps.forEach((kp) {
        this.setStateBn(query["system"]["account"].call([kp.publicKey]),
            (newHead.getCodec("number") as Compact).toBn() + BigInt.from(kps.indexOf(kp)));
      });

      // set the timestamp for the current block
      this.setStateBn(query["timestamp"]["now"].call(),
          (DateTime.now().millisecondsSinceEpoch / 1000).floor().toBn());
      this.updateSubs('chain_subscribeNewHead', newHead);

      // We emit connected/disconnected at intervals
      if (++counter % 2 == 1) {
        if (++emitIndex == emitEvents.length) {
          emitIndex = 0;
        }

        this.emitter.emit(emitEvents[emitIndex]);
      }
    });
  }

  Struct makeBlockHeader() {
    final blockNumber = this.prevNumber + BigInt.one;
    final header = this.registry.createType('Header', {
      "digest": {"logs": []},
      "extrinsicsRoot": randomAsU8a(),
      "number": blockNumber,
      "parentHash": blockNumber == BigInt.zero
          ? Uint8List(32)
          : bnToU8a(this.prevNumber, bitLength: 256, endian: Endian.big),
      "stateRoot": bnToU8a(blockNumber, bitLength: 256, endian: Endian.big)
    });

    this.prevNumber = blockNumber;

    return header;
  }

  void setStateBn(Uint8List key, dynamic value) {
    this.db[u8aToHex(key)] = bnToU8a(value, bitLength: 256, endian: Endian.little);
  }

  void updateSubs(String method, BaseCodec value) {
    this.subscriptions[method]["lastValue"] = value.value;
    (this.subscriptions[method]["callbacks"]).values.forEach((cb) {
      try {
        cb(null, value.toJSON());
      } catch (error) {
        print("Error on '$method' subscription: $error");
      }
    });
  }

  @override
  ProviderInterface clone() {
    // TODO: implement clone
    throw UnimplementedError();
  }

  @override
  Future<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasSubscriptions
  bool get hasSubscriptions => throw UnimplementedError();

  @override
  // TODO: implement isConnected
  bool get isConnected => true;

  @override
  void Function() on(ProviderInterfaceEmitted type, sub) {
    this.emitter.on(type.name, sub);

    return () {
      this.emitter.off(type.name, sub);
    };
  }

  @override
  Future send(String method, List params) {
    assert(this.requests[method] != null, "provider.send: Invalid method '$method'");
    return Future.value(this.requests[method](this.db, params));
  }

  @override
  Future<int> subscribe(String type, String method, List params, cb) {
    // l.debug((): any => ['subscribe', method, params]);

    assert(this.subscriptions[method] != null, "provider.subscribe: Invalid method '$method'");

    // final callback = params.removeLast() as MockStateSubscriptionCallback;
    final callback = cb;
    final id = ++this.subscriptionId;

    this.subscriptions[method]["callbacks"][id] = callback;
    this.subscriptionMap[id] = method;

    if (this.subscriptions[method]["lastValue"] != null) {
      callback(null, this.subscriptions[method]["lastValue"]);
    }
    return Future.value(id);
  }

  @override
  Future<bool> unsubscribe(String type, String method, id) {
    final sub = this.subscriptionMap[id];

    // l.debug((): any => ['unsubscribe', id, sub]);

    assert(sub != null, "Unable to find subscription for $id");

    this.subscriptionMap.remove(id);
    this.subscriptions[sub]["callbacks"].remove(id);

    return Future.value(true);
  }
}
