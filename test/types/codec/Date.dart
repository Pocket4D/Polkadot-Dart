import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  dateTest(); // rename this test name
}

void dateTest() {
  final registry = TypeRegistry();
  group('decoding', () {
    testDecode(String type, dynamic input, dynamic expected, [bool toJSON = false]) {
      test("can decode from $type", () {
        final s = CodecDate(registry, input);
        var val;
        if (toJSON) {
          val = s.toJSON();
        } else {
          val = s.toISOString();
        }
        expect(val, expected);
      });
    }

    testDecode(
        'Date', DateTime.fromMillisecondsSinceEpoch(1537968546280), '2018-09-26T13:29:06.280Z');
    testDecode('CodecDate', CodecDate(registry, 1234), 1234, true);
    testDecode('number', 1234, 1234, true);
    testDecode('U64', u64(registry, 69), 69, true);
  });

  group('encoding multiple values', () {
    testEncode(String to, dynamic expected) {
      test("can encode $to", () {
        final s = CodecDate(registry, 421);
        switch (to) {
          case 'toBigInt':
            expect(s.toBigInt(), expected);
            break;
          case 'toBn':
            expect(s.toBn(), expected);
            break;
          case 'toNumber':
            expect(s.toNumber(), expected);
            break;
          case 'toHex':
            expect(s.toHex(), expected);
            break;
          case 'toJSON':
            expect(s.toJSON(), expected);
            break;
          case 'toISOString':
            expect(s.toISOString(), expected);
            break;
          case 'toU8a':
            expect(s.toU8a(), expected);
            break;
          default:
            break;
        }
      });
    }

    testEncode('toBigInt', BigInt.from(421));
    testEncode('toBn', BigInt.from(421));
    testEncode('toJSON', 421);
    testEncode('toISOString', '1970-01-01T00:07:01.000Z');

    testEncode('toNumber', 421);
    testEncode('toU8a', Uint8List.fromList([165, 1, 0, 0, 0, 0, 0, 0]));

    test('can encode toString', () {
      /// In javascript Date.UTC(year,month,...), month here is 0..11,
      /// In dart, here is natrual month between 0..12
      var date = DateTime.utc(1970, 1, 1, 2, 3, 4);
      var offset = (date.toLocal().timeZoneOffset).inSeconds * 60 * 1000;
      date.add(Duration(milliseconds: offset));
      expect(CodecDate(registry, date).toString().startsWith("1970-01-01 02:03:04"), true);
    });

    test('encodes default BE hex', () {
      expect(CodecDate(registry, 3).toHex(), '0x0000000000000003');
    });

    test('encodes options LE hex', () {
      expect(CodecDate(registry, 3).toHex(true), '0x0300000000000000');
    });
  });

  group('utils', () {
    test('compares values', () {
      expect(CodecDate(registry, 123).eq(123), true);
    });

    test('compares values (non-match)', () {
      expect(CodecDate(registry, 123).eq(456), false);
    });
  });
}
