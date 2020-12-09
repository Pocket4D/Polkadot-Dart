import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  btreeSetTest(); // rename this test name
}

void btreeSetTest() {
  final registry = TypeRegistry();
  final mockU32Set = Set<u32>();
  mockU32Set.add(u32(registry, 2));
  mockU32Set.add(u32(registry, 24));
  mockU32Set.add(u32(registry, 30));
  mockU32Set.add(u32(registry, 80));
  final mockU32SetString = '[2,24,30,80]';
  final mockU32SetObject = [2, 24, 30, 80];
  final mockU32SetHexString = '0x1002000000180000001e00000050000000';
  final mockU32SetUint8Array =
      Uint8List.fromList([16, 2, 0, 0, 0, 24, 0, 0, 0, 30, 0, 0, 0, 80, 0, 0, 0]);

  group('decoding', () {
    testDecode(String type, dynamic input, String output) {
      test("can decode from $type", () {
        final s = new BTreeSet(registry, u32.constructor, input);
        expect(s.toString(), output);
      });
    }

    testDecode('Set', mockU32Set, mockU32SetString);
    testDecode('hex', mockU32SetHexString, mockU32SetString);
    testDecode('Uint8Array', mockU32SetUint8Array, mockU32SetString);

    testDecode('Set', mockU32Set, mockU32SetString);
    testDecode('hex', mockU32SetHexString, mockU32SetString);
    testDecode('Uint8Array', mockU32SetUint8Array, mockU32SetString);
  });

  group('encoding multiple values', () {
    testEncode(String to, dynamic expected) {
      test("can encode $to", () {
        final s = BTreeSet(registry, u32.constructor, mockU32Set);
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

    testEncode('toHex', mockU32SetHexString);
    testEncode('toJSON', mockU32SetObject);
    testEncode('toU8a', mockU32SetUint8Array);
    testEncode('toString', mockU32SetString);
  });

  group('BTreeSet', () {
    test('decodes null', () {
      expect((BTreeSet.withParams(u32.constructor))(registry, null).toString(), '[]');
    });

    test('decodes reusing instantiated inputs', () {
      final foo = CodecText(registry, 'bar');
      final setVal = Set();
      setVal.add(foo);
      expect(BTreeSet(registry, CodecText.constructor, setVal).eq(setVal), true);
    });

    test('decodes within more complicated types', () {
      final s = Struct(registry,
          {"placeholder": u32.constructor, "value": BTreeSet.withParams(u32.constructor)});
      print(s);

      s.put('value', BTreeSet(registry, u32.constructor, mockU32Set));
      expect(s.toString(), '{"placeholder":0,"value":[2,24,30,80]}');
    });

    test('throws when it cannot decode', () {
      expect(() => (BTreeSet.withParams(u32.constructor))(registry, 'ABC'),
          throwsA(contains("BTreeSet: cannot decode type")));
    });

    test('correctly encodes length', () {
      expect((BTreeSet.withParams(u32.constructor))(registry, mockU32Set).encodedLength, 17);
    });

    test('generates sane toRawTypes', () {
      expect((BTreeSet.withParams(u32.constructor))(registry).toRawType(), 'BTreeSet<u32>');
      expect((BTreeSet.withParams(CodecText.constructor))(registry).toRawType(), 'BTreeSet<Text>');
      expect(
          (BTreeSet.withParams(
                  Struct.withParams({"a": u32.constructor, "b": CodecText.constructor})))(registry)
              .toRawType(),
          'BTreeSet<{"a":"u32","b":"Text"}>');
    });
  });
}
