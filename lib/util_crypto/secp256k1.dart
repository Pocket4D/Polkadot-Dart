import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/crypto.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

KeyPair secp256k1KeypairFromSeed(Uint8List seed) {
  assert(seed.length == 32, 'Expected valid 32-byte private key as a seed');
  return Secp256k1.fromSeed(seed).toKeyPair();
}

Uint8List secp256k1Compress(Uint8List publicKey) {
  assert([33, 65].contains(publicKey.length), 'Invalid publicKey provided');

  return hexToU8a(Secp256k1.getCompressPublic(u8aToHex(publicKey)));
}
