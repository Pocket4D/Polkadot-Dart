import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:polkadot_dart/rpc_core/interface.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/types/create/createTypes.dart';
import 'package:polkadot_dart/types/interfaces/jsonrpc.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

bool isTreatAsHex(StorageKey key) {
  // :code is problematic - it does not have the length attached, which is
  // unlike all other storage entries where it is indeed properly encoded
  return ['0x3a636f6465'].contains(key.toHex());
}

class StorageChangeSetJSON {
  String block;
  List<dynamic> changes;
}

const EMPTY_META = {
  "fallback": null,
  "modifier": {"isOptional": true},
  "type": {
    "asMap": {
      "linked": {"isTrue": false}
    },
    "isMap": false
  }
};

abstract class BlockRegistryResult {
  Registry registry;
}

enum OutputType { json, raw, scale }

typedef BlockRegistry = Future<BlockRegistryResult> Function(dynamic blockHash);

class RpcCore implements RPCInterface {
  String _instanceId;
  Registry _registryDefault;
  BlockRegistry _getBlockRegistry;
  Map<String, DefinitionRpcExt> mapping = Map<String, DefinitionRpcExt>();
  Map<String, dynamic> _storageCache = Map<String, dynamic>();

  ProviderInterface provider;
  List<String> sections = [];
  String author = RPCInterface.author;
  String babe = RPCInterface.babe;
  String chain = RPCInterface.chain;
  String childstate = RPCInterface.childstate;
  String contracts = RPCInterface.contracts;
  String engine = RPCInterface.engine;
  String eth = RPCInterface.eth;
  String grandpa = RPCInterface.grandpa;
  String net = RPCInterface.net;
  String offchain = RPCInterface.offchain;
  String payment = RPCInterface.payment;
  String rpc = RPCInterface.rpc;
  String state = RPCInterface.state;
  String syncstate = RPCInterface.syncstate;
  String system = RPCInterface.system;
  String web3 = RPCInterface.web3;

  RpcCore(String instanceId, Registry registry, this.provider,
      [Map<String, Map<String, dynamic>> userRpc = const {}]) {
    assert(provider != null && (provider.send is Function), 'Expected Provider to API create');
    this._instanceId = instanceId;
    this._registryDefault = registry;
    var sectionNames = jsonrpc.keys;
    sections.addAll(sectionNames);
    // this.addUserInterfaces(userRpc);
  }

  /// @description Returns the connected status of a provider
  bool get isConnected {
    return this.provider.isConnected;
  }

  /// @description Manually connect from the attached provider
  Future<void> connect() {
    return this.provider.connect();
  }

  /// @description Manually disconnect from the attached provider
  Future<void> disconnect() {
    return this.provider.disconnect();
  }

  /// @description Sets a registry swap(typically from Api)
  void setRegistrySwap(BlockRegistry registrySwap) {
    this._getBlockRegistry = registrySwap;
  }

  //  addUserInterfaces(Map<String, Map<String, dynamic>> userRpc) {
  //   // add any extra user-defined sections
  //   this.sections.addAll(userRpc.keys.where((key) => !this.sections.contains(key)));

  //   // decorate the sections with base and user methods
  //   this.sections.forEach((sectionName)  {
  //    (this as Record<string, unknown>)[sectionName as Section] ||= {};

  //     const section = this[sectionName as Section] as Record<string, unknown>;

