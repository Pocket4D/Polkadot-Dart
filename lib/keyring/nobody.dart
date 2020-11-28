import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';

final publicKey = Uint8List(32);
final address = encodeAddress(publicKey);
final meta = {"isTesting": true, "name": 'nobody'};

final json = KeyringPair$Json.fromMap({
  "address": address,
  "encoded": '',
  "encoding": {
    "content": ['pkcs8', 'ed25519'],
    "type": 'none',
    "version": '0'
  },
  "meta": meta
});

class BaseKeyringPair implements KeyringPair {
  String _address;

  Uint8List _addressRaw;

  bool _isLocked;

  Map<String, dynamic> _meta;

  Uint8List _publicKey;

  String _type;

  Map<String, dynamic> newMeta;

  BaseKeyringPair(
      {address,
      addressRaw,
      isLocked,
      meta,
      publicKey,
      type,
      this.decodePkcs8,
      this.derive,
      this.encodePkcs8,
      this.lock,
      this.setMeta,
      this.sign,
      this.toJson,
      this.verify}) {
    this._address = address;
    this._addressRaw = addressRaw;
    this._isLocked = isLocked;
    this._meta = meta;
    this._publicKey = publicKey;
    this._type = type;
  }

  @override
  KDecodePkcs8 decodePkcs8;

  @override
  KDerive derive;

  @override
  KEncodePkcs8 encodePkcs8;

  @override
  KLock lock;

  @override
  KSetMeta setMeta;

  @override
  KSign sign;

  @override
  KToJson toJson;

  @override
  KVerify verify;

  @override
  String get address => this._address;

  @override
  Uint8List get addressRaw => this._addressRaw;

  @override
  bool get isLocked => this._isLocked;

  @override
  Map<String, dynamic> get meta => this.newMeta ?? this._meta;

  @override
  Uint8List get publicKey => this._publicKey;

  @override
  String get type => this._type;
}

KeyringPair nobody() {
  var pair = BaseKeyringPair(
      address: address,
      addressRaw: publicKey,
      isLocked: true,
      meta: meta,
      publicKey: publicKey,
      type: 'ed25519');
  // ignore: missing_return
  pair.decodePkcs8 = (String passphrase, [Uint8List encoded]) {};
  pair.derive = (String suri, [Map<String, dynamic> meta]) => pair;
  pair.encodePkcs8 = ([String passphrase]) async => Uint8List(0);
  pair.lock = () {};
  pair.setMeta = (Map<String, dynamic> meta) {};
  pair.sign = (Uint8List message, [SignOptions options]) => Uint8List(64);
  pair.toJson = ([String passphrase]) async => json;
  pair.verify = (Uint8List message, Uint8List signature) => false;

  return pair;
}
