import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/types/types/interfaces.dart';
import 'package:polkadot_dart/utils/utils.dart';

class SignatureOptionsImpl implements SignatureOptions {
  @override
  var blockHash;

  @override
  IExtrinsicEra era;

  @override
  var genesisHash;

  @override
  var nonce;

  @override
  IRuntimeVersion runtimeVersion;

  @override
  List<String> signedExtensions;

  @override
  Signer signer;

  @override
  var tip;

  SignatureOptionsImpl(
      {this.blockHash,
      this.era,
      this.genesisHash,
      this.nonce,
      this.runtimeVersion,
      this.signedExtensions,
      this.signer,
      this.tip});
  factory SignatureOptionsImpl.fromMap(Map<String, dynamic> map) {
    var _blockHash = map["blockHash"] ?? null;
    var _era = map["era"] ?? null;
    var _genesisHash = map["genesisHash"] ?? null;
    var _nonce = map["nonce"] ?? null;
    var _runtimeVersion =
        map["runtimeVersion"] is Map ? RuntimeVersionImpl.fromMap(map["runtimeVersion"]) : null;
    var _signedExtensions = map["signedExtensions"] ?? null;
    var _tip = map["tip"] ?? null;

    return SignatureOptionsImpl(
        blockHash: _blockHash,
        era: _era,
        genesisHash: _genesisHash,
        nonce: _nonce,
        runtimeVersion: _runtimeVersion,
        signedExtensions: _signedExtensions,
        tip: _tip);
  }
}

class RuntimeVersionImpl implements IRuntimeVersion {
  @override
  List apis;

  @override
  BigInt authoringVersion;

  @override
  String implName;

  @override
  BigInt implVersion;

  @override
  String specName;

  @override
  BigInt specVersion;

  @override
  BigInt transactionVersion;

  RuntimeVersionImpl(
      {this.apis,
      this.authoringVersion,
      this.implName,
      this.implVersion,
      this.specName,
      this.specVersion,
      this.transactionVersion});

  factory RuntimeVersionImpl.fromMap(Map<String, dynamic> map) {
    return RuntimeVersionImpl(
        apis: map["apis"] as List ?? null,
        authoringVersion: map["authoringVersion"] is BigInt
            ? map["authoringVersion"]
            : BigInt.from(map["authoringVersion"] as int) ?? null,
        implName: map["implName"] as String ?? null,
        implVersion: map["implVersion"] is BigInt
            ? map["implVersion"] ?? null
            : BigInt.from(map["implVersion"] as int) ?? null,
        specName: map["specName"] as String ?? null,
        specVersion: map["specVersion"] is BigInt
            ? map["specVersion"] ?? null
            : BigInt.from(map["specVersion"] as int) ?? null,
        transactionVersion: map["transactionVersion"] is BigInt
            ? map["transactionVersion"] ?? null
            : BigInt.from(map["transactionVersion"] as int) ?? null);
  }
}

// abstract class IKeyringPair {
//   String address;
//   Uint8List addressRaw;
//   Uint8List publicKey;
//   Uint8List sign(Uint8List data, [SignOptions options]);
// }

class KeyringPairImpl implements IKeyringPair {
  @override
  String address;

  @override
  Uint8List addressRaw;

  @override
  Uint8List publicKey;

  KeyringPairImpl(
      {this.address,
      this.addressRaw,
      this.publicKey,
      this.sign,
      this.decodePkcs8,
      this.derive,
      this.encodePkcs8,
      this.lock,
      this.setMeta,
      this.toJson,
      this.verify});

  factory KeyringPairImpl.fromMap(Map<String, dynamic> map) {
    return KeyringPairImpl(
        address: map["address"], addressRaw: map["addressRaw"], publicKey: map["publicKey"]);
  }

  @override
  var decodePkcs8;

  @override
  var derive;

  @override
  var encodePkcs8;

  @override
  var lock;

  @override
  var setMeta;

  @override
  var sign;

  @override
  var toJson;

  @override
  var verify;

  @override
  // TODO: implement isLocked
  bool get isLocked => throw UnimplementedError();

  @override
  // TODO: implement meta
  Map<String, dynamic> get meta => throw UnimplementedError();

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}