  //     Object
  //       .entries({
  //         ...this._createInterface(sectionName, jsonrpc[sectionName as 'babe'] || {}),
  //         ...this._createInterface(sectionName, userRpc[sectionName] || {})
  //       })
  //       .forEach(([key, value]): void => {
  //         section[key] ||= value;
  //       });
  //   });
  // }
  _createInterface(String section, Map<String, Map<String, dynamic>> methods) {
    return methods.entries
        .where((entry) =>
            !this.mapping.containsKey(entry.value["endpoint"] ?? "${section}_${entry.key}"))
        .fold({}, (exposed, entry) {
      final def = methods[entry.key];
      final isSubscription = (def as DefinitionRpcSub).pubsub != null ? true : false;
      final jsonrpc = entry.value["endpoint"] ?? "${section}_${entry.key}";

      this.mapping.putIfAbsent(
          jsonrpc,
          () => DefinitionRpcExt.fromMap({
                ...def,
                "isSubscription": isSubscription,
                "jsonrpc": jsonrpc,
                "method": entry.key,
                "section": section,
              }));

      // FIXME Remove any here
      // To do so, remove `RpcInterfaceMethod` from './types.ts', and refactor
      // every method inside this class to take:
      // `<S extends keyof RpcInterface, M extends keyof RpcInterface[S]>`
      // Not doing so, because it makes this class a little bit less readable,
      // and leaving it as-is doesn't harm much
      // (exposed as Map<String, dynamic>)[entry.key] = isSubscription
      //     ? this._createMethodSubscribe(section, entry.key, DefinitionRpcSub.fromMap(def))
      //     : this._createMethodSend(section, entry.key, DefinitionRpc.fromMap(def));

      // return exposed;
    });
  }

  // _memomize(creator:(outputAs: OutputType) =>(...values: any[]) => Observable<any>): Memoized<RpcInterfaceMethod> {
  //   const memoized = memoize(creator('scale') as RpcInterfaceMethod, {
  //     getInstanceId:() => this.#instanceId
  //   });

  //   memoized.json = creator('json');
  //   memoized.raw = creator('raw');

  //   return memoized;
  // }

// RpcInterfaceMethod
  // _createMethodSend(String section, String method, DefinitionRpc def) {
  //   final rpcName = def.endpoint ?? "${section}_$method";

  //   final hashIndex = def.params.indexWhere((params) => params.isHistoric);
  //   final cacheIndex = def.params.indexWhere((params) => params.isCached);
  //   // var memoized: null | Memoized<RpcInterfaceMethod> = null;
  //   var memoized;
  //   // execute the RPC call, doing a registry swap for historic as applicable
  //   final callWithRegistry = (OutputType outputAs, List<dynamic> values) async {
  //     final hash = hashIndex == -1 ? null : values[hashIndex] as Uint8List;
  //     final registry = hash != null && this._getBlockRegistry != null
  //         ? (await this._getBlockRegistry(hash)).registry
  //         : this._registryDefault;

  //     final params = this._formatInputs(registry, def, values);
  //     final data = await this.provider.send(rpcName, params.map((param) => param.toJSON()));

  //     return outputAs == OutputType.scale
  //         ? this._formatOutput(registry, method, def, params, data)
  //         : registry.createType(outputAs == OutputType.raw ? 'Raw' : 'Json', data);
  //   };

  //   final creator = (OutputType outputAs) => (List<dynamic> values) {
  //         final isDelayed = (hashIndex != -1 && !!values[hashIndex]) ||
  //             (cacheIndex != -1 && !!values[cacheIndex]);
  //         ReplaySubject s = ReplaySubject<dynamic>();
  //         callWithRegistry(outputAs, values).then((value) {
  //           s.add(value);
  //           s.close();
  //         }).catchError((error) {
  //           s.addError(error);
  //           s.close();
  //         });
  //         // Rx.concat([s.stream, publishReplay(1), isDelayed ? refCountDeplay() : refCount()]);
  //         // return new Observable((observer: Observer<any>) {
  //         //   callWithRegistry(outputAs, values)
  //         //     .then((value): void => {
  //         //       observer.next(value);
  //         //       observer.complete();
  //         //     })
  //         //     .catch((error): void => {
  //         //       logErrorMessage(method, def, error);

  //         //       observer.error(error);
  //         //       observer.complete();
  //         //     });

  //         //   return() {
  //         //     // delete old results from cache
  //         //     memoized?.unmemoize(...values);
  //         //   };
  //         // }).pipe(
  //         //   publishReplay(1), // create a Replay(1)
  //         //   isDelayed
  //         //     ? refCountDelay() // Unsubscribe after delay
  //         //     : refCount()
  //         // );
  //       };

  //   // memoized = this._memomize(creator);

  //   // return memoized;
  // }

