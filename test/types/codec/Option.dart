import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  optionTest(); // rename this test name
}

void optionTest() {
  final registry = TypeRegistry();
  testDecode(String testType, dynamic input, String expected) {
    final o = Option(registry, CodecText.constructor, input);
    expect(o.toString(), expected);
  }

  testEncode(String testType, dynamic expected) {
    final o = Option(registry, CodecText.constructor, 'foo');
    switch (testType) {
      case "toString":
        expect(o.toString(), expected);
        break;
      case "toHex":
        expect(o.toHex(), expected);
        break;
      case "toU8a":
        expect(u8aEq(o.toU8a(), expected), true);
        break;
      default:
        break;
    }
  }

  group('Option', () {
    test('converts undefined/null to empty', () {
      expect(Option(registry, CodecText.constructor, null).isNone, true);
      expect(Option(registry, CodecText.constructor, null).isNone, true);
      expect(Option(registry, CodecText.constructor, 'test').isNone, false);
    });

    test('converts an option to an option', () {
      expect(
          Option(registry, CodecText.constructor, Option(registry, CodecText.constructor, 'hello'))
              .toString(),
          "hello");
    });

    // TODO : have to make createType and createClass work in TypeRegistry
    // test('converts an option to an option (strings)', () {
    //   expect(Option(registry, 'Text', Option(registry, 'Text', 'hello')).toString(), 'hello');
    // });

    test('converts correctly from hex with toHex (Bytes)', () {
      // Option<Bytes> for a parachain head, however, this is effectively an
      // Option<Option<Bytes>> (hence the length, since it is from storage)
      const HEX =
          '0x210100000000000000000000000000000000000000000000000000000000000000000000000000000000011b4d03dd8c01f1049143cf9c4c817e4b167f1d1b83e5c6f0f10d89ba1e7bce';

      // watch the hex prefix and length
      expect(Option(registry, Bytes.constructor, HEX).toHex().substring(6), HEX.substring(2));
    });

    test('converts correctly from hex with toNumber (U64)', () {
      const HEX = '0x12345678';

      expect((Option(registry, u32.constructor, HEX).unwrap() as u32).value.toInt(), 0x12345678);
    });

    test('decodes reusing instanciated inputs', () {
      final foo = CodecText(registry, 'bar');

      expect((Option(registry, CodecText.constructor, foo)).value, foo);
    });

    test('test decode with different inputs', () {
      testDecode('string (with)', 'foo', 'foo');
      testDecode('string (without)', null, '');
      testDecode('Uint8Array (with)', Uint8List.fromList([1, 12, 102, 111, 111]), 'foo');
      testDecode('Uint8Array (without)', Uint8List.fromList([0]), '');
    });

    test('test encode with different inputs', () {
      testEncode('toHex', '0x0c666f6f');
      testEncode('toString', 'foo');
      testEncode('toU8a', Uint8List.fromList([1, 12, 102, 111, 111]));
    });

    test('has empty toString() (undefined)', () {
      expect(Option(registry, CodecText.constructor).toString(), '');
    });

    test('has value toString() (provided)', () {
      expect(
          Option(registry, CodecText.constructor, Uint8List.fromList([1, 4 << 2, 49, 50, 51, 52]))
              .toString(),
          '1234');
    });

    test('converts toU8a() with', () {
      expect(Option(registry, CodecText.constructor, '1234').toU8a(),
          Uint8List.fromList([1, 4 << 2, 49, 50, 51, 52]));
    });

    test('converts toU8a() without', () {
      expect(Option(registry, CodecText.constructor).toU8a(), Uint8List.fromList([0]));
    });

    group('utils', () {
      final testStr = Option(registry, CodecText.constructor, '1234');

      test('compares against other option', () {
        expect(testStr.eq(Option(registry, CodecText.constructor, '1234')), true);
      });

      test('compares against raw value', () {
        expect(testStr.eq('1234'), true);
      });

      test('unwrapOr to specified if empty', () {
        expect(Option(registry, CodecText.constructor).unwrapOr('6789').toString(), '6789');
      });

      test('unwrapOr to specified if non-empty', () {
        expect(Option(registry, CodecText.constructor, '1234').unwrapOr(null)?.toString(), '1234');
      });

      test('unwrapOrDefault to default if empty', () {
        expect((Option(registry, u32.constructor).unwrapOrDefault() as u32).value.toInt(), 0);
      });

      test('unwrapOrDefault to specified if non-empty', () {
        expect((Option(registry, u32.constructor, '1234').unwrapOrDefault() as u32).value.toInt(),
            1234);
      });
    });
  });
}
