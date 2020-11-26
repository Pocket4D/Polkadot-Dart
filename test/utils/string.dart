import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/utils/string.dart';

void main() {
  stringTest();
}

void stringTest() {
  test('stringCamelCase', () {
    expect(stringCamelCase("ABC"), 'abc'); // abc
    // print("\n");
  });

  test('stringLowerFirst', () {
    expect(stringLowerFirst("ABC"), 'aBC'); // aBC
    // print("\n");
  });

  test('stringShorten', () {
    expect(stringShorten('0123456789', prefixLength: 4), '0123456789'); // 0123456789
    expect(stringShorten('0123456789', prefixLength: 3), '012…789'); // 012…789
    expect(stringShorten('0x7f07b1f87709608bee603bbc79a0dfc29cd315c1351a83aa31adf7458d7d3003'),
        '0x7f07…7d3003'); // 0x7f07…7d3003
    // print("\n");
  });
  test('stringUpperFirst', () {
    expect(stringUpperFirst("abc"), 'Abc');
    // print("\n");
  });
}
