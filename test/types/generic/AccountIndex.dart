import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/generic/AccountIndex.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';

void main() {
  accountIndex(); // rename this test name
}

void accountIndex() {
  group('AccountIndex', () {
    final registry = new TypeRegistry();

    test('creates a BN representation', () {
      expect(
          (registry.createType('AccountIndex', Uint8List.fromList([17, 18, 19, 20]))
                  as GenericAccountIndex)
              .toNumber(),
          336794129);
      expect(
          AccountIndex.from(
              registry.createType('AccountIndex', Uint8List.fromList([17, 18, 19, 20]))).toNumber(),
          336794129);
    });

    test('creates from BigInt', () {
      expect(
          (registry.createType('AccountIndex', BigInt.from(336794129)) as GenericAccountIndex)
              .toNumber(),
          336794129);
    });

    test('creates a BN representation (from ss-58)', () {
      expect((registry.createType('AccountIndex', 'Mwz15xP2') as GenericAccountIndex).toNumber(),
          336794129);
    });

    test('constructs 2-byte from number', () {
      expect(registry.createType('AccountIndex', 256 * 1).toString(), '25GUyv');
    });

    test('constructs from number', () {
      expect(registry.createType('AccountIndex', BigInt.from(336794129)).toString(), 'Mwz15xP2');
    });

    test('compares ss-58 values', () {
      expect(registry.createType('AccountIndex', 256 * 1).eq('25GUyv'), true);
    });

    test('compares numbers', () {
      expect(registry.createType('AccountIndex', '2jpAFn').eq(256 * 1), true);
    });

    group('calcLength', () {
      testLength(int value, int length) {
        expect(GenericAccountIndex.calcLength(value), length);
      }

      test('returns 1 for <= 0xef', () {
        testLength(0xef, 1);
      });

      test('returns 2 for > 0xef', () {
        testLength(0xf0, 2);
      });

      test('returns 4 bytes for 32-bit inputs', () {
        testLength(0xffeeddcc, 4);
      });

      test('returns 8 bytes for larger inputs', () {
        testLength(0x122334455, 8);
      });
    });
  });
}
