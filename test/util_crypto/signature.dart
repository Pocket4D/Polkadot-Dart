import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/address.dart';
import 'package:p4d_rust_binding/util_crypto/signature.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

import '../testUtils/throws.dart';

void main() {
  signatureTest();
}

void signatureTest() {
  final ADDR_ED = 'DxN4uvzwPzJLtn17yew6jEffPhXQfdKHTp2brufb98vGbPN';
  final ADDR_SR = 'EK1bFgKm2FsghcttHT7TB7rNyXApFgs9fCbijMGQNyFGBQm';
  final ADDR_EC = 'XyFVXiGaHxoBhXZkSh6NS2rjFyVaVNUo5UiZDqZbuSfUdji';
  final ADDR_ET = '0x54Dab85EE2c7b9F7421100d7134eFb5DfA4239bF';
  final MESSAGE = 'hello world';
  final SIG_ED =
      '0x299d3bf4c8bb51af732f8067b3a3015c0862a5ff34721749d8ed6577ea2708365d1c5f76bd519009971e41156f12c70abc2533837ceb3bad9a05a99ab923de06';
  final SIG_SR =
      '0xca01419b5a17219f7b78335658cab3b126db523a5df7be4bfc2bef76c2eb3b1dcf4ca86eb877d0a6cf6df12db5995c51d13b00e005d053b892bd09c594434288';
  final SIG_EC =
      '0x994638ee586d2c5dbd9bacacbc35d9b7e9018de8f7892f00c900db63bc57b1283e2ee7bc51a9b1c1dae121ac4f4b9e2a41cd1d6bf4bb3e24d7fed6faf6d85e0501';
  final SIG_ET =
      '0x4e35aad35793b71f08566615661c9b741d7c605bc8935ac08608dff685324d71b5704fbd14c9297d2f584ea0735f015dcf0def66b802b3f555e1db916eda4b7700';
  final MUL_ED = u8aToHex(u8aConcat([
    Uint8List.fromList([0]),
    hexToU8a(SIG_ED)
  ]));
  final MUL_SR = u8aToHex(u8aConcat([
    Uint8List.fromList([1]),
    hexToU8a(SIG_SR)
  ]));
  final MUL_EC = u8aToHex(u8aConcat([
    Uint8List.fromList([2]),
    hexToU8a(SIG_EC)
  ]));
  final MUL_ET = u8aToHex(u8aConcat([
    Uint8List.fromList([2]),
    hexToU8a(SIG_ET)
  ]));

  group('signatureVerify', () {
    test('throws on invalid signature length', () {
      expect(() => signatureVerify(MESSAGE, Uint8List(32), ADDR_ED),
          throwsA(assertionThrowsContains('Invalid signature length')));
    });

    group('verifyDetect', () {
      test('verifies an ed25519 signature', () {
        expect(signatureVerify(MESSAGE, SIG_ED, ADDR_ED).toMap(),
            {"crypto": 'ed25519', "isValid": true});
      });

      test('verifies an ecdsa signature', () {
        expect(signatureVerify(MESSAGE, SIG_EC, ADDR_EC).toMap(),
            {"crypto": 'ecdsa', "isValid": true});
      });

      test('verifies an ethereum signature', () {
        expect(signatureVerify(MESSAGE, SIG_ET, ADDR_ET).toMap(),
            {"crypto": 'ethereum', "isValid": true});
      });

      test('verifies an ethereum signature (known)', () {
        const message =
            'Pay KSMs to the Kusama account:88dc3417d5058ec4b4503e0c12ea1a0a89be200fe98922423d4334014fa6b0ee';

        expect(
            signatureVerify(
                    "\x19Ethereum Signed Message:\n${message.length.toString()}$message",
                    '0x55bd020bdbbdc02de34e915effc9b18a99002f4c29f64e22e8dcbb69e722ea6c28e1bb53b9484063fbbfd205e49dcc1f620929f520c9c4c3695150f05a28f52a01',
                    '0x002309df96687e44280bb72c3818358faeeb699c')
                .toMap(),
            {"crypto": 'ethereum', "isValid": true});
      });

      test('fails on invalid ethereum signature', () {
        expect(signatureVerify(MESSAGE, SIG_EC, ADDR_ET).toMap(),
            {"crypto": 'none', "isValid": false});
      });

      test('verifies an sr25519 signature', () {
        expect(signatureVerify(MESSAGE, SIG_SR, ADDR_SR).toMap(),
            {"crypto": 'sr25519', "isValid": true});
      });

      test('allows various inputs', () {
        expect(
            signatureVerify(stringToU8a(MESSAGE), hexToU8a(SIG_ED), decodeAddress(ADDR_ED)).toMap(),
            {"crypto": 'ed25519', "isValid": true});
      });

      test('fails on an invalid signature', () {
        expect(signatureVerify(MESSAGE, SIG_SR, ADDR_ED).toMap(),
            {"crypto": 'none', "isValid": false});
      });
    });

    group('verifyMultisig', () {
      test('verifies an ed25519 signature', () {
        expect(signatureVerify(MESSAGE, MUL_ED, ADDR_ED).toMap(),
            {"crypto": 'ed25519', "isValid": true});
      });

      test('verifies an ecdsa signature', () {
        expect(signatureVerify(MESSAGE, MUL_EC, ADDR_EC).toMap(),
            {"crypto": 'ecdsa', "isValid": true});
      });

      test('verifies an ethereum signature', () {
        expect(signatureVerify(MESSAGE, MUL_ET, ADDR_ET).toMap(),
            {"crypto": 'ethereum', "isValid": true});
      });

      test('verifies an sr25519 signature', () {
        expect(signatureVerify(MESSAGE, MUL_SR, ADDR_SR).toMap(),
            {"crypto": 'sr25519', "isValid": true});
      });

      test('fails on an invalid signature', () {
        expect(signatureVerify(MESSAGE, MUL_SR, ADDR_ED).toMap(),
            {"crypto": 'sr25519', "isValid": false});
      });
    });
  });
}
