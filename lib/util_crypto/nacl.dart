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
    final full = ed25519KeypairFromSeed(u8aToHex(seed, include0x: false));
    final fullU8a = hexToU8a(hexAddPrefix(full));
    return KeyPair(publicKey: fullU8a.sublist(32), secretKey: fullU8a.sublist(0, 64));
  }
  final naclKeyPair = nacl.Signature.keyPair_fromSeed(seed);
  return KeyPair(publicKey: naclKeyPair.publicKey, secretKey: naclKeyPair.secretKey);
}

KeyPair naclKeypairFromString(String value) {
  return naclKeypairFromSeed(blake2AsU8a(stringToU8a(value), bitLength: 256));
}

NaclEncrypted naclEncrypt(Uint8List message, Uint8List secret, Uint8List nonce) {
  if (nonce == null) {
    nonce = randomAsU8a(24);
  }
  return NaclEncrypted(
      encrypted: nacl.SecretBox.nonce(secret, u8aToBn(nonce).toInt()).box(message), nonce: nonce);
}

Uint8List naclDecrypt(Uint8List encrypted, Uint8List nonce, Uint8List secret) {
  var boxed = nacl.SecretBox(secret);
  return boxed.open_nonce(encrypted, nonce);
}

final hdkd = compactAddLength(stringToU8a('Ed25519HDKD'));

Uint8List naclDeriveHard(Uint8List seed, Uint8List chainCode) {
  return blake2AsU8a(u8aConcat([hdkd, seed, chainCode]));
}

Uint8List naclOpen(
    Uint8List sealed, Uint8List nonce, Uint8List senderBoxPublic, Uint8List receiverBoxSecret) {
  return nacl.Box.nonce(senderBoxPublic, receiverBoxSecret, u8aToBn(nonce).toInt()).open(sealed);
}

NaclSealed naclSeal(
    Uint8List message, Uint8List senderBoxSecret, Uint8List receiverBoxPublic, Uint8List nonce) {
  if (nonce == null) {
    nonce = randomAsU8a(24);
  }
  return NaclSealed(
      sealed:
          nacl.Box.nonce(receiverBoxPublic, senderBoxSecret, u8aToBn(nonce).toInt()).box(message),
      nonce: nonce);
}
