// TODO
import 'dart:convert';
import 'dart:typed_data';

import 'package:p4d_rust_binding/utils/utils.dart';

abstract class AbstractKeyPair {
  Uint8List publicKey;
  Uint8List secretKey;
}

abstract class Seedpair {
  Uint8List publicKey;
  Uint8List seed;
}

class KeyPair implements AbstractKeyPair {
  @override
  Uint8List publicKey;

  @override
  Uint8List secretKey;

  KeyPair({this.publicKey, this.secretKey});

  Map<String, Uint8List> toMap() => {"publicKey": publicKey, "secretKey": secretKey};

  Map<String, String> toHexMap() =>
      {"publicKey": publicKey.toHex(), "secretKey": u8aToHex(secretKey)};

  String toJson() => json.encode(toMap());

  factory KeyPair.fromMap(Map<String, Uint8List> json) => KeyPair(
        publicKey: json["publicKey"],
        secretKey: json["secretKey"],
      );

  factory KeyPair.fromJson(String str) => KeyPair.fromMap(json.decode(str));
}
