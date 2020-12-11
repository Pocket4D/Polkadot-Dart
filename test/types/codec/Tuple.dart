import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  tupleTest(); // rename this test name
}

void tupleTest() {
  final registry = TypeRegistry();
  final tuple = new Tuple(registry, [CodecText.constructor, u32.constructor], ['bazzing', 69]);
  group('decoding', () {
    testDecode(String type, dynamic input) {
      test("can decode from $type", () {
        final t = new Tuple(registry, [CodecText.constructor, u32.constructor], input);

        expect(t.toJSON(), ['bazzing', 69]);
      });
    }

    testDecode('array', ['bazzing', 69]);
    testDecode('hex', '0x1c62617a7a696e6745000000');
    testDecode(
        'Uint8Array', Uint8List.fromList([28, 98, 97, 122, 122, 105, 110, 103, 69, 0, 0, 0]));

    test('decodes reusing instantiated inputs', () {
      final foo = new CodecText(registry, 'bar');

      expect((new Tuple(registry, [CodecText.constructor], [foo])).value[0], foo);
    });

    test('decodes properly from complex types', () {
      const INPUT = '0xcc0200000000';
      final test = registry.createType('(u32, [u32; 0], u16)', INPUT);

      expect(test.encodedLength, 4 + 0 + 2);
      expect(test.toHex(), INPUT);
    });
  });
  group('encoding', () {
    testEncode(String to, dynamic expected) {
      test("can encode $to", () {
        switch (to) {
          case 'toHex':
            expect(tuple.toHex(), expected);
            break;
          case 'toJSON':
            expect(tuple.toJSON(), expected);
            break;
          case 'toString':
            expect(tuple.toString(), expected);
            break;
          case 'toU8a':
            expect(tuple.toU8a(), expected);
            break;
          default:
            break;
        }
      });
    }

    testEncode('toHex', '0x1c62617a7a696e6745000000');
    testEncode('toJSON', ['bazzing', 69]);
    testEncode('toU8a', Uint8List.fromList([28, 98, 97, 122, 122, 105, 110, 103, 69, 0, 0, 0]));
    testEncode('toString', '["bazzing",69]');
  });
  test('creates from string types', () {
    expect(new Tuple(registry, ['Text', 'u32', u32.constructor], ['foo', 69, 42]).toString(),
        '["foo",69,42]');
  });
  // test('creates properly via actual hex string', () {
  //   const metadata = new Metadata(registry, rpcMetadata);

  //   registry.setMetadata(metadata);

  //   const test = new (Tuple.with([
  //     registry.createClass('BlockNumber'), registry.createClass('VoteThreshold')
  //   ]
  //   ))(registry, '0x6219000001');

  //   expect((test[0] as BlockNumber).toNumber()).toEqual(6498);
  //   expect((test[1] as VoteThreshold).toNumber()).toEqual(1);
  // });

  test('exposes the Types', () {
    expect(tuple.types, ['Text', 'u32']);
  });

  // test('exposes the Types (object creation)', () {
  //   const test = new Tuple(registry, {
  //     BlockNumber: registry.createClass('BlockNumber'),
  //     VoteThreshold: registry.createClass('VoteThreshold')
  //   }, []);

  //   expect(test.Types).toEqual(['BlockNumber', 'VoteThreshold']);
  // });

  test('exposes filter', () {
    expect(tuple.filter((v, [index, list]) => v.toJSON() == 69).map((e) => e.toJSON()),
        [u32(registry, 69)].map((e) => e.toJSON()));
  });

  test('exposes map', () {
    expect(tuple.map((v, [index, list]) => v.toString()), ['bazzing', '69']);
  });
}
