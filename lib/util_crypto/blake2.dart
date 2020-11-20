import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

String blake2AsHex(dynamic data, {int bitLength = 256, dynamic key}) {
  final byteLength = (bitLength / 8).ceil();
  final blake2ed = blake2b(isU8a(data) ? u8aToHex(data) : plainTextToHex(data),
      u8aToHex(u8aToU8a(key), include0x: false), byteLength);
  return hexAddPrefix(blake2ed);
}

Uint8List blake2AsU8a(dynamic data, {int bitLength = 256, dynamic key}) {
  return hexToU8a(blake2AsHex(data, bitLength: bitLength, key: key));
}
