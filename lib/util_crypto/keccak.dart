import 'dart:typed_data';

import 'package:polkadot_dart/crypto/crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

Uint8List keccakAsU8a(dynamic value) {
  return keccak256(u8aToU8a(value).toHex()).hexAddPrefix().toU8a();
}

String keccakAsHex(dynamic value) {
  return u8aToHex(keccakAsU8a(value));
}
