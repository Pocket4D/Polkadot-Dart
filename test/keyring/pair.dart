import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/keyring/pair.dart';
import 'package:p4d_rust_binding/keyring/testingPairs.dart';
import 'package:p4d_rust_binding/keyring/types.dart';
import 'package:p4d_rust_binding/util_crypto/util_crypto.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

import '../testUtils/throws.dart';

void main() {
  pairTest();
  pair2();
}

void pairTest() {
  // ignore: non_constant_identifier_names
  final PKCS8_LENGTH = PKCS8_DIVIDER.length + PKCS8_HEADER.length + PUB_LENGTH + SEC_LENGTH;
  // ignore: non_constant_identifier_names
  final ENCODED_LENGTH = 16 + PKCS8_LENGTH + NONCE_LENGTH + SCRYPT_LENGTH;

  group('encode', () {
    final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
    test('returns PKCS8 when no passphrase supplied', () async {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      final alice = keyring["alice"];
      expect((await alice.encodePkcs8()).length, PKCS8_LENGTH);
    });

    test('returns encoded PKCS8 when passphrase supplied', () async {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      final alice = keyring["alice"];
      expect((await alice.encodePkcs8('testing')).length, ENCODED_LENGTH);
    });
  });

  group('toJson', () {
    final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
    test('creates an unencoded output with no passphrase', () async {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      final json = await keyring["alice"].toJson();
      expect(json.toMap(), {
        ...json.toMap(),
        "address": '5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua',
        "encoded":
            'MFMCAQEwBQYDK2VwBCIEIEFsaWNlICAgICAgICAgICAgICAgICAgICAgICAgICAg0XKnTNpMhlkSwyugqApXrmmrrkEOXMtZ3uhOL0Qy20+hIwMhANFyp0zaTIZZEsMroKgKV65pq65BDlzLWd7oTi9EMttP',
        "encoding": {
          "content": ['pkcs8', 'ed25519'],
          "type": ['none'],
          "version": '3'
        },
        "meta": {"isTesting": true, "name": 'alice'},
      });
    });

    test('creates an encoded output with passphrase', () async {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      final json = await keyring["alice"].toJson('testing');
      expect(json.encoded.length, 268);
      expect(json.toMap(), {
        ...json.toMap(),
        "address": '5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua',
        "encoding": {
          "content": ['pkcs8', 'ed25519'],
          "type": ['scrypt', 'xsalsa20-poly1305'],
          "version": '3'
        },
      });
    });
  });
  group('decode', () {
    final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
    test('fails when no data provided', () {
      expect(() async => await keyring["alice"].decodePkcs8(null),
          throwsA(assertionThrowsContains("No encrypted data available")));
    });

    test('returns correct publicKey from encoded', () async {
      const PASS = 'testing';
      expect(
          () async =>
              await keyring["alice"].decodePkcs8(PASS, await keyring["alice"].encodePkcs8(PASS)),
          returnsNormally);
    });
  });
}

