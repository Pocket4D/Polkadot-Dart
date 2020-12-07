import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  rawTest(); // rename this test name
}

void rawTest() {
  final registry = TypeRegistry();
  testDecode(String type, dynamic input, String expected) {
    test("can decode from $type", () {
      final e = new Raw(registry, input);

      expect(e.toString(), expected);
    });
  }

  testEncode(String to, dynamic expected) {
    test("can encode $to", () {
      final s = new Raw(registry, [1, 2, 3, 4, 5]);
      switch (to) {
        case 'toHex':
          expect(s.toHex(), expected);
          break;
        case 'toJSON':
          expect(s.toJSON(), expected);
          break;
        case 'toString':
          expect(s.toString(), expected);
          break;
        case 'toU8a':
          expect(s.toU8a(), expected);
          break;
        default:
          break;
      }
    });
  }

  final u8a = new Raw(registry, [1, 2, 3, 4, 5]);
  group('Raw', () {
    testDecode('Array', [1, 2, 3, 4, 5], '0x0102030405');
    testDecode('hex', '0x0102030405', '0x0102030405');
    testDecode('U8a', Uint8List.fromList([1, 2, 3, 4, 5]), '0x0102030405');
    testDecode('Uint8Array', Uint8List.fromList([1, 2, 3, 4, 5]), '0x0102030405');

    testEncode('toJSON', '0x0102030405');
    testEncode('toHex', '0x0102030405');
    testEncode('toString', '0x0102030405');
    testEncode('toU8a', Uint8List.fromList([1, 2, 3, 4, 5]));

    test('contains the length of the elements', () {
      expect(u8a.length, 5);
    });

    test('correctly encodes length', () {
      expect(u8a.encodedLength, 5);
    });

    test('allows wrapping of a pre-existing instance', () {
      expect(Raw(registry, u8a).length, 5);
    });

    test('implements subarray correctly', () {
      expect(u8a.subarray(1, 3), Uint8List.fromList([2, 3]));
    });
  });
  group('utils', () {
    test('compares against other U8a', () {
      expect(u8a.eq(Uint8List.fromList([1, 2, 3, 4, 5])), true);
    });

    test('compares against other U8a (non-length)', () {
      expect(u8a.eq(Uint8List.fromList([1, 2, 3, 4])), false);
    });

    test('compares against other U8a (mismatch)', () {
      expect(u8a.eq(Uint8List.fromList([1, 2, 3, 4, 6])), false);
    });

    test('compares against hex inputs', () {
      expect(u8a.eq('0x0102030405'), true);
    });

    test('has valid isAscii', () {
      expect(u8a.isAscii, false);
      expect(new Raw(registry, '0x2021222324').isAscii, true);
    });

    test('has valid toUtf8', () {
      expect(new Raw(registry, 'Приветствую, ми').toUtf8(), 'Приветствую, ми');
      expect(new Raw(registry, '0xe4bda0e5a5bd').toUtf8(), '你好');
    });

    test('throws on invalid utf8', () {
      expect(
          () => new Raw(
                  registry, '0x7f07b1f87709608bee603bbc79a0dfc29cd315c1351a83aa31adf7458d7d3003')
              .toUtf8(),
          throwsA(assertionThrowsContains("The character sequence is not a valid Utf8 string")));
    });
  });
}
