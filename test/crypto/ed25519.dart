import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/crypto/ed25519.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() async {
  ed25519Test();
}

void ed25519Test() {
  test('ED25519.fromSeed and ED25519.getPubFromPrivate', () async {
    try {
      var seed = "12345678901234567890123456789012";
      var seedHex = plainTextToHex(seed);
      var kp2 = ED25519.fromSeed(seedHex);
      var prv2 = kp2.private;
      var pub2 = kp2.public;
      var expected3 = ED25519.getPubFromPrivate(prv2);
      expect(pub2, expected3);
      print("\n");
    } catch (e) {
      throw e;
    }
  });
  test('ED25519.sign and ED25519.verify', () async {
    try {
      var seed = bip39ToSeed(bip39Generate(12), "");
      var message = "this is a message";
      var kp2 = ED25519.fromSeed(seed);
      var signature2 = kp2.sign(message);
      var verified2 = ED25519.verify(signature2, message, kp2.public);
      expect(signature2.length, kp2.keyPair.length);
      expect(verified2, true);
      print("\n");
    } catch (e) {
      throw e;
    }
  });

  test('ED25519.verify', () async {
    try {
      var signature =
          "90588f3f512496f2dd40571d162e8182860081c74e2085316e7c4396918f07da412ee029978e4dd714057fe973bd9e7d645148bf7b66680d67c93227cde95202"; // some pub
      var message = "this is a message";
      var pub = "2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee";
      var verified2 = ED25519.verify(signature, message, pub);
      expect(verified2, true);
      print("\n");
    } catch (e) {
      throw e;
    }
  });
}
