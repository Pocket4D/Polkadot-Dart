import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  mapTest(); // rename this test name
}

void mapTest() {
  final registry = TypeRegistry();
  final mockU32TextMap = Map<CodecText, u32>();

  mockU32TextMap.putIfAbsent(CodecText(registry, 'bazzing'), () => u32(registry, 69));
  final mockU32TextMapString = '{"bazzing":69}';
  final mockU32TextMapObject = {"bazzing": 69};
  final mockU32TextMapHexString = '0x041c62617a7a696e6745000000';
  final mockU32TextMapUint8Array =
      Uint8List.fromList([4, 28, 98, 97, 122, 122, 105, 110, 103, 69, 0, 0, 0]);

  final mockU32U32Map = Map<u32, u32>();

  mockU32U32Map.putIfAbsent(u32(registry, 1), () => u32(registry, 2));
  mockU32U32Map.putIfAbsent(u32(registry, 23), () => u32(registry, 24));
  mockU32U32Map.putIfAbsent(u32(registry, 28), () => u32(registry, 30));
  mockU32U32Map.putIfAbsent(u32(registry, 45), () => u32(registry, 80));

  final mockU32U32MapString = '{"1":2,"23":24,"28":30,"45":80}';
  final mockU32U32MapObject = {"1": 2, "23": 24, "28": 30, "45": 80};
  final mockU32U32MapHexString = '0x10043102000000083233180000000832381e00000008343550000000';
  final mockU32U32MapUint8Array = Uint8List.fromList([
    16,
    4,
    49,
    2,
    0,
    0,
    0,
    8,
    50,
    51,
    24,
    0,
    0,
    0,
    8,
    50,
    56,
    30,
    0,
    0,
    0,
    8,
    52,
    53,
    80,
    0,
    0,
    0
  ]);
  group('CodecMap', () {
    group('decoding', () {
      testDecode(String type, dynamic input, String output) {
        test("can decode from $type", () {
          final s = new CodecMap(registry, CodecText.constructor, u32.constructor, input);

          expect(s.toString(), output);
        });
      }

      testDecode('map', mockU32TextMap, mockU32TextMapString);
      testDecode('hex', mockU32TextMapHexString, mockU32TextMapString);
      testDecode('Uint8Array', mockU32TextMapUint8Array, mockU32TextMapString);

      testDecode('map', mockU32U32Map, mockU32U32MapString);
      testDecode('hex', mockU32U32MapHexString, mockU32U32MapString);
      testDecode('Uint8Array', mockU32U32MapUint8Array, mockU32U32MapString);
    });

    group('encoding', () {
      testEncode(String to, dynamic expected) {
        test("can encode $to", () {
          final s = new CodecMap(
              registry, CodecText.constructor, u32.constructor, mockU32TextMap, 'BTreeMap');
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

      testEncode('toHex', mockU32TextMapHexString);
      testEncode('toJSON', mockU32TextMapObject);
      testEncode('toU8a', mockU32TextMapUint8Array);
      testEncode('toString', mockU32TextMapString);
    });

    group('encoding muple values', () {
      testEncode(String to, dynamic expected, [bool keyAsString = true]) {
        test("can encode $to", () {
          final s = new CodecMap(
              registry, CodecText.constructor, u32.constructor, mockU32U32Map, 'BTreeMap');

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

      testEncode('toHex', mockU32U32MapHexString);
      testEncode('toJSON', mockU32U32MapObject);
      testEncode('toU8a', mockU32U32MapUint8Array);
      testEncode('toString', mockU32U32MapString);
    });
  });
}
