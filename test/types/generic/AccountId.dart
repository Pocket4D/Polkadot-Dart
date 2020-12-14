import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

import '../../testUtils/throws.dart';

void main() {
  accountIdTest(); // rename this test name
}

void accountIdTest() {
  group('AccountId', () {
    final registry = TypeRegistry();

    group('defaults', () {
      final id = registry.createType('AccountId');

      test('has a 32-byte length', () {
        expect(id.encodedLength, 32);
      });

      test('is empty by default', () {
        expect(id.isEmpty, true);
      });

      test('equals the empty address', () {
        expect(id.eq('5C4hrfjw9DjXZTzV3MwzrrAr9P1MJhSrvWGWqi1eSuyUpnhM'), true);
      });

      test('allows decoding from null', () {
        expect(
            registry
                .createType('AccountId', null)
                .eq('5C4hrfjw9DjXZTzV3MwzrrAr9P1MJhSrvWGWqi1eSuyUpnhM'),
            true);
      });
    });

    group('decoding', () {
      testDecode(String type, dynamic input, String expected) {
        test("can decode from $type", () {
          final a = registry.createType('AccountId', input);
          expect(a.toString(), expected);
        });
      }

      test('fails with non-32-byte lengths', () {
        expect(() => registry.createType('AccountId', '0x1234'),
            throwsA(assertionThrowsContains("Invalid AccountId provided, expected 32 bytes")));
      });

      testDecode(
          'AccountId',
          registry.createType(
              'AccountId', '0x0102030405060708010203040506070801020304050607080102030405060708'),
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode('hex', '0x0102030405060708010203040506070801020304050607080102030405060708',
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode('string', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF',
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode(
          'Raw',
          Raw(registry, [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
          ]),
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode(
          'Uint8Array',
          Uint8List.fromList([
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
          ]),
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
    });

    group('encoding', () {
      testEncode(String to, dynamic expected,
          [input = '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF']) {
        test("can encode $to", () {
          final s = AccountId.from(registry.createType('AccountId', input));
          switch (to) {
            case 'toString':
              expect(s.toString(), expected);
              break;
            case 'toHex':
              expect(s.toHex(), expected);
              break;
            case 'toJSON':
              expect(s.toJSON(), expected);
              break;
            case 'toU8a':
              expect(s.toU8a(), expected);
              break;
            default:
              break;
          }
        });
      }

      testEncode('toHex', '0x0102030405060708010203040506070801020304050607080102030405060708');
      testEncode('toJSON', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testEncode('toString', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testEncode('toString', '5C4hrfjw9DjXZTzV3MwzrrAr9P1MJhSrvWGWqi1eSuyUpnhM',
          '0x0000000000000000000000000000000000000000000000000000000000000000');
      testEncode(
          'toU8a',
          Uint8List.fromList([
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
          ]));

      test('decodes to a non-empty value', () {
        // expect(
        //     registry
        //         .createType('AccountId', '7qT1BvpawNbqb3BZaBTMFMMAKrpJKLPf1LmEHR1JyarWJdMX')
        //         .isEmpty,
        //     false);
        // print(registry
        //     .createType('IdentityFields', Uint8List.fromList([1 + 2 + 64, 0, 0, 0, 0, 0, 0, 0]))
        //     .toHuman());
      });
    });

    // group('storage decoding', () {
    //   test('has the correct entries', () {
    //     registry.setChainProperties(registry.createType('ChainProperties', {ss58Format: 68}));

    //     final data = registry.createType('StorageData', jsonVec.params.result.changes[0][1]);
    //     final list =
    //         registry.createType('Vec<AccountId>', data).map((accountId) => accountId.toString());

    //     expect(list, [
    //       '7qVJujLF3EDbZt5WfQXWvueFedMS4Vfk2Hb4GyR8jwksTLup',
    //       '7pHyqeYaJjJPgxQgCXoS2EZMhBhtpm6BLCqQ4jJZTQB2kMhw',
    //       '7pYLWV6PTUmLTMQfHmmuBwBNLkhcKhRAnkM36CSJtjat9ACb',
    //       '7qT1BvpawNbqb3BZaBTMFMMAKrpJKLPf1LmEHR1JyarWJdMX',
    //       '7rADc9JW5EUGFPWLjPMipH4c3bJ2GyAUedmqQHiaGucWVrsT',
    //       '7oK5KRH6jt4p8auipnru9ptqeuRwbLMHA2tgCViZzhmW4Lox',
    //       '7ndAVsHvonnzTg4AvRhpraNCKj9g4CGQXKoLrgkTZ91Na6PE',
    //       '7oL7VfXgLA8L3pJJwi11v3sBYc1b5R3tLrweHwzMNxgEpjxP'
    //     ]);
    //   });
    // });
  });
}
