import 'package:p4d_rust_binding/wrapper/crypto.dart';
import 'package:p4d_rust_binding/wrapper/util.dart';

const int SR25519_KEY_LENGTH = 64;
const int SR25519_NONCE_LENGTH = 64;
const int SR25519_SECRET_LENGTH = SR25519_KEY_LENGTH + SR25519_NONCE_LENGTH;
const int SR25519_PUBLIC_LENGTH = 64;
const int SR25519_KEYPAIR_LENGTH = SR25519_SECRET_LENGTH + SR25519_PUBLIC_LENGTH;
const int SR25519_SIGNATURE_LENGTH = 128;

class SR25519 {
  String _keypair;
  String _secretKey;
  String _publicKey;

  String get keyPair => _keypair;
  String get secret => _secretKey;
  String get public => _publicKey;

  static String getPubFromSeed(String seed) {
    return sr25519GetPubFromSeed(seed);
  }

  static bool verify(String signature, String message, String pubkey) {
    var hexMessage = isHex(message) ? message : plainTextToHex(message);

    return sr25519Verify(signature, hexMessage, pubkey);
  }

  static SR25519 deriveKeypairSoft(String pair, String cc) {
    var newPair = sr25519DeriveKeypairSoft(pair, cc);
    return SR25519(newPair);
  }

  static SR25519 deriveKeypairHard(String pair, String cc) {
    var newPair = sr25519DeriveKeypairHard(pair, cc);
    return SR25519(newPair);
  }

  static String derivePublicSoft(String pubkey, String cc) {
    var newPublic = sr25519DerivePublicSoft(pubkey, cc);
    return newPublic;
  }

  static SR25519 fromSeed(String seed) {
    var newPair = sr25519KeypairFromSeed(seed);
    return SR25519(newPair);
  }

  static SR25519 fromBip39Phrase(String phrase, {String password = ""}) {
    if (!bip39Validate(phrase)) throw "Error: bip39 phrase is not correct";
    var seed = bip39ToSeed(phrase, password);
    return SR25519.fromSeed(seed);
  }

  factory SR25519(String pair) {
    return SR25519._fromPair(pair);
  }

  SR25519._fromPair(String pair) {
    var _kp = sr25519KeypairFromPair(pair);
    if (_kp.length != SR25519_KEYPAIR_LENGTH) throw "Error: sr25519 keypair length is not correct";
    _keypair = _kp;
    _secretKey = _keypair.substring(0, SR25519_SECRET_LENGTH);
    _publicKey = _keypair.substring(SR25519_SECRET_LENGTH, SR25519_KEYPAIR_LENGTH);
  }

  String sign(String message) {
    try {
      var hexMessage = isHex(message) ? message : plainTextToHex(message);
      final signature = sr25519Sign(public, secret, hexMessage);
      if (SR25519.verify(signature, message, public) &&
          signature.length == SR25519_SIGNATURE_LENGTH) {
        return signature;
      } else {
        throw "Error: SR25519 sign failed";
      }
    } catch (e) {
      throw e;
    }
  }
}
