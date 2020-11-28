import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/base64.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../testUtils/throws.dart';

void main() {
  base64Test();
}

void base64Test() {
  test('base64Validate', () {
    expect(
        () => base64Validate('aGVsbG8gd29ybGQg0J/RgNC40LLQtd^GC0YHRgtCy0YPRjiDQvNC4IOS9oOWlvQ=='),
        throwsA(assertionThrowsContains("Invalid base64 encoding")));
    // print("\n");
  });

  test('base64Trim', () {
    expect(base64Trim('aGVsbG8gd29ybGQg0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDQvNC4IOS9oOWlvQ=='),
        'aGVsbG8gd29ybGQg0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDQvNC4IOS9oOWlvQ');
    // print("\n");
  });

  test('base64Pad', () {
    expect(base64Pad('YWJjZA'), 'YWJjZA==');
    // print("\n");
  });

  test('base64Encode', () {
    expect(base64Encode('hello world Приветствую ми 你好'),
        'aGVsbG8gd29ybGQg0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDQvNC4IOS9oOWlvQ==');
    // print("\n");
  });

  test('base64Decode', () {
    expect(base64Decode('aGVsbG8gd29ybGQg0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDQvNC4IOS9oOWlvQ=='),
        stringToU8a('hello world Приветствую ми 你好', useDartEncode: true));
  });
}
