import 'dart:typed_data';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/crypto/crypto.dart';

Uint8List sha512AsU8a(Uint8List data) {
  return sha512(data.u8aToString()).toU8a();
}
