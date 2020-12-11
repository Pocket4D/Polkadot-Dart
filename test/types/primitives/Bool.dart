import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Bool.dart';

void main() {
  boolTest(); // rename this test name
}

void boolTest() {
  group('Bool', () {
    final registry = TypeRegistry();

    group('decode', () {
      // eslint-disable-next-line @typescript-eslint/ban-types
      testDecode(String type, dynamic input, bool expected) {
        test("can decode from $type", () {
          expect(CodecBool(registry, input).toJSON(), expected);
        });
      }

      testDecode('Bool', CodecBool(registry, true), true);
      testDecode('Boolean', true, true);
      testDecode('boolean', true, true);
      testDecode('number', 1, true);
      testDecode('Uint8Array', Uint8List.fromList([1]), true);
      testDecode('null', null, false);
    });

    group('encode', () {
      testEncode(String to, dynamic expected, bool value) {
        final s = CodecBool(registry, value);
        test("can encode $to", () {
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

      testEncode('toJSON', true, true);
      testEncode('toHex', '0x01', true);
      testEncode('toString', 'true', true);
      testEncode('toU8a', Uint8List.fromList([1]), true);
      testEncode('toU8a', Uint8List.fromList([0]), false);
    });

    test('correctly encodes length', () {
      expect(CodecBool(registry, true).encodedLength, 1);
    });

    group('utils', () {
      test('compares against a boolean', () {
        expect(CodecBool(registry, true).eq(true), true);
      });

      test('compares against a Bool', () {
        expect(CodecBool(registry, false).eq(CodecBool(registry, false)), true);
      });

      test('has isTrue', () {
        expect(CodecBool(registry, true).isTrue, true);
      });

      test('has isFalse', () {
        expect(CodecBool(registry, true).isFalse, false);
      });

      test('has sane isEmpty aligning with the rest', () {
        expect(CodecBool(registry).isEmpty, true);
        expect(CodecBool(registry, false).isEmpty, true);
        expect(CodecBool(registry, true).isEmpty, false);
        expect(CodecBool(registry, null).isEmpty, true);
      });
    });
  });
}
