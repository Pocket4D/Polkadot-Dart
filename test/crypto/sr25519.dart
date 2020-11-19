import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/crypto/sr25519.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  sr25519Test();
}

void sr25519Test() {
  test("SR25519.getPubFromSeed", () async {
    try {
      var seed = "9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60";
      var expected = "44a996beb1eef7bdcab976ab6d2ca26104834164ecf28fb375600576fcc6eb0f";

      var result2 = SR25519.getPubFromSeed(seed);
      expect(result2, expected);
      print("\n");
    } catch (e) {
      throw e;
    }
  });
  test('SR25519.fromSeed', () async {
    try {
      var expected = "46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a";
      var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
      var keypair2 = SR25519.fromSeed(seed);
      var pub2 = keypair2.public;
      expect(pub2, expected);
      print("\n");
    } catch (e) {
      throw e;
    }
  });

  test('SR25519.sign and SR25519.verify', () async {
    try {
      var seed = bip39ToSeed(bip39Generate(12), "");
      var keypair2 = SR25519.fromSeed(seed);
      var message2 = "this is a message";
      var signature2 = keypair2.sign(message2);
      var verified2 = SR25519.verify(signature2, message2, keypair2.public);
      expect(verified2, true);
      print("\n");
    } catch (e) {
      throw e;
    }
  });

  test('SR25519.verify', () async {
    try {
      var pub = "d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d";
      var message = plainTextToHex(
          "I hereby verify that I control 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY");
      var signature =
          "1037eb7e51613d0dcf5930ae518819c87d655056605764840d9280984e1b7063c4566b55bf292fcab07b369d01095879b50517beca4d26e6a65866e25fec0d83";
      var verified2 = SR25519.verify(signature, message, pub);
      expect(verified2, true);
      print("\n");
    } catch (e) {
      throw e;
    }
  });

  test('SR25519 deriveKeypairSoft', () async {
    try {
      var cc = "0c666f6f00000000000000000000000000000000000000000000000000000000";
      var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
      var expected = "40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a";

      final keypair2 = SR25519.fromSeed(seed);
      final derivedPair2 = SR25519.deriveKeypairSoft(keypair2.keyPair, cc);
      final pub2 = derivedPair2.public;
      expect(pub2, expected);
      print("\n");
    } catch (e) {
      throw e;
    }
  });
  test('SR25519.derivePublicSoft', () async {
    try {
      var cc = "0c666f6f00000000000000000000000000000000000000000000000000000000";
      var expected = "40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a";
      var pub = "46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a";
      var derivedPublic2 = SR25519.derivePublicSoft(pub, cc);
      expect(derivedPublic2, expected);
      print("\n");
    } catch (e) {
      throw e;
    }
  });

  test('SR25519.deriveKeypairHard', () async {
    try {
      var cc = "14416c6963650000000000000000000000000000000000000000000000000000";
      var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
      var expected = "d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d";

      var keypair2 = SR25519.fromSeed(seed);
      var derivedPair2 = SR25519.deriveKeypairHard(keypair2.keyPair, cc);
      var pub2 = derivedPair2.public;
      expect(pub2, expected);
      print("\n");
    } catch (e) {
      throw e;
    }
  });
}
