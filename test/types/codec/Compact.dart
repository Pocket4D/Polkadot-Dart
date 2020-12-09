import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  compactTest(); // rename this test name
}

void compactTest() {
  final registry = TypeRegistry();

  group('constructor', () {
    test('has support for BigInt', () {
      expect(Compact(registry, 'u128', BigInt.parse('123456789000123456789')).toHuman(),
          '123,456,789,000,123,456,789');
    });

    test('has the correct bitLength for constructor values (BlockNumber)', () {
      expect(
          (Compact.withParams(registry.createClass('BlockNumber')))(registry, 0xfffffff9).bitLength,
          32);
    });

    test('has the correct encodedLength for constructor values (string BlockNumber)', () {
      expect((Compact.withParams('BlockNumber'))(registry, 0xfffffff9).encodedLength, 5);
    });

    test('has the correct encodedLength for constructor values (class BlockNumber)', () {
      expect(
          (Compact.withParams(registry.createClass('BlockNumber')))(registry, 0xfffffff9)
              .encodedLength,
          5);
    });

    test('has the correct encodedLength for constructor values (u32)', () {
      expect((Compact.withParams(u32.constructor))(registry, 0xffff9).encodedLength, 4);
    });

    test('constructs properly via Uint8Array as U32', () {
      expect(
          (Compact.withParams(u32.constructor))(registry, Uint8List.fromList([254, 255, 3, 0]))
              .toNumber(),
          BigInt.from(0xffff).toInt());
    });

    test('constructs properly via number as Moment', () {
      var dateString = Compact.withParams(CodecDate.constructor)(registry, 1537968546).toString();

      expect(
          dateString
              .startsWith('2018-09-26') // The time depends on the timezone this test is run in
          ,
          true);
    });
  });

  group('utils', () {
    test('compares against another Compact', () {
      expect(
          (Compact.withParams(u32.constructor))(registry, 12345)
              .eq((Compact.withParams(u32.constructor))(registry, 12345)),
          true);
    });

    test('compares against a primitive', () {
      expect((Compact.withParams(u32.constructor))(registry, 12345).eq(12345), true);
    });

    test('unwraps to the wrapped value', () {
      expect((Compact.withParams(u32.constructor))(registry, 12345).unwrap() is u32, true);
    });

    test('has a valid toBn interface', () {
      expect(
          (Compact.withParams('u128'))(registry, '12345678987654321').toBn() ==
              (BigInt.parse('12345678987654321')),
          true);
    });

    test('has a valid toBigInt interface', () {
      expect(
          (Compact.withParams('u128'))(registry, BigInt.parse('12345678987654321')).toBigInt() ==
              BigInt.parse('12345678987654321'),
          true);
    });
  });
}
