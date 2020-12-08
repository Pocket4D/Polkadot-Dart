import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  utilTest(); // rename this test name
}

void utilTest() {
  group('Util', () {
    group('compareArray', () {
      final registry = TypeRegistry();
      final a = [u32(registry, 123), u32(registry, 456), u32(registry, 789)];

      test('returns false when second param is a non-array', () {
        expect(compareArray(a, 123), false);
      });

      test('compares array of codec agains primitive', () {
        expect(compareArray(a, [123, 456, 789]), true);
      });

      test('compares array of codec agains codec', () {
        expect(compareArray(a, [u32(registry, 123), u32(registry, 456), u32(registry, 789)]), true);
      });

      test('compares primitive against primitive', () {
        expect(compareArray([123, 456], [123, 456]), true);
      });

      test('returns false when lengths are not matching', () {
        expect(compareArray(a, [123]), false);
      });

      test('returns false when value mismatches', () {
        expect(compareArray(a, [123, 456, 999]), false);
      });
    });
    group('compareMap', () {
      final registry = TypeRegistry();
      final a = Map<String, BaseCodec>.from({
        'decimals': u32(registry, 15),
        'missing': u32(registry, 10),
        'foobar': u32(registry, 5)
      });

      final b = Map<String, dynamic>.from({'decimals': 15, 'missing': 10, 'foobar': 5});
      final c = Map<String, BaseCodec>.from({
        'decimals': u32(registry, 15),
        'missing': u32(registry, 10),
        'foobar': u32(registry, 5)
      });

      test('compares Map<string, Codec> against Object', () {
        expect(compareMap(a, {"decimals": 15, "foobar": 5, "missing": 10}), true);
      });

      test('compares Map<string, any> against entries array', () {
        expect(
            compareMap(b, [
              ['missing', 10],
              ['decimals', 15],
              ['foobar', 5]
            ]),
            true);
      });

      test('compares between 2 maps', () {
        expect(compareMap(a, b), true);
      });

      test('compares between 2 maps (both codec)', () {
        expect(compareMap(a, c), true);
      });

      test('returns false when second param is a non-map, non-array, non-object', () {
        expect(compareMap(a, 123), false);
      });

      test('returns false when second param is a array with non-entries', () {
        expect(compareMap(a, [123, 456, 789]), false);
      });

      test('returns false when second param is a array with non-entries (only key)', () {
        expect(
            compareMap(a, [
              [123],
              [456],
              [789]
            ]),
            false);
      });

      test('returns false when properties are missing', () {
        expect(
            compareMap(a, [
              ['decimals', 15],
              ['wrong', 10],
              ['foobar', 5]
            ]),
            false);
      });

      test('returns false when lengths do not match', () {
        expect(
            compareMap(a, [
              ['decimals', 15]
            ]),
            false);
      });
    });
  });
}
