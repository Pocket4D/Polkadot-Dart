import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/address.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../testUtils/throws.dart';

void main() {
  addressTest();
}

void addressTest() {
  // test('can re-encode an address', () {
  //   expect(encodeAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY', 68),
  //       '7sL6eNJj5ZGV5cn3hhV2deRUsivXfBfMH76wCALCqWj1EKzv');
  // });
  group('addressToEvm', () {
    test('creates a valid known EVM address', () {
      expect(addressToEvm('KWCv1L3QX9LDPwY4VzvLmarEmXjVJidUzZcinvVnmxAJJCBou'),
          hexToU8a('0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee9'));
    });
  });
  group('checkAddress', () {
    test('returns [true, null] for Kusama', () {
      expect(checkAddress('FJaco77EJ99VtBmVFibuBJR3x5Qq9KQrgQJvWjqScCcCCae', 2), [true, null]);
    });

    test('returns [true, null] for Substrate', () {
      expect(checkAddress('5EnxxUmEbw8DkENKiYuZ1DwQuMoB2UWEQJZZXrTsxoz7SpgG', 42), [true, null]);
    });

    test('fails when an invalid base58 character is supplied', () {
      expect(checkAddress('5EnxIUmEbw8DkENKiYuZ1DwQuMoB2UWEQJZZXrTsxoz7SpgG', 2)[1] as String,
          contains('Invalid base58 character'));
    });

    test('fails with invalid prefix when checking Substrate against Kusama prefix', () {
      expect(checkAddress('5EnxxUmEbw8DkENKiYuZ1DwQuMoB2UWEQJZZXrTsxoz7SpgG', 2),
          [false, 'Prefix mismatch, expected 2, found 42']);
    });

    test('fails with invalid length when some bytes are missing', () {
      expect(checkAddress('y9EMHt34JJo4rWLSaxoLGdYXvjgSXEd4zHUnQgfNzwES8b', 42),
          [false, 'Invalid decoded address length']);
    });

    test('fails with invalid length on checksum mismatch', () {
      expect(checkAddress('5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaDwU', 42),
          [false, 'Invalid decoded address checksum']);
    });
  });

  group('decodeAddress', () {
    // let keyring: TestKeyringMap;

    // beforeAll(() {
    //   keyring = createTestPairs({ type: 'sr25519' });
    // });

    // test('decodes an address', () {
    //   expect(decodeAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'),
    //       keyring.alice.publicKey);
    // });

    test('decodes the council address', () {
      expect(u8aToHex(decodeAddress('F3opxRbN5ZbjJNU511Kj2TLuzFcDq9BGduA9TgiECafpg29')),
          u8aToHex(stringToU8a('modlpy/trsry'.padRight(32, "\u{0}"))));
    });

    test('converts a publicKey (u8a) as-is', () {
      expect(decodeAddress(Uint8List.fromList([1, 2, 3])), Uint8List.fromList([1, 2, 3]));
    });

    test('converts a publicKey (hex) as-is', () {
      expect(decodeAddress('0x01020304'), Uint8List.fromList([1, 2, 3, 4]));
    });

    test('decodes a short address', () {
      expect(decodeAddress('F7NZ'), Uint8List.fromList([1]));
    });

    test('decodes a 1-byte accountId (with prefix)', () {
      expect(decodeAddress('PqtB', ignoreChecksum: false, ss58Format: 68), Uint8List.fromList([1]));
    });

    test('decodes a 2-byte accountId', () {
      expect(decodeAddress('2jpAFn', ignoreChecksum: false, ss58Format: 68),
          Uint8List.fromList([0, 1]));
    });

    test('encodes a 4-byte address', () {
      expect(decodeAddress('as7QnGMf', ignoreChecksum: false, ss58Format: 68),
          Uint8List.fromList([1, 2, 3, 4]));
    });

    test('decodes a 8-byte address', () {
      expect(decodeAddress('4q7qY5RBG7Z4wv', ignoreChecksum: false, ss58Format: 68),
          Uint8List.fromList([42, 44, 10, 0, 0, 0, 0, 0]));
    });

    test('decodes a 33-byte address', () {
      expect(decodeAddress('KWCv1L3QX9LDPwY4VzvLmarEmXjVJidUzZcinvVnmxAJJCBou'),
          hexToU8a('0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077'));
    });

    test('allows invalid prefix (in list)', () {
      expect(() => decodeAddress('6GfvWUvHvU8otbZ7sFhXH4eYeMcKdUkL61P3nFy52efEPVUx'),
          throwsA(assertionThrowsContains("Invalid decoded address checksum")));
    });

    test('fails when length is invalid', () {
      expect(() => decodeAddress('y9EMHt34JJo4rWLSaxoLGdYXvjgSXEd4zHUnQgfNzwES8b'),
          throwsA(assertionThrowsContains("address length")));
    });

    test('fails when the checksum does not match', () {
      expect(() => decodeAddress('5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMa9cj'),
          throwsA(assertionThrowsContains("address checksum")));
      expect(() => decodeAddress('5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaDwU'),
          throwsA(assertionThrowsContains("address checksum")));
    });

    test('fails when invalid base58 encoded address is found', () {
      expect(() => u8aToHex(decodeAddress('F3opIRbN5ZbjJNU511Kj2TLuzFcDq9BGduA9TgiECafpg29')),
          throwsA(contains("Invalid base58 character")));
    });
  });
  group('deriveAddress', () {
    test('derives a known path', () {
      expect(deriveAddress('5CZtJLXtVzrBJq1fMWfywDa6XuRwXekGdShPR4b8i9GWSbzB', '/joe/polkadot/0'),
          '5GZ4srnepXvdsuNVoxCGyVZd8ScDm4gkGLTKuaGARy9akjTa');
    });

    test('fails on hard paths', () {
      expect(
          () => deriveAddress('5CZtJLXtVzrBJq1fMWfywDa6XuRwXekGdShPR4b8i9GWSbzB', '//bob'),
          throwsA(
              assertionThrowsContains("Expected suri to contain a combination of non-hard paths")));
    });
  });

  group('encode', () {
    // test('encodes an address to a valid value', () {
    //   expect(
    //     keyring.alice.address
    //   ,'5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua');
    // });

    test('can re-encode an address', () {
      expect(encodeAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY', 68),
          '7sL6eNJj5ZGV5cn3hhV2deRUsivXfBfMH76wCALCqWj1EKzv');
    });

    test('can re-encode an address to Polkadot live', () {
      expect(encodeAddress('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY', 0),
          '15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5');
    });

    // test('fails when non-valid publicKey provided', () {
    //   expect(
    //     () => encodeAddress(
    //       keyring.alice.publicKey.slice(0, 30)
    //     )
    //   ).toThrow(/Expected a valid key/);
    // });

    test('encodes a 1-byte address', () {
      expect(encodeAddress(Uint8List.fromList([1])), 'F7NZ');
    });

    test('encodes a 1-byte address (with prefix)', () {
      expect(encodeAddress(Uint8List.fromList([1]), 68), 'PqtB');
    });

    test('encodes a 2-byte address', () {
      expect(encodeAddress(Uint8List.fromList([0, 1]), 68), '2jpAFn');
    });

    test('encodes a 4-byte address', () {
      expect(encodeAddress(Uint8List.fromList([1, 2, 3, 4]), 68), 'as7QnGMf');
    });

    test('encodes a 8-byte address', () {
      expect(encodeAddress(Uint8List.fromList([42, 44, 10, 0, 0, 0, 0, 0]), 68), '4q7qY5RBG7Z4wv');
    });

    test('encodes an 33-byte address', () {
      expect(encodeAddress('0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077'),
          'KWCv1L3QX9LDPwY4VzvLmarEmXjVJidUzZcinvVnmxAJJCBou');
    });
  });

  group('encodeDerivedAddress', () {
    test('creates a valid known derived address', () {
      expect(encodeDerivedAddress('5GvUh7fGKsdBEh5XpypkfkGuf7j3vXLxH9BdxjxnJNVXRYi1', 0),
          '5E5XxqPxm7QbEs6twYfp3tyjXidn4kqRrNPH4o6JK9JSLUeD');
    });
  });

  group('encodeMultiAddress', () {
    test('creates a valid known multi address', () {
      expect(
          encodeMultiAddress([
            '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
            '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
            '5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y'
          ], 2),
          '5DjYJStmdZ2rcqXbXGX7TW85JsrW6uG4y9MUcLq2BoPMpRA7');
    });
  });
  group('addressEq', () {
    test('returns false with non-equal', () {
      expect(
          addressEq('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
              '5EnxxUmEbw8DkENKiYuZ1DwQuMoB2UWEQJZZXrTsxoz7SpgG'),
          false);
    });

    test('returns true for equal, matching prefix', () {
      expect(
          addressEq('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
              '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'),
          true);
    });

    test('returns true for equal, non-matching prefix', () {
      expect(
          addressEq('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
              '7sL6eNJj5ZGV5cn3hhV2deRUsivXfBfMH76wCALCqWj1EKzv'),
          true);
    });

    // test('returns true for equal, address vs publicKey', () {
    //   const keyring = createTestPairs({ type: 'sr25519' });

    //   expect(
    //     addressEq(
    //       '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
    //       keyring.alice.publicKey
    //     )
    //   ,true);
    // });
  });

  group('sortAddresses', () {
    test('sorts addresses by the publicKeys', () {
      expect(
          sortAddresses([
            '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
            '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
            '5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y'
          ]),
          [
            '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
            '5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y',
            '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'
          ]);
    });
  });
}
