import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Bytes.dart';

void main() {
  bytesTest(); // rename this test name
}

void bytesTest() {
  group('Bytes', () {
    final registry = TypeRegistry();
    final NUM = [0x3a, 0x63, 0x6f, 0x64, 0x65];
    final U8A = Uint8List.fromList([0x14, ...NUM]);
    final HEX = '0x3a636f6465';

    group('construction', () {
      test('decodes when input is string', () {
        expect(Bytes(registry, ':code').toU8a(), U8A);
      });

      test('decodes when hex is not length prefixed', () {
        expect(Bytes(registry, HEX).toU8a(), U8A);
      });

      test('decodes from UInt8Array', () {
        expect(Bytes(registry, U8A).toU8a(), U8A);
      });

      test('decodes from number[]', () {
        expect(Bytes(registry, NUM).toU8a(), U8A);
      });

      test('creates via storagedata (no prefix)', () {
        expect(Bytes(registry, registry.createType('StorageData', HEX)).toU8a(), U8A);
      });

      test('encodes from itself', () {
        expect(Bytes(registry, Bytes(registry, HEX)).toU8a(), U8A);
      });

      test('strips length with toU8a(true)', () {
        expect(Bytes(registry, HEX).toU8a(true), U8A.sublist(1));
      });

      test('strips length with toHex', () {
        expect(Bytes(registry, HEX).toHex(), HEX);
      });
    });
  });
}
