import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/utils/utils.dart';

abstract class AbstractKeyPair {
  late final Uint8List publicKey;
  late final Uint8List secretKey;
}

abstract class Seedpair {
  late final Uint8List publicKey;
  late final Uint8List seed;
}

class KeyPair implements AbstractKeyPair {
  @override
  Uint8List publicKey;

  @override
  Uint8List secretKey;

  KeyPair({required this.publicKey, required this.secretKey});

  Map<String, Uint8List> toMap() => {"publicKey": publicKey, "secretKey": secretKey};

  Map<String, String> toHexMap() =>
      {"publicKey": publicKey.toHex(), "secretKey": u8aToHex(secretKey)};

  String toJson() => json.encode(toMap());

  factory KeyPair.fromMap(Map<String, Uint8List> json) => KeyPair(
        publicKey: json["publicKey"]!,
        secretKey: json["secretKey"]!,
      );

  factory KeyPair.fromJson(String str) => KeyPair.fromMap(json.decode(str));
}

class KeypairType {
  static const ed25519 = 'ed25519';
  static const sr25519 = 'sr25519';
  static const ecdsa = 'ecdsa';
  static const ethereum = 'ethereum';
  String _type;
  KeypairType(this._type);

  @override
  String toString() {
    super.toString();
    return _type;
  }
}

class VerifyResult {
  String crypto;
  bool isValid;
  VerifyResult({required this.crypto, required this.isValid});
  factory VerifyResult.fromMap(Map<String, dynamic> map) =>
      VerifyResult(crypto: map['crypto'] as String, isValid: map["isValid"] as bool);
  toMap() => {"crypto": this.crypto, "isValid": this.isValid};
}
