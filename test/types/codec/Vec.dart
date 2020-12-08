import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  vecTest(); // rename this test name
}

void vecTest() {
  final registry = TypeRegistry();
  // final metadata = Metadata(registry, rpcMetadata);

  // registry.setMetadata(metadata);
  group('Vec', () {
    final vector = Vec<CodecText>(
        registry, CodecText.constructor, ['1', '23', '345', '4567', CodecText(registry, '56789')]);

    test('wraps a sequence of values', () {
      expect(vector.length, 5); // eslint-disable-line
    });

    test('has a sane representation for toString', () {
      expect(vector.toString(), '[1, 23, 345, 4567, 56789]');
    });

    test('encodes with length prefix', () {
      expect(
          vector.toU8a(),
          Uint8List.fromList([
            5 << 2,
            1 << 2,
            49,
            2 << 2,
            50,
            51,
            3 << 2,
            51,
            52,
            53,
            4 << 2,
            52,
            53,
            54,
            55,
            5 << 2,
            53,
            54,
            55,
            56,
            57
          ]));
    });

    test('allows construction via JSON', () {
      expect(Vec(registry, CodecText.constructor, ['6', '7']).toJSON(), ['6', '7']);
    });

    test('allows construction via JSON (string type)', () {
      print("⚠️ : TODO");
      // expect(Vec(registry, 'u32', ['6', '7']).toJSON(), [6, 7]);
    });

    test('exposes the type', () {
      expect(vector.type, 'CodecText');
    });

    test('decodes reusing instantiated inputs', () {
      final foo = CodecText(registry, 'bar');

      expect((Vec(registry, CodecText.constructor, [foo])).value[0], foo);
    });

    // // test('decodes a complex type via construction', () {
    // //   final test = createTypeUnsafe(registry, 'Vec<(PropIndex, AccountId)>', [ Uint8Array([
    // //     4, 10, 0, 0, 0, 209, 114, 167, 76, 218, 76, 134, 89, 18, 195, 43, 160, 168, 10, 87, 174, 105, 171, 174, 65, 14, 92, 203, 89, 222, 232, 78, 47, 68, 50, 219, 79
    // //   ])]);
    // //   final first = (test as Vec<Codec>)[0] as Tuple;

    // //   expect((first[0] as PropIndex).toNumber(),10);
    // //   expect((first[1] as AccountId).toString(),'5GoKvZWG5ZPYL1WUovuHW3zJBWBP5eT8CbqjdRY4Q6iMaQua');
    // // });

    // // test('decodes a complex type via construction', () {
    // //   final INPUT = '0x08cc0200000000ce0200000001';
    // //   final test = createTypeUnsafe(registry, 'Vec<(u32, [u32; 0], u16)>' as any, [INPUT]);

    // //   expect((test as Vec<any>).length,2);
    // //   expect(test.toHex(),INPUT);
    // // });

    group('vector-like functions', () {
      test('allows retrieval of a specific item', () {
        expect(vector.value[2].toString(), '345');
      });

      test('exposes a working forEach', () {
        var result = {};

        vector.value.forEach((e) {
          result[vector.value.indexOf(e)] = e.toString();
        });

        expect(result, {0: '1', 1: '23', 2: '345', 3: '4567', 4: '56789'});
      });

      test('exposes a working concat', () {
        // different from javascript's Array.toString [1,2,3,4,5].toString() => '1,2,3,4,5'
        // dart is more resonable, Vec<T>([1,2,3]) => [1,2,3]
        expect(
            vector
                .concat(Vec<CodecText>(registry, CodecText.constructor, ['987', '654']).value)
                .toString(),
            '[1, 23, 345, 4567, 56789, 987, 654]');
      });

      test('exposes a working filter', () {
        // different from javascript's Array.toString [1,2,3,4,5].toString() => '1,2,3,4,5'
        expect(vector.filter((e, [i, list]) => i >= 3).toString(), '[4567, 56789]');
      });

      test('exposes a working map', () {
        expect(
            vector.map((e, [i, list]) => e.toString().substring(0, 1)), ['1', '2', '3', '4', '5']);
      });

      test('exposes a working reduce', () {
        expect(vector.value.fold('', (r, e) => "$r${e.toString()}"), '123345456756789');
      });

      test('exposes a working indexOf', () {
        expect(vector.indexOf('1'), 0);
        expect(vector.indexOf(CodecText(registry, '23')), 1);
        expect(vector.indexOf('0'), -1);
      });
    });

    group('encode', () {
      testEncode(String to, dynamic expected) {
        test("can encode $to", () {
          switch (to) {
            case 'toHex':
              expect(vector.toHex(), expected);
              break;
            case 'toJSON':
              expect(vector.toJSON(), expected);
              break;
            case 'toString':
              expect(vector.toString(), expected);
              break;
            case 'toU8a':
              expect(vector.toU8a(), expected);
              break;
            default:
              break;
          }
        });
      }

      testEncode('toHex', '0x1404310832330c3334351034353637143536373839');
      testEncode('toJSON', ['1', '23', '345', '4567', '56789']);
      testEncode('toString', '[1, 23, 345, 4567, 56789]');
      testEncode(
          'toU8a',
          Uint8List.fromList(
              [20, 4, 49, 8, 50, 51, 12, 51, 52, 53, 16, 52, 53, 54, 55, 20, 53, 54, 55, 56, 57]));
    });

    group('utils', () {
      final vec = Vec(registry, CodecText.constructor, ['123', '456']);

      test('compares against codec types', () {
        expect(vec.eq([CodecText(registry, '123'), CodecText(registry, '456')]), true);
      });

      test('compares against codec + primitive types', () {
        expect(vec.eq(['123', CodecText(registry, '456')]), true);
      });

      // test('finds the index of an value', () {
      //   final myId = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      //   final vec =  Vec(registry, AccountId, [
      //     '5HGjWAeFDfFCWPsjFQdVV2Msvz2XtMktvgocEZcCj68kUMaw', '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty', '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'
      //   ]);

      //   expect(vec.indexOf(myId),2);
      // });
    });
  });
}
