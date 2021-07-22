import 'dart:typed_data';

import 'package:base_x/base_x.dart';
import 'package:polkadot_dart/util_crypto/base32.dart';
import 'package:polkadot_dart/utils/utils.dart';

const BASE58_ALPHABET = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

final bs58 = BaseXCodec(BASE58_ALPHABET);

class CheckConfig {
  late final String alphabet;
  late final String ipfsChar;
  late final String type;
}

class Base58Config extends CheckConfig {
  final String alphabet = BASE58_ALPHABET;
  final String ipfsChar = 'z';
  final String type = 'base58';
  Base58Config();
}

bool validateChars(CheckConfig config, {required String value, bool ipfsCompat = false}) {
  assert(value != null, "Expected non-null, non-empty ${config.type} input");
  assert(!ipfsCompat || value[0] == config.ipfsChar,
      "Expected ${config.type} to start with '${config.ipfsChar}'");

  for (var i = (ipfsCompat ? 1 : 0); i < value.length; i++) {
    assert(config.alphabet.contains(value[i]),
        "Invalid ${config.type} character ${value[i]} (0x${value.codeUnitAt(i).toRadixString(16)}) at index $i");
  }
  return true;
}

bool base58Validate(String value, {bool ipfsCompat = false}) {
  return validateChars(Base58Config(), value: value, ipfsCompat: ipfsCompat);
}

Uint8List base58Decode(String value, {bool ipfsCompat = false}) {
  base58Validate(value, ipfsCompat: ipfsCompat);
  return bs58.decode(value.substring(ipfsCompat ? 1 : 0)).toU8a();
}

String base58Encode(dynamic value, {bool ipfsCompat = false}) {
  var out = bs58.encode(u8aToU8a(value));
  return ipfsCompat ? "z$out" : out;
}

bool isBase58({required String value, bool ipfsCompat = false}) {
  return testValidator(base58Validate, value, ipfsCompat: ipfsCompat);
}
