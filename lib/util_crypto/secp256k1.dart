import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/crypto.dart' as crypto;
import 'package:p4d_rust_binding/crypto/curve.dart';
import 'package:p4d_rust_binding/util_crypto/blake2.dart';
import 'package:p4d_rust_binding/util_crypto/keccak.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

class ExpandOpt {
  static final int bitLength = 256;
  static final Endian endian = Endian.big;
}

KeyPair secp256k1KeypairFromSeed(Uint8List seed) {
  assert(seed.length == 32, 'Expected valid 32-byte private key as a seed');
  return crypto.Secp256k1.fromSeed(seed).toKeyPair();
}

Uint8List secp256k1Compress(Uint8List publicKey) {
  assert([33, 65].contains(publicKey.length), 'Invalid publicKey provided');

  return hexToU8a(crypto.Secp256k1.getCompressPublic(u8aToHex(publicKey)));
}

// ignore: non_constant_identifier_names
final HDKD = compactAddLength(stringToU8a('Secp256k1HDKD'));

Uint8List secp256k1DeriveHard(Uint8List seed, Uint8List chainCode) {
  // NOTE This is specific to the Substrate HDD derivation, so always use the blake2 hasher
  return blake2AsU8a(u8aConcat([HDKD, seed, chainCode]), bitLength: 256);
}

Uint8List secp256k1Expand(Uint8List publicKey) {
  assert([33, 65].contains(publicKey.length), 'Invalid publicKey provided');
  CurvePublicKey expanded;
  var pubHex = publicKey.toHex(include0x: false);
  if (publicKey.length == 33) {
    expanded = CurvePublicKey.fromCompressedHex(pubHex);
  } else {
    expanded = CurvePublicKey.fromHex(pubHex);
  }
  return u8aConcat([
    bnToU8a(expanded.X, bitLength: ExpandOpt.bitLength, endian: ExpandOpt.endian),
    bnToU8a(expanded.Y, bitLength: ExpandOpt.bitLength, endian: ExpandOpt.endian)
  ]);
}

const HASH_TYPES = ['blake2', 'keccak'];

Uint8List secp256k1Hasher(String hashType, dynamic data) {
  if (hashType == 'blake2') {
    return blake2AsU8a(data);
  } else if (hashType == 'keccak') {
    return keccakAsU8a(data);
  }
  throw "Unsupported secp256k1 hasher $hashType, expected one of ${HASH_TYPES.join(', ')}";
}

Uint8List secp256k1Sign(dynamic message, KeyPair keyPair, [String hashType = 'blake2']) {
  assert(keyPair.secretKey?.length == 32, 'Expected valid secp256k1 secretKey, 32-bytes');
  final CurvePrivateKey key = CurvePrivateKey.fromHex(keyPair.secretKey.toHex(include0x: false));
  final ecsig = key.signature(secp256k1Hasher(hashType, message).toHex(include0x: false));
  return ecsig.bytes;
}

Uint8List secp256k1Recover(Uint8List message, Uint8List signature, int recovery) {
  return crypto
      .secp256k1RecoverPublic(message.toHex(), signature.toHex(), recovery)
      .hexAddPrefix()
      .toU8a();
}

bool secp256k1Verify(dynamic message, dynamic signature, dynamic address,
    [String hashType = 'blake2']) {
  var isEthereum = hashType == 'keccak';
  var u8a = u8aToU8a(signature);
  var recoveryId = u8a[64];

  assert(u8a.length == 65, "Expected signature with 65 bytes, ${u8a.length} found instead");

  final publicKey = secp256k1Recover(secp256k1Hasher(hashType, message), u8a, recoveryId);
  var signingAddress =
      secp256k1Hasher(hashType, isEthereum ? secp256k1Expand(publicKey) : publicKey);
  var inputAddress = u8aToU8a(address);

  // for Ethereum (keccak) the last 20 bytes is the address
  return isEthereum
      ? u8aEq(signingAddress.sublist(signingAddress.length - 20, signingAddress.length),
          inputAddress.sublist(inputAddress.length - 20, inputAddress.length))
      : u8aEq(signingAddress, inputAddress);
}
