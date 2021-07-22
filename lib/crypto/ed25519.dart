import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/crypto/common.dart';

const int ED25519_PRIVATE_LENGTH = 64;
const int ED25519_PUBLIC_LENGTH = 64;
const int ED25519_SIGNATURE_LENGTH = 128;
const int ED25519_KEYPAIR_LENGTH = 128;

class ED25519 {
  late final String _keypair;
  late final String _privateKey;
  late final String _publicKey;

  String get keyPair => _keypair;
  String get private => _privateKey;
  String get public => _publicKey;

  static getPubFromPrivate(String privateKey) {
    return ed25519GetPubFromPrivate(privateKey);
  }

  static ED25519 fromSeed(String seed) {
    var _kp = ed25519KeypairFromSeed(seed);
    return ED25519(_kp);
  }

  static bool verify(String signature, String message, String pubkey) {
    var hexMessage = isHexString(message) ? message : plainTextToHex(message);
    return ed25519Verify(signature, hexMessage, pubkey);
  }

  factory ED25519(String pair) {
    return ED25519._fromPair(pair);
  }

  ED25519._fromPair(String pair) {
    if (pair.length != ED25519_KEYPAIR_LENGTH) throw "Error: ed25519 keypair length is not correct";
    _keypair = pair;
    _privateKey = _keypair.substring(0, ED25519_PRIVATE_LENGTH);
    _publicKey = _keypair.substring(ED25519_PRIVATE_LENGTH, ED25519_KEYPAIR_LENGTH);
  }

  String sign(String message) {
    try {
      var hexMessage = isHexString(message) ? message : plainTextToHex(message);
      final signature = ed25519Sign(public, private, hexMessage);
      if (ED25519.verify(signature, message, public) &&
          signature.length == ED25519_SIGNATURE_LENGTH) {
        return signature;
      } else {
        throw "Error: ED25519 sign failed";
      }
    } catch (e) {
      throw e;
    }
  }
}
