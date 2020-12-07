import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  setTest(); // rename this test name
}

void setTest() {
  final SET_FIELDS = {
    "header": int.parse("00000001", radix: 2),
    "body": int.parse("00000010", radix: 2),
    "receipt": int.parse("00000100", radix: 2),
    "messageQueue": int.parse("00001000", radix: 2),
    "justification": int.parse("00010000", radix: 2)
  };
  final SET_ROLES = {
    "none": int.parse("00000000", radix: 2),
    "full": int.parse("00000001", radix: 2),
    "light": int.parse("00000010", radix: 2),
    "authority": int.parse("00000100", radix: 2)
  };
  final SET_WITHDRAW = {
    "TransactionPayment": int.parse("00000001", radix: 2),
    "Transfer": int.parse("00000010", radix: 2),
    "Reserve": int.parse("00000100", radix: 2),
    "Fee": int.parse("00001000", radix: 2)
  };
  final registry = TypeRegistry();
  group('Set', () {
    test('constructs via an string[]', () {
      final theSet = new CodecSet(registry, SET_ROLES, ['full', 'authority']);

      expect(theSet.isEmpty, false);
      expect(theSet.toString(), '[full, authority]');
    });

    test('throws with invalid values', () {
      expect(() => new CodecSet(registry, SET_ROLES, ['full', 'authority', 'invalid']),
          throwsA(assertionThrowsContains("Invalid key 'invalid'")));
    });

    test('throws with add on invalid', () {
      expect(() => (new CodecSet(registry, SET_ROLES, [])).add('invalid'),
          throwsA(assertionThrowsContains("Invalid key 'invalid'")));
    });

    test('allows construction via number', () {
      expect(
          (new CodecSet(registry, SET_WITHDRAW, 15))
              .eq(['TransactionPayment', 'Transfer', 'Reserve', 'Fee']),
          true);
    });

    test('does not allow invalid number', () {
      expect(() => new CodecSet(registry, SET_WITHDRAW, 31),
          throwsA(assertionThrowsContains("Mismatch decoding '31', computed as '15'")));
    });

    test('hash a valid encoding', () {
      final theSet = new CodecSet(registry, SET_FIELDS, ['header', 'body', 'justification']);

      expect(theSet.toU8a(), new Uint8List.fromList([19]));
    });

    group('utils', () {
      final theSet = new CodecSet(registry, SET_ROLES, ['full', 'authority']);

      test('compares against string array', () {
        expect(theSet.eq(['authority', 'full']), true);
      });

      test('compares against number (encoded)', () {
        expect(theSet.eq(SET_ROLES["full"] | SET_ROLES["authority"]), true);
      });

      test('compares against other sets', () {
        expect(theSet.eq(new CodecSet(registry, SET_ROLES, ['authority', 'full'])), true);
      });

      test('returns false on other values', () {
        expect(theSet.eq('full'), false);
      });
    });

    test('has a sane toRawType representation', () {
      expect(
          new CodecSet(registry, {"a": 1, "b": 2, "c": 345}).toRawType(),
          jsonEncode({
            "_set": {"a": 1, "b": 2, "c": 345}
          }));
    });
  });
}