  // create a subscriptor, it subscribes once and resolves with the id as subscribe
  Future<dynamic> _createSubscriber(
      {String subType,
      String subName,
      List<Object> paramsJson,
      ProviderInterfaceCallback update,
      void Function(Error error) errorHandler}) async {
    try {
      var result = await this.provider.subscribe(subType, subName, paramsJson, update);
      return Future.value(result);
    } catch (error) {
      errorHandler(error);
      return Future.error(error);
    }
  }

  // RpcInterfaceMethod
  _createMethodSubscribe(String section, String method, DefinitionRpcSub def) {
    final updateType = def.pubsub[0];
    final subMethod = def.pubsub[1];
    final unsubMethod = def.pubsub[2];
    final subName = "${section}_$subMethod";
    final unsubName = "${section}_$unsubMethod";
    final subType = "${section}_$updateType";
    // var memoized: null | Memoized<RpcInterfaceMethod> = null;

    // const creator =(outputAs: OutputType) =>(...values: unknown[]): Observable<any> => {
    //   return new Observable((observer: Observer<any>): VoidCallback => {
    //     // Have at least an empty promise, as used in the unsubscribe
    //     let subscriptionPromise: Promise<number | string | null> = Promise.resolve(null);
    //     const registry = this.#registryDefault;

    //     const errorHandler =(error: Error): void => {
    //       logErrorMessage(method, def, error);

    //       observer.error(error);
    //     };

    //     try {
    //       const params = this._formatInputs(registry, def, values);
    //       const paramsJson = params.map((param): AnyJson => param.toJSON());

    //       const update =(error?: Error | null, result?: any): void => {
    //         if(error) {
    //           logErrorMessage(method, def, error);

    //           return;
    //         }

    //         try {
    //           observer.next(
    //             outputAs === 'scale'
    //               ? this._formatOutput(registry, method, def, params, result)
    //               : registry.createType(outputAs === 'raw' ? 'Raw' : 'Json', result)
    //           );
    //         } catch(error) {
    //           observer.error(error);
    //         }
    //       };

    //       subscriptionPromise = this._createSubscriber({ paramsJson, subName, subType, update }, errorHandler);
    //     } catch(error) {
    //       errorHandler(error);
    //     }

    //     // Teardown logic
    //     return(): void => {
    //       // Delete from cache, so old results don't hang around
    //       memoized?.unmemoize(...values);

    //       // Unsubscribe from provider
    //       subscriptionPromise
    //         .then((subscriptionId): Promise<boolean> =>
    //           isNull(subscriptionId)
    //             ? Promise.resolve(false)
    //             : this.provider.unsubscribe(subType, unsubName, subscriptionId)
    //         )
    //         .catch((error: Error) => logErrorMessage(method, def, error));
    //     };
    //   }).pipe(drr());
    // };

    // memoized = this._memomize(creator);

    // return memoized;
  }

  List<BaseCodec> _formatInputs(Registry registry, DefinitionRpc def, List<dynamic> inputs) {
    final reqArgCount = def.params.where((param) => !param.isOptional).length;
    final optText =
        reqArgCount == def.params.length ? '' : "(${def.params.length - reqArgCount} optional)";

    assert(inputs.length >= reqArgCount && inputs.length <= def.params.length,
        "Expected ${def.params.length} parameters$optText, ${inputs.length} found instead");

    inputs.asMap().entries.map((entry) {
      int index = entry.key;
      var input = entry.value;
      return createTypeUnsafe(registry, def.params[index].type, [input]);
    }).toList();
  }

