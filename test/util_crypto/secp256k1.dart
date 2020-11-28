import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/mnemonic.dart';
import 'package:polkadot_dart/util_crypto/secp256k1.dart';
import 'package:polkadot_dart/util_crypto/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  secp256k1Test();
}

void secp256k1Test() {
  // ignore: non_constant_identifier_names
  final MESSAGE = stringToU8a('this is a message');
  test('secp256k1', () {
    const secp256k1Tests = [
      [
        'life fee table ahead modify maximum dumb such tobacco boss dry nurse',
        '0xf2360e871c830d397fe221382b503f07ddd8763df81a94bb2504390a2fb91f59',
        '0x036b0aa6beab469dd2b748a0ff5ddbe3d13df1e15c9d28a2aa057212994e127bea',
        '0xae8e8fcacbaeb607bcdf0bbd7e615f2b4ef484ee54f19d68a7393fb6db2dd9cd'
      ],
      [
        'tide survey cradle cover column ugly author wait eye state elder blame',
        '0x5385355a5118ec732b9dbcf1668ba21db38b07cf79082dafa9a7cc4b52e4abb0',
        '0x03929e4f93cdad265751ad8f6365185d8e937610d19b510400f5867d542d60a313',
        '0xf80ea815da66c42f870b687e1530770d5a7936ae81a147b009506d85bd6d621c'
      ],
      [
        'laugh fish flee cake approve butter april dynamic myth license ticket lobster',
        '0x83ec65cf9a8a7442d808aef6f8987599f1ba3be880769bb3a20621b13adbd476',
        '0x0388299e4cfaa33d180a026bd54a46ad98df129a131320a9d2fd6f80e64bc3db39',
        '0x35036238dd195f4c2169379354bda6cba5746f67bde03ef59a77a4cea80729bc'
      ],
      [
        'animal thing fork recipe exotic pilot inquiry pledge obey slab obtain reveal',
        '0x0fd50580eb5a58b0eee60c77656dffa50094b539262366f1227d3babfd7343e5',
        '0x036edc954685ad89f0a23b0fb1eb2b9c3a8600eee9091c758426dfb2bc7889a7c3',
        '0x2a94b10d1f28810dc4628e7e424b2d08bd3d17fb08f9416d112f17e86c8fa77c'
      ]
    ];

    var singleTest = hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae');
    var singleResult = KeyPair.fromMap({
      "publicKey": hexToU8a('0x03fd8c74f795ced92064b86191cb2772b1e3a0947740aa0a5a6e379592471fd85b'),
      "secretKey": hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae')
    });
    expect(secp256k1KeypairFromSeed(singleTest).toJson(), singleResult.toJson());

    secp256k1Tests.forEach((t) {
      var phrase = t[0];
      var sk = t[1];
      var pk = t[2];
      var seed = mnemonicToMiniSecret(phrase);
      var pair = secp256k1KeypairFromSeed(seed);
      expect(u8aToHex(pair.secretKey), sk);
      expect(u8aToHex(pair.publicKey), pk);
    });
    // print("\n");
  });

  test('secp256k1Expandexpands a known key', () {
    expect(
        secp256k1Expand(
            hexToU8a('0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077')),
        hexToU8a(
            '0xb9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af'));
  });

  test('secp256k1Expand expands a known full key', () {
    expect(
        secp256k1Expand(hexToU8a(
            '0x04b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af')),
        hexToU8a(
            '0xb9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af'));
  });

  group("secp256k1Hasher tests", () {
    test('fails with unknown hasher', () {
      expect(() => secp256k1Hasher('unknown', 'testing'),
          throwsA("Unsupported secp256k1 hasher unknown, expected one of blake2, keccak"));
    });

    test('creates a blake2 hash', () {
      expect(
          secp256k1Hasher('blake2', 'abc'),
          Uint8List.fromList([
            189,
            221,
            129,
            60,
            99,
            66,
            57,
            114,
            49,
            113,
            239,
            63,
            238,
            152,
            87,
            155,
            148,
            150,
            78,
            59,
            177,
            203,
            62,
            66,
            114,
            98,
            200,
            192,
            104,
            213,
            35,
            25
          ]));
    });

    test('creates a keccak hash', () {
      expect(
          secp256k1Hasher('keccak', 'abc'),
          Uint8List.fromList([
            78,
            3,
            101,
            122,
            234,
            69,
            169,
            79,
            199,
            212,
            123,
            168,
            38,
            200,
            214,
            103,
            192,
            209,
            230,
            227,
            58,
            100,
            160,
            54,
            236,
            68,
            245,
            143,
            161,
            45,
            108,
            69
          ]));
    });
    test("", () {
      // secp256k1Sign(message, keyPair)
    });
    test('validates known ETH against address', () {
      const message =
          'Pay KSMs to the Kusama account:88dc3417d5058ec4b4503e0c12ea1a0a89be200fe98922423d4334014fa6b0ee';

      expect(
          secp256k1Verify(
            "\x19Ethereum Signed Message:\n${message.length.toString()}$message",
            '0x55bd020bdbbdc02de34e915effc9b18a99002f4c29f64e22e8dcbb69e722ea6c28e1bb53b9484063fbbfd205e49dcc1f620929f520c9c4c3695150f05a28f52a01',
            '0x002309df96687e44280bb72c3818358faeeb699c',
            'keccak',
          ),
          true);
    });
  });

  group('sign and verify', () {
    test('verify message signature', () {
      final address = '0x59f587c045d4d4e9aa1016eae43770fc0551df8a385027723342753a876aeef0';
      final sig =
          '0x92fcacf0946bbd10b31dfe16d567ed1d3014e81007dd9e5256e19c0f07eacc1643b151ca29e449a765e16a7ce59b88d800467d6b3412d30ea8ad22307a59664b00';
      final msg = stringToU8a('secp256k1');
      expect(secp256k1Verify(msg, sig, address), true);
    });

    test('has 65-byte signatures', () {
      final pair = secp256k1KeypairFromSeed(randomAsU8a());

      expect(secp256k1Sign(MESSAGE, pair).length, 65);
    });

    test('signs/verifies a message by random key (blake2)', () {
      final pair = secp256k1KeypairFromSeed(randomAsU8a());
      final signature = secp256k1Sign(MESSAGE, pair);
      final address = secp256k1Hasher('blake2', pair.publicKey);
      // print("pub :${pair.publicKey.toHex()}");
      expect(secp256k1Verify(MESSAGE, signature, address), true);
    });

    test('signs/verifies a message by random key (keccak)', () {
      final pair = secp256k1KeypairFromSeed(randomAsU8a());
      final signature = secp256k1Sign(MESSAGE, pair, 'keccak');
      final address = secp256k1Hasher('keccak', secp256k1Expand(pair.publicKey));

      expect(secp256k1Verify(MESSAGE, signature, address, 'keccak'), true);
    });

    test('fails verification on hasher mismatches', () {
      final pair = secp256k1KeypairFromSeed(randomAsU8a());
      final signature = secp256k1Sign(MESSAGE, pair, 'keccak');
      final address = secp256k1Hasher('keccak', secp256k1Expand(pair.publicKey));

      expect(secp256k1Verify(MESSAGE, signature, address, 'blake2'), false);
    });

    test('works over a range of random keys (blake2)', () {
      for (var i = 0; i < 16; i++) {
        final pair = secp256k1KeypairFromSeed(randomAsU8a());

        try {
          expect(
              secp256k1Verify(MESSAGE, secp256k1Sign(MESSAGE, pair, 'blake2'),
                  secp256k1Hasher('blake2', pair.publicKey), 'blake2'),
              true);
        } catch (error) {
          print("blake2 failed on #$i");
          throw error;
        }
      }
    });

    test('works over a range of random keys (keccak)', () {
      for (var i = 0; i < 16; i++) {
        final pair = secp256k1KeypairFromSeed(randomAsU8a());

        try {
          expect(
              secp256k1Verify(MESSAGE, secp256k1Sign(MESSAGE, pair, 'keccak'),
                  secp256k1Hasher('keccak', secp256k1Expand(pair.publicKey)), 'keccak'),
              true);
        } catch (error) {
          print("keccak failed on #$i");
          throw error;
        }
      }
    });
  });
}
