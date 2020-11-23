import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/keyring/keyring.dart';
import 'package:p4d_rust_binding/keyring/testingPairs.dart';
import 'package:p4d_rust_binding/keyring/types.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  testingPairsTest();
}

testingPairsTest() {
  const PHRASE = 'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
  final TESTS = [
    {
      "pk": '0x46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a',
      "ss": '5DfhGyQdFobKM8NsWvEeAKk5EQQgYe9AydgJ7rMB6E1EqRzV',
      "uri": PHRASE
    },
    {
      "pk": '0xb69355deefa7a8f33e9297f5af22e680f03597a99d4f4b1c44be47e7a2275802',
      "ss": '5GC6LfpV352HtJPySfAecb5JdePtf4R9Vq49NUU8RhzgBqgq',
      "uri": "$PHRASE///password"
    },
    {
      "pk": '0x40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a',
      "ss": '5DXZzrDxHbkQov4QBAY4TjpwnHCMrKXkomTnKSw8UArBEY5v',
      "uri": "$PHRASE/foo"
    },
    {
      "pk": '0x547d4a55642ec7ebadc0bd29b6e570b8c926059b3c0655d4948075e9a7e6f31e',
      "ss": '5DyV6fZuvPemWrUqBgWwTSgoV86w6xms3KhkFU6cQcWxU8eP',
      "uri": "$PHRASE//foo"
    },
    {
      "pk": '0x3841947ffcde6f5fef26fb68b59bb8665637e30e32ec2051f99cf6b9c674fe09',
      "ss": '5DLU27is5iViNopQb2KxsTyPx6j4vCu8X3sk3j3NNLkPCqKM',
      "uri": "$PHRASE//foo/bar"
    },
    {
      "pk": '0xdc142f7476a7b0aa262aeccf207f1d18daa90762db393006741e8a31f39dbc53',
      "ss": '5H3GPTqDSpjkfDwbHy12PD6BWm8jvGSX4xYC8UMprHpTPcRg',
      "uri": "$PHRASE/foo//bar"
    },
    {
      "pk": '0xa2e56b06407a6d1e819d2fc33fa0ec604b29c2e868b70b3696bb049b8725934b',
      "ss": '5FkHmNgbg64MwStgCyDi2Uw3ufFu11mqQgmWT9uwK4Lghvpv',
      "uri": "$PHRASE//foo/bar//42/69"
    },
    {
      "pk": '0x0e0d24e3e1ff2c07f269c99e2e0df8681fda1851ac42fc846ca2daaa90cd8f14',
      "ss": '5CP8S23JBNXYNpJsL7ESPJBNnUZE6itcfM4EnDxEhaVEU6dT',
      "uri": "$PHRASE//foo/bar//42/69///password"
    },
    {
      "pk": '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
      "ss": '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      "uri": "$PHRASE//Alice"
    }
  ];
  group('testingPairs', () {
    test('creates without failing', () {
      expect(createTestPairs().length, 2 + 0 + 7); // stash, session, pairs
    });

    test('has the correct address for Alice (non-HDKD)', () {
      expect(createTestPairs(KeyringOptions(type: 'ed25519'), false)["alice"].address,
          '5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua');
    });

    test('has the correct address for Alice (HDKD)', () {
      expect(createTestPairs(KeyringOptions(type: 'ed25519'))["alice"].address,
          '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });
  });

  group('keyring.addFromUri', () {
    final keyring = Keyring(KeyringOptions(type: 'sr25519'));

    TESTS.forEach((t) {
      final uri = t["uri"];
      final ss = t["ss"];
      final pk = t["pk"];
      test("creates $uri", () {
        final pair = keyring.addFromUri(uri);
        expect(u8aToHex(pair.publicKey), pk);
        expect(pair.address, ss);
      });
    });
  });
}