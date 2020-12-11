import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Text.dart';

import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  textTest(); // rename this test name
}

void textTest() {
  group('Text', () {
    final registry = TypeRegistry();

    group('decode', () {
      testDecode(String to, dynamic input, String expected, [String toFn]) {
        final s = CodecText(registry, input);
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

      testDecode('string', 'foo', 'foo');
      testDecode('Text', CodecText(registry, 'foo'), 'foo');
      testDecode('Uint8Array', Uint8List.fromList([12, 102, 111, 111]), 'foo');
      testDecode('Raw', Raw(registry, Uint8List.fromList([102, 111, 111])), 'foo'); // no length
      testDecode(
          'object with "toString()"',
          {
            "toString": () {
              return 'foo';
            }
          },
          'foo');
      testDecode('hex input value', CodecText(registry, '0x12345678'), '0x12345678', 'toHex');
      testDecode('null', null, '');
    });

    group('encode', () {
      testEncode(String to, dynamic expected) {
        test("can encode $to", () {
          final s = CodecText(registry, 'foo');
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

      testEncode('toHex', '0x666f6f');
      testEncode('toString', 'foo');
      testEncode('toU8a', Uint8List.fromList([12, 102, 111, 111]));
    });

    group('utils', () {
      test('compares actual string values', () {
        expect(CodecText(registry, '123').eq('123'), true);
      });

      test('compares actual String values', () {
        expect(CodecText(registry, 'XYX').eq(('XYX')), true);
      });

      test('compares actual non-string values (fails)', () {
        expect(CodecText(registry, '123').eq(123), false);
      });

      test('calulates the length & encoded length correctly for ASCII', () {
        final test = CodecText(registry, 'abcde');

        expect(test.encodedLength, 6);
        // expect(test).toHaveLength(5);
      });

      test('calulates the length & encoded length correctly for non-ASCII', () {
        final test = CodecText(registry, '中文');

        expect(test.encodedLength, 7);
        // expect(test).toHaveLength(2);
      });
    });
  });
}
