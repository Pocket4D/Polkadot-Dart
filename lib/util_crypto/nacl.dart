import 'dart:convert';
import 'dart:typed_data';
import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';
import 'package:p4d_rust_binding/util_crypto/blake2.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:tweetnacl/tweetnacl.dart' as nacl;

class NaclEncrypted {
  Uint8List encrypted;
  Uint8List nonce;
  NaclEncrypted({this.encrypted, this.nonce});
  toMap() => {"encrypted": encrypted, "nonce": nonce};
  toJson() => json.encode(toMap());
}

class NaclSealed {
  Uint8List sealed;
  Uint8List nonce;
  NaclSealed({this.sealed, this.nonce});
  toMap() => {"sealed": sealed, "nonce": nonce};
  toJson() => json.encode(toMap());
}

KeyPair naclBoxKeypairFromSecret(Uint8List secret) {
  final naclKeyPair = nacl.Box.keyPair_fromSecretKey(secret.sublist(0, 32));
  return KeyPair(publicKey: naclKeyPair.publicKey, secretKey: naclKeyPair.secretKey);
}

KeyPair naclKeypairFromRandom() {
  final naclKeyPair = nacl.Signature.keyPair();
  return KeyPair(publicKey: naclKeyPair.publicKey, secretKey: naclKeyPair.secretKey);
}

KeyPair naclKeypairFromSecret(Uint8List secret) {
  final naclKeyPair = nacl.Signature.keyPair_fromSecretKey(secret);
  return KeyPair(publicKey: naclKeyPair.publicKey, secretKey: naclKeyPair.secretKey);
}

KeyPair naclKeypairFromSeed(Uint8List seed, {bool useNative = true}) {
  if (useNative) {
    final full = ed25519KeypairFromSeed(seed.toHex(include0x: false));
    final fullU8a = full.hexAddPrefix().toU8a();
    return KeyPair(publicKey: fullU8a.sublist(32), secretKey: fullU8a.sublist(0, 64));
  }
  final naclKeyPair = nacl.Signature.keyPair_fromSeed(seed);
  return KeyPair(publicKey: naclKeyPair.publicKey, secretKey: naclKeyPair.secretKey);
}

KeyPair naclKeypairFromString(String value) {
  return naclKeypairFromSeed(blake2AsU8a(value.plainToU8a(), bitLength: 256));
}

NaclEncrypted naclEncrypt(Uint8List message, Uint8List secret, Uint8List nonce) {
  if (nonce == null) {
    nonce = randomAsU8a(24);
  }
  return NaclEncrypted(encrypted: nacl.SecretBox(secret).box_nonce(message, nonce), nonce: nonce);
}

Uint8List naclDecrypt(Uint8List encrypted, Uint8List nonce, Uint8List secret) {
  return nacl.SecretBox(secret).open_nonce(encrypted, nonce);
}

final hdkd = compactAddLength(stringToU8a('Ed25519HDKD'));

Uint8List naclDeriveHard(Uint8List seed, Uint8List chainCode) {
  return blake2AsU8a(u8aConcat([hdkd, seed, chainCode]));
}

Uint8List naclOpen(
    Uint8List sealed, Uint8List nonce, Uint8List senderBoxPublic, Uint8List receiverBoxSecret) {
  return nacl.Box.nonce(senderBoxPublic, receiverBoxSecret, nonce.toBn().toInt()).open(sealed);
}

NaclSealed naclSeal(
    Uint8List message, Uint8List senderBoxSecret, Uint8List receiverBoxPublic, Uint8List nonce) {
  if (nonce == null) {
    nonce = randomAsU8a(24);
  }
  return NaclSealed(
      sealed: nacl.Box.nonce(receiverBoxPublic, senderBoxSecret, nonce.toBn().toInt()).box(message),
      nonce: nonce);
}

Uint8List naclSign(dynamic message, KeyPair keyPair) {
  assert(keyPair.secretKey != null, 'Expected a valid secretKey');

  final messageU8a = u8aToU8a(message);

  return ed25519Sign(
          keyPair.publicKey.toHex(), keyPair.secretKey.sublist(0, 32).toHex(), messageU8a.toHex())
      .toU8a();
}

bool naclVerify(dynamic message, dynamic signature, dynamic publicKey) {
  final messageU8a = u8aToU8a(message);
  final publicKeyU8a = u8aToU8a(publicKey);
  final signatureU8a = u8aToU8a(signature);

  assert(publicKeyU8a.length == 32,
      "Invalid publicKey, received ${publicKeyU8a.length.toString()}, expected 32");
  assert(signatureU8a.length == 64,
      "Invalid signature, received ${signatureU8a.length.toString()} bytes, expected 64");

  return ed25519Verify(signatureU8a.toHex(), messageU8a.toHex(), publicKeyU8a.toHex());
}