  _formatOutput(Registry registry, String method, DefinitionRpc rpc, List<BaseCodec> params,
      [dynamic result]) {
    if (rpc.type == 'StorageData') {
      final key = params[0] as StorageKey;

      return this._formatStorageData(registry, key, result);
    } else if (rpc.type == 'StorageChangeSet') {
      final keys = params[0] as Vec<StorageKey>;

      return keys != null
          ? this._formatStorageSet(registry, keys, (result as StorageChangeSetJSON).changes)
          : registry.createType('StorageChangeSet', result);
    } else if (rpc.type == 'Vec<StorageChangeSet>') {
      final mapped = (result as List<StorageChangeSetJSON>)
          .map((data) => [
                registry.createType('Hash', data.block),
                this._formatStorageSet(registry, params[0] as Vec<StorageKey>, data.changes)
              ])
          .toList();

      // we only query at a specific block, not a range - flatten
      return method == 'queryStorageAt' ? mapped[0][1] : mapped as List<BaseCodec>;
    }

    return createTypeUnsafe(registry, rpc.type, [result]);
  }

  _formatStorageData(Registry registry, StorageKey key, [String value]) {
    final isEmpty = isNull(value);

    // we convert to Uint8Array since it maps to the raw encoding, all
    // data will be correctly encoded(incl. numbers, excl. :code)
    final input = isEmpty
        ? null
        : isTreatAsHex(key)
            ? value
            : u8aToU8a(value);

    return this._newType(registry, key, input, isEmpty);
  }

  _formatStorageSet(Registry registry, Vec<StorageKey> keys, List<dynamic> changes) {
    // For StorageChangeSet, the changes has the [key, value] mappings
    final withCache = keys.length != 1;

    // multiple return values(via state.storage subscription), decode the values
    // one at a time, all based on the query types. Three values can be returned -
    //   - Codec - There is a valid value, non-empty
    //   - null - The storage key is empty

    return keys.value.fold<List<BaseCodec>>([], (List<BaseCodec> results, StorageKey key) {
      var index = keys.value.indexOf(key);
      results.add(this._formatStorageSetEntry(registry, key, changes, withCache, index));
      return results;
    });
  }

  _formatStorageSetEntry(
      Registry registry, StorageKey key, List<dynamic> changes, bool witCache, int entryIndex) {
    final hexKey = key.toHex();
    final found = changes.where(([key]) => key == hexKey).toList();

    // if we don't find the value, this is our fallback
    //   - in the case of an array of values, fill the hole from the cache
    //   - if a single result value, don't fill - it is not an update hole
    //   - fallback to an empty option in all cases
    final value = isNull(found) ? (witCache && this._storageCache[hexKey]) || null : found[1];
    final isEmpty = isNull(value);
    final input = isEmpty || isTreatAsHex(key) ? value : u8aToU8a(value);

    // store the retrieved result - the only issue with this cache is that there is no
    // clearing of it, so very long running processes(not just a couple of hours, longer)
    // will increase memory beyond what is allowed.
    this._storageCache[hexKey] = value;

    return this._newType(registry, key, input, isEmpty, entryIndex);
  }

  _newType(Registry registry, StorageKey key, dynamic input, bool isEmpty, [int entryIndex = -1]) {
    // single return value(via state.getStorage), decode the value based on the
    // outputType that we have specified. Fallback to Raw on nothing
    final type = key.outputType ?? 'Raw';
    final meta = key.meta ?? EMPTY_META;
    final entryNum = entryIndex == -1 ? '' : " entry $entryIndex:";

    if ((meta is StorageEntryMetadataLatest && meta.modifier.isOptional) ||
        (meta == EMPTY_META &&
            (meta as Map<String, Map<String, Object>>)["modifier"]["isOptional"] == true)) {
      var inner;

      if (!isEmpty) {
        try {
          inner = createTypeUnsafe(registry, type, [input], true);
        } catch (error) {
          print(
              "Unable to decode storage ${key.section ?? 'unknown'}.${key.method ?? 'unknown'}:$entryNum $error");
        }
      }

      return Option(registry, createClass(registry, type), inner);
    }

    try {
      return createTypeUnsafe(
          registry,
          type,
          [
            isEmpty
                ? meta is StorageEntryMetadataLatest && meta.fallback != null
                    ? hexToU8a(meta.fallback.toHex())
                    : null
                : input
          ],
          true);
    } catch (error) {
      print(
          "Unable to decode storage ${key.section ?? 'unknown'}.${key.method ?? 'unknown'}:$entryNum $error");

      return registry.createType('Raw', input);
    }
  }
}
