import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  u8aFixedTest(); // rename this test name
}

void u8aFixedTest() {
  final registry = TypeRegistry();
  group('construction', () {
    test('allows empty values', () {
      expect(U8aFixed(registry).toHex(),
          '0x0000000000000000000000000000000000000000000000000000000000000000');
    });

    test('allows construction via with', () {
      expect((U8aFixed.withParams(64))(registry).bitLength, 64);
    });

    test('constructs from hex', () {
      expect((U8aFixed.withParams(32))(registry, '0x01020304').toU8a(),
          Uint8List.fromList([0x01, 0x02, 0x03, 0x04]));
    });

    test('constructs from number[]', () {
      expect((U8aFixed.withParams(32))(registry, [0x02, 0x03]).toU8a(),
          Uint8List.fromList([0x02, 0x03, 0x00, 0x00]));
    });
  });

  group('utils', () {
    final u8a = U8aFixed(registry, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 32);

    test('limits the length', () {
      expect(u8a.length, 4);
    });

    test('exposes the correct bitLength', () {
      expect(u8a.bitLength, 32);
    });

    test('allows wrapping of a pre-existing instance', () {
      expect(u8a.toU8a(), Uint8List.fromList([1, 2, 3, 4]));
    });

    test('hash a sane toRawType', () {
      expect(u8a.toRawType(), '[u8;4]');
    });
  });

  group('static with', () {
    test('allows default toRawType', () {
      expect((U8aFixed.withParams(64))(registry).toRawType(), '[u8;8]');
    });

    test('allows toRawType override', () {
      expect((U8aFixed.withParams(64, 'SomethingElse'))(registry).toRawType(), 'SomethingElse');
    });
  });
}
