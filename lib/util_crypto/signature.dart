import 'dart:typed_data';

import 'package:p4d_rust_binding/util_crypto/address.dart';
import 'package:p4d_rust_binding/util_crypto/nacl.dart';
import 'package:p4d_rust_binding/util_crypto/schnorrkel.dart';
import 'package:p4d_rust_binding/util_crypto/secp256k1.dart';
import 'package:p4d_rust_binding/util_crypto/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

class VerifyInput {
  dynamic message;
  Uint8List publicKey;
  Uint8List signature;
  VerifyInput({this.message, this.publicKey, this.signature});
  factory VerifyInput.fromMap(Map m) =>
      VerifyInput(message: m["message"], publicKey: m["publicKey"], signature: m["signature"]);
}

typedef VerifyFunction = bool Function(dynamic message, Uint8List signature, Uint8List publicKey);

class Verifier {
  String keypairType;
  VerifyFunction verifyFunction;
  Verifier({this.keypairType, this.verifyFunction});
  factory Verifier.fromList(List<dynamic> list) =>
      Verifier(keypairType: list[0] as String, verifyFunction: list[1] as VerifyFunction);
  toList() => [keypairType, verifyFunction];
  toMap() => {keypairType: verifyFunction};
}

typedef VerifyFunctionCreator<T> = VerifyFunction Function(T hashType);

VerifyFunctionCreator<String> secp256k1VerifyHasher = (String hashType) =>
    (dynamic message, dynamic signature, Uint8List publicKey) =>
        secp256k1Verify(message, signature, publicKey, hashType);

final verifiersEcdsa = [
  Verifier.fromList(['ecdsa', secp256k1VerifyHasher('blake2')]),
  Verifier.fromList(['ethereum', secp256k1VerifyHasher('keccak')])
];

final defaultVerifiers = [
  Verifier.fromList(['ed25519', naclVerify]),
  Verifier.fromList(['sr25519', schnorrkelVerify]),
  ...verifiersEcdsa
];

const CRYPTO_TYPES = ['ed25519', 'sr25519', 'ecdsa'];

VerifyResult verifyDetect(VerifyResult result, VerifyInput input, List<Verifier> verifiers) {
  if (verifiers == null) {
    verifiers = defaultVerifiers;
  }
  result.isValid = verifiers.any((v) {
    try {
      if (v.verifyFunction(input.message, input.signature, input.publicKey)) {
        result.crypto = v.keypairType;

        return true;
      }
    } catch (error) {
      // do nothing, result.isValid still set to false
    }

    return false;
  });

  return result;
}

VerifyResult verifyMultisig(VerifyResult result, VerifyInput input) {
  assert([0, 1, 2].contains(input.signature[0]),
      "Unknown crypto type, expected signature prefix [0..2], found ${input.signature[0]}");

  final type = CRYPTO_TYPES[input.signature[0]] ?? 'none';

  result.crypto = type;
  try {
    result.isValid = {
      "ecdsa": () => verifyDetect(
              result,
              VerifyInput(
                  message: input.message,
                  publicKey: input.publicKey,
                  signature: input.signature.sublist(1)),
              verifiersEcdsa)
          .isValid,
      "ed25519": () => naclVerify(input.message, input.signature.sublist(1), input.publicKey),
      "none": () => throw "no verify for `none` crypto type",
      "sr25519": () => schnorrkelVerify(input.message, input.signature.sublist(1), input.publicKey)
    }[type]();
  } catch (error) {
    // ignore, result.isValid still set to false
  }

  return result;
}

VerifyResult signatureVerify(dynamic message, dynamic signature, dynamic addressOrPublicKey) {
  final signatureU8a = u8aToU8a(signature);

  assert([64, 65, 66].contains(signatureU8a.length),
      "Invalid signature length, expected [64..66] bytes, found ${signatureU8a.length}");

  final result = VerifyResult.fromMap({"crypto": 'none', "isValid": false});
  final publicKey = decodeAddress(addressOrPublicKey);
  final input = VerifyInput(message: message, publicKey: publicKey, signature: signatureU8a);
  return [0, 1, 2].contains(signatureU8a[0]) && [65, 66].contains(signatureU8a.length)
      ? verifyMultisig(result, input)
      : verifyDetect(result, input, null);
}
