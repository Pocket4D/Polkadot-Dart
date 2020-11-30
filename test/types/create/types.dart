import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/types.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  createTypeTest(); // rename this test name
}

void createTypeTest() {
  group('typeSplit', () {
    test('splits simple types into an array', () {
      expect(typeSplit('Text, u32, u64'), ['Text', 'u32', 'u64']);
    });

    test('splits nested combinations', () {
      expect(typeSplit('Text, (u32), Vec<u64>'), ['Text', '(u32)', 'Vec<u64>']);
    });

    test('keeps nested tuples together', () {
      expect(typeSplit('Text, (u32, u128), Vec<u64>'), ['Text', '(u32, u128)', 'Vec<u64>']);
    });

    test('keeps nested vector tuples together', () {
      expect(typeSplit('Text, (u32, u128), Vec<(u64, u32)>'),
          ['Text', '(u32, u128)', 'Vec<(u64, u32)>']);
    });

    test('allows for deep nesting', () {
      expect(typeSplit('Text, (u32, (u128, u8)), Vec<(u64, (u32, u32))>'),
          ['Text', '(u32, (u128, u8))', 'Vec<(u64, (u32, u32))>']);
    });

    test('checks for unclosed vec', () {
      expect(() => typeSplit('Text, Vec<u64'), throwsA(contains("Invalid definition")));
    });

    test('checks for unclosed tuple', () {
      expect(() => typeSplit('Text, (u64, u32'), throwsA(contains("Invalid definition")));
    });
  });
}
