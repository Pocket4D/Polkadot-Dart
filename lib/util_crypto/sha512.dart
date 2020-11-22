import 'dart:typed_data';
import 'package:p4d_rust_binding/utils/utils.dart';
import 'package:p4d_rust_binding/crypto/crypto.dart';

Uint8List sha512AsU8a(Uint8List data) {
  return sha512(data.u8aToString()).toU8a();
}