void pair2() {
  group('pair', () {
    final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
    // ignore: non_constant_identifier_names
    final SIGNATURE = Uint8List.fromList([
      80,
      191,
      198,
      147,
      225,
      207,
      75,
      88,
      126,
      39,
      129,
      109,
      191,
      38,
      72,
      181,
      75,
      254,
      81,
      143,
      244,
      79,
      237,
      38,
      236,
      141,
      28,
      252,
      134,
      26,
      169,
      234,
      79,
      33,
      153,
      158,
      151,
      34,
      175,
      188,
      235,
      20,
      35,
      135,
      83,
      120,
      139,
      211,
      233,
      130,
      1,
      208,
      201,
      215,
      73,
      80,
      56,
      98,
      185,
      196,
      11,
      8,
      193,
      14
    ]);

    test('has a publicKey', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      expect(
          keyring["alice"].publicKey,
          Uint8List.fromList([
            209,
            114,
            167,
            76,
            218,
            76,
            134,
            89,
            18,
            195,
            43,
            160,
            168,
            10,
            87,
            174,
            105,
            171,
            174,
            65,
            14,
            92,
            203,
            89,
            222,
            232,
            78,
            47,
            68,
            50,
            219,
            79
          ]));
      expect(
          keyring["alice"].addressRaw,
          Uint8List.fromList([
            209,
            114,
            167,
            76,
            218,
            76,
            134,
            89,
            18,
            195,
            43,
            160,
            168,
            10,
            87,
            174,
            105,
            171,
            174,
            65,
            14,
            92,
            203,
            89,
            222,
            232,
            78,
            47,
            68,
            50,
            219,
            79
          ]));
    });

    test('allows signing', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      expect(keyring["alice"].sign(Uint8List.fromList([0x61, 0x62, 0x63, 0x64])), SIGNATURE);
    });

    test('validates a correctly signed message', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      expect(
          keyring["alice"].verify(Uint8List.fromList([0x61, 0x62, 0x63, 0x64]), SIGNATURE), true);
    });

    test('fails a correctly signed message (message changed)', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      expect(keyring["alice"].verify(Uint8List.fromList([0x61, 0x62, 0x63, 0x64, 0x65]), SIGNATURE),
          false);
    });

    test('allows setting/getting of meta', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      var bob = keyring["bob"];
      bob.setMeta({"foo": 'bar', "something": 'else'});

      expect(bob.meta, {
        ...bob.meta,
        "foo": 'bar',
        "something": 'else',
      });

      bob.setMeta({"something": 'thing'});

      expect(bob.meta, {...bob.meta, "foo": 'bar', "something": 'thing'});
    });

    // test('allows encoding of address with different prefixes', () {
    //   expect(keyring["alice"].address,
    //     '5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua'
    //   );

    //  setSS58Format(68);

    //   expect(keyring["alice"].address,
    //     '7sGUeMak588SPY2YMmmuKUuLz7u2WQpf74F9dCFtSLB2td9d'
    //   );

    //   setSS58Format(42);
    // });

    test('allows getting public key after decoding', () async {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      // ignore: non_constant_identifier_names
      final PASS = 'testing';
      final encoded = await keyring["alice"].encodePkcs8(PASS);

      final pair = createPair(Setup(toSS58: encodeAddress, type: 'sr25519'),
          PairInfo(publicKey: keyring["alice"].publicKey));

      await pair.decodePkcs8(PASS, encoded);

      expect(pair.isLocked, false);
    });

    test('allows derivation on the pair', () {
      final alice = createPair(Setup(toSS58: encodeAddress, type: 'sr25519'),
          PairInfo(publicKey: PAIRS[0]["publicKey"], secretKey: PAIRS[0]["secretKey"]), {});
      final stash = alice.derive('//stash');
      final soft = alice.derive('//funding/0');

      expect(stash.publicKey, PAIRS[1]["publicKey"]);
      expect(soft.address, '5ECQNn7UueWHPFda5qUi4fTmTtyCnPvGnuoyVVSj5CboJh9J');
    });

    test('fails to sign when locked', () {
      // final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
      final pair = createPair(Setup(toSS58: encodeAddress, type: 'sr25519'),
          PairInfo(publicKey: keyring["alice"].publicKey));

      expect(pair.isLocked, true);
      expect(() => pair.sign(Uint8List.fromList([0])),
          throwsA(assertionThrowsContains('Cannot sign with a locked key pair')));
    });

    group('ethereum', () {
      test('has a valid address from a known public', () {
        final pair = createPair(
            Setup(toSS58: encodeAddress, type: 'ethereum'),
            PairInfo(
                publicKey: hexToU8a(
                    '0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077')));

        expect(pair.address, '0x4119b2e6c3Cb618F4f0B93ac77f9BeeC7FF02887');
        expect(pair.addressRaw, hexToU8a('0x4119b2e6c3Cb618F4f0B93ac77f9BeeC7FF02887'));
      });
    });
  });
}
