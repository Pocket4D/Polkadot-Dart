import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

const SEC_LEN = 64;
const PUB_LEN = 32;

KeyPair schnorrkelKeypairFromU8a(Uint8List full) {
  return KeyPair.fromMap({
    "publicKey": full.sublist(SEC_LEN, SEC_LEN + PUB_LEN),
    "secretKey": full.sublist(0, SEC_LEN)
  });
}

KeyPair schnorrkelKeypairFromSeed(Uint8List seed) {
  final nativeHex = hexAddPrefix(sr25519KeypairFromSeed(u8aToHex(seed, include0x: false)));
  return schnorrkelKeypairFromU8a(hexToU8a(nativeHex));
}

Uint8List schnorrkelKeypairToU8a(KeyPair keyPair) {
  var joined = u8aConcat([keyPair.secretKey, keyPair.publicKey]);
  var sliced = joined.sublist(0, joined.length);
  return sliced;
}

KeyPair schnorrkelDeriveHard(KeyPair keypair, Uint8List chainCode) {
  final nativeHex = hexAddPrefix(
      sr25519DeriveKeypairHard(u8aToHex(schnorrkelKeypairToU8a(keypair)), u8aToHex(chainCode)));

  return schnorrkelKeypairFromU8a(hexToU8a(nativeHex));
}

Uint8List schnorrkelDerivePublic(Uint8List publicKey, Uint8List chainCode) {
  return hexToU8a(hexAddPrefix(sr25519DerivePublicSoft(u8aToHex(publicKey), u8aToHex(chainCode))));
}

KeyPair schnorrkelDeriveSoft(KeyPair keypair, Uint8List chainCode) {
  final nativeHex = hexAddPrefix(
      sr25519DeriveKeypairSoft(u8aToHex(schnorrkelKeypairToU8a(keypair)), u8aToHex(chainCode)));
  return schnorrkelKeypairFromU8a(hexToU8a(nativeHex));
}

Uint8List schnorrkelSign(dynamic message, KeyPair keyPair) {
  assert(keyPair.publicKey?.length == 32, 'Expected a valid publicKey, 32-bytes');
  assert(keyPair.secretKey?.length == 64, 'Expected a valid secretKey, 64-bytes');
  var messageU8a = plainTextToHex(u8aToString(u8aToU8a(message)));
  final nativeHex =
      sr25519Sign(u8aToHex(keyPair.publicKey), u8aToHex(keyPair.secretKey), messageU8a);
  return hexToU8a(hexAddPrefix(nativeHex));
}

bool schnorrkelVerify(dynamic message, dynamic signature, dynamic publicKey) {
  var messageU8a = u8aToU8a(message);
  var publicKeyU8a = u8aToU8a(publicKey);
  var signatureU8a = u8aToU8a(signature);

  assert(publicKeyU8a.length == 32,
      "Invalid publicKey, received ${publicKeyU8a.length} bytes, expected 32");
  assert(signatureU8a.length == 64,
      "Invalid signature, received ${signatureU8a.length} bytes, expected 64");

  return sr25519Verify(u8aToHex(signatureU8a), u8aToHex(messageU8a), u8aToHex(publicKeyU8a));
}
