import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/key.dart';

void main() {
  keyTest();
}

void keyTest() {
  test('keyExtractPath', () {
    var keyExtractPathResult = keyExtractPath('/1');
    expect(keyExtractPathResult.parts, ["/1"]); // ["/1"]
    expect(keyExtractPathResult.path.length, 1); // 1
    expect(keyExtractPathResult.path[0].isHard, false); // false
    expect(
        keyExtractPathResult.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    var keyExtractPathResult2 = keyExtractPath('//1');
    expect(keyExtractPathResult2.parts, ["//1"]); // ["//1"]
    expect(keyExtractPathResult2.path.length, 1); // 1
    expect(keyExtractPathResult2.path[0].isHard, true); // true
    expect(
        keyExtractPathResult2.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    var keyExtractPathResult3 = keyExtractPath('//1/2');
    expect(keyExtractPathResult3.parts, ["//1", "/2"]); // ["//1","/2"]
    expect(keyExtractPathResult3.path.length, 2); // 2
    expect(keyExtractPathResult3.path[0].isHard, true); // true
    expect(
        keyExtractPathResult3.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    expect(keyExtractPathResult3.path[1].isHard, false); // false
    expect(
        keyExtractPathResult3.path[1].chainCode,
        Uint8List.fromList([
          2,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    print("\n");
  });

  test("keyExtractSuri", () {
    var keyExtractSuriTest = keyExtractSuri('hello world');
    expect(keyExtractSuriTest.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest.path.length, 0); // 0

    var keyExtractSuriTest2 = keyExtractSuri('hello world/1');
    expect(keyExtractSuriTest2.password, ''); // ''
    expect(keyExtractSuriTest2.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest2.path.length, 1); // 1
    expect(keyExtractSuriTest2.path[0].isHard, false); // false
    expect(
        keyExtractSuriTest2.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    var keyExtractSuriTest3 = keyExtractSuri('hello world/DOT');
    expect(keyExtractSuriTest3.password, ''); // ''
    expect(keyExtractSuriTest3.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest3.path.length, 1); // 1
    expect(keyExtractSuriTest3.path[0].isHard, false); // false
    expect(
        keyExtractSuriTest3.path[0].chainCode,
        Uint8List.fromList([
          12,
          68,
          79,
          84,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    var keyExtractSuriTest4 = keyExtractSuri('hello world//1');
    expect(keyExtractSuriTest4.password, ''); // ''
    expect(keyExtractSuriTest4.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest4.path.length, 1); // 1
    expect(keyExtractSuriTest4.path[0].isHard, true); // true
    expect(
        keyExtractSuriTest4.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]));

    var keyExtractSuriTest5 = keyExtractSuri('hello world//DOT');
    expect(keyExtractSuriTest5.password, ''); // ''
    expect(keyExtractSuriTest5.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest5.path.length, 1); // 1
    expect(keyExtractSuriTest5.path[0].isHard, true); // true
    expect(
        keyExtractSuriTest5.path[0].chainCode,
        Uint8List.fromList([
          12,
          68,
          79,
          84,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    var keyExtractSuriTest6 = keyExtractSuri('hello world//1/DOT');
    expect(keyExtractSuriTest6.password, ''); // ''
    expect(keyExtractSuriTest6.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest6.path.length, 2); // 2
    expect(keyExtractSuriTest6.path[0].isHard, true); // true
    expect(
        keyExtractSuriTest6.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    expect(keyExtractSuriTest6.path[1].isHard, false); // false
    expect(
        keyExtractSuriTest6.path[1].chainCode,
        Uint8List.fromList([
          12,
          68,
          79,
          84,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ]));

    var keyExtractSuriTest7 = keyExtractSuri('hello world//DOT/1');
    expect(keyExtractSuriTest7.password, ''); // ''
    expect(keyExtractSuriTest7.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest7.path.length, 2); // 2
    expect(keyExtractSuriTest7.path[0].isHard, true); // false
    expect(
        keyExtractSuriTest7.path[0].chainCode,
        Uint8List.fromList([
          12,
          68,
          79,
          84,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    expect(keyExtractSuriTest7.path[1].isHard, false); // true
    expect(
        keyExtractSuriTest7.path[1].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    var keyExtractSuriTest8 = keyExtractSuri('hello world///password');

    expect(keyExtractSuriTest8.password, 'password'); // 'password'
    expect(keyExtractSuriTest8.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest8.path.length, 0); // 0

    var keyExtractSuriTest9 = keyExtractSuri('hello world//1/DOT///password');

    expect(keyExtractSuriTest9.password, 'password'); // 'password'
    expect(keyExtractSuriTest9.phrase, 'hello world'); // 'hello world'
    expect(keyExtractSuriTest9.path.length, 2); // 2
    expect(keyExtractSuriTest9.path[0].isHard, true); // true
    expect(
        keyExtractSuriTest9.path[0].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
        ])); //
    expect(keyExtractSuriTest9.path[1].isHard, false); // false
    expect(
        keyExtractSuriTest9.path[1].chainCode,
        Uint8List.fromList([
          12,
          68,
          79,
          84,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //

    var keyExtractSuriTest10 = keyExtractSuri(
        'bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice/1///password');

    expect(keyExtractSuriTest10.password, 'password'); // 'password'
    expect(keyExtractSuriTest10.phrase,
        'bottom drive obey lake curtain smoke basket hold race lonely fit walk'); // 'bottom drive obey lake curtain smoke basket hold race lonely fit walk world'
    expect(keyExtractSuriTest10.path.length, 2); // 2
    expect(keyExtractSuriTest10.path[0].isHard, true); // true
    expect(
        keyExtractSuriTest10.path[0].chainCode,
        Uint8List.fromList([
          20,
          65,
          108,
          105,
          99,
          101,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ])); //
    expect(keyExtractSuriTest10.path[1].isHard, false); // false
    expect(
        keyExtractSuriTest10.path[1].chainCode,
        Uint8List.fromList([
          1,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
        ])); //
    print('\n');
  });
}
