import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/types/types.dart';

void main() {
  lookupSourceTest(); // rename this test name
}

void lookupSourceTest() {
  group('LookupSource', () {
    final registry = new TypeRegistry();

    testDecode(String type, dynamic input, String expected) {
      test("can decode from $type", () {
        final a = registry.createType('Address', input);

        expect(a.toString(), expected);
      });
    }

    group('utility', () {
      test('equals on AccountId', () {
        const addr = '5DkQbYAExs3M2sZgT1Ec3mKfZnAQCL4Dt9beTCknkCUn5jzo';

        expect(registry.createType('LookupSource', addr).eq(addr), true);
      });

      test('equals on AccountIndex', () {
        // see the test below - these are equivalent (with different prefix encoding)
        expect(registry.createType('LookupSource', '2jpAFn').eq('25GUyv'), true);
      });
    });

    group('decoding', () {
      testDecode(
          'Address',
          registry.createType('LookupSource', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF'),
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode(
          'AccountId',
          registry.createType('AccountId', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF'),
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode(
          'AccountIndex (mixed prefixes)',
          registry.createType('LookupSource', '2jpAFn'),
          // NOTE Expected adress here is encoded with prefix 42, input above with 68
          '25GUyv');
      testDecode('AccountIndex (hex)', registry.createType('AccountIndex', '0x0100'), '25GUyv');
      testDecode(
          'Array',
          [
            255,
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
          ],
          '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testDecode(
          'Uint8Array (with prefix 255)',
          Uint8List.fromList([
            255,
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
      testDecode('Uint8Array (with prefix 1 byte)', Uint8List.fromList([1]), 'F7NZ');
      testDecode('Uint8Array (with prefix 2 bytes)', Uint8List.fromList([0xfc, 0, 1]), '25GUyv');
      testDecode('Uint8Array (with prefix 4 bytes)', Uint8List.fromList([0xfd, 17, 18, 19, 20]),
          'Mwz15xP2');
      // FIXME The specification allows for 8 byte addresses, however since AccountIndex is u32 internally
      // (and defined that way in the default Substrate),this does not actually work since it is 8 bytes,
      // instead of 4 bytes max u32 length
      // testDecode('Uint8Array (with prefix 8 bytes)',
      //     Uint8List.fromList([0xfe, 17, 18, 19, 20, 21, 22, 23, 24]), '3N5RJXxM5fLd4h');
    });

    group('encoding', () {
      testEncode(String to, dynamic expected) {
        test("can encode $to", () {
          //test(`can encode ${to}`
          final s =
              registry.createType('Address', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
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

      testEncode('toHex', '0xff0102030405060708010203040506070801020304050607080102030405060708');
      testEncode('toString', '5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF');
      testEncode(
          'toU8a',
          Uint8List.fromList([
            255,
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
    });
  });
}
