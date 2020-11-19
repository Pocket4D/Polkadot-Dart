import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/utils/is.dart';

void main() {
  isTest();
}

void isTest() {
  test("isHex", () {
    const testNum = '1234abcd';
    expect(isHex('0x'), true); // true
    expect(isHex("0x$testNum"), true); // true
    expect(isHex("0x${testNum}0"), false); // false
    expect(isHex("0x${testNum.toUpperCase()}"), true); // true
    expect(isHex(testNum), false); // false
    expect(isHex(false), false); // false
    expect(isHex('0x1234', 16), true); // true
    expect(isHex('0x1234', 8), false); // false
    expect(isHex('1234'), false); // false
    print("\n");
  });

  test('isJsonObject', () {
    const jsonObject = {
      "Test": "1234",
      "NestedTest": {"Test": "5678"}
    };
    expect(isJsonObject("{}"), true); // true
    expect(isJsonObject("${jsonEncode(jsonObject)}"), true); // true
    expect(isJsonObject(123), false); // false
    expect(isJsonObject(null), false); // false
    expect(isJsonObject("asdfasdf"), false); // false
    expect(isJsonObject("{'abc','def'}"), false); // false
    print("\n");
  });

  test('testChain', () {
    var validTestModeChainSpecsWithDev = ['Development'];
    var validTestModeChainSpecsWithLoc = ['Local Testnet'];

    validTestModeChainSpecsWithDev.addAll(validTestModeChainSpecsWithLoc);
    validTestModeChainSpecsWithDev.forEach((element) {
      expect(isTestChain(element), true);
    });

    const invalidTestModeChainSpecs = [
      'dev',
      'local',
      'development',
      'PoC-1 Testnet',
      'Staging Testnet',
      'future PoC-2 Testnet',
      'a pocadot?',
      null
    ];
    invalidTestModeChainSpecs.forEach((s) {
      expect(isTestChain(s), false);
    });
    print("\n");
  });

  test('isUtf8', () {
    expect(isUtf8('Hello\tWorld!\n\rTesting'), true); // true
    expect(isUtf8(Uint8List.fromList([0x31, 0x32, 0x20, 10])), true); // true
    expect(isUtf8(''), true); // true
    expect(isUtf8([]), true); // true
    expect(isUtf8('Приветствую, ми'), true); // true
    expect(isUtf8('你好'), true); // true
    expect(isUtf8('0x7f07b1f87709608bee603bbc79a0dfc29cd315c1351a83aa31adf7458d7d3003'),
        false); // false
    print("\n");
  });
}
