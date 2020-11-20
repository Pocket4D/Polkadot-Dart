import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/utils/hex.dart';
import 'package:p4d_rust_binding/utils/u8a.dart';

void main() {
  hexTest();
}

void hexTest() {
  test('hexAddPrefix', () {
    expect(hexAddPrefix('0x0123'), '0x0123'); //0x0123
    expect(hexAddPrefix('0123'), '0x0123'); //0x0123
    expect(hexAddPrefix('123'), '0x0123'); //0x0123
    expect(hexAddPrefix(null), '0x'); //'0x'
    // print("\n");
  });

  test('hexFixLength', () {
    expect(hexFixLength('0x12345678'), '0x12345678'); //0x12345678
    expect(hexFixLength('0x1234567'), '0x01234567'); //0x01234567
    expect(hexFixLength('0x12345678', 32), '0x12345678'); //0x12345678
    expect(hexFixLength('0x12345678', 16), '0x5678'); //0x5678 -->
    expect(hexFixLength('0x1234', 32), '0x1234'); //0x1234
    expect(hexFixLength('0x1234', 32, true), '0x00001234'); // 0x00001234 -->
    // print("\n");
  });

  test('hexHasPrefix', () {
    expect(hexHasPrefix('0x123'), true); //true
    expect(hexHasPrefix('123'), false); //false
    expect(hexHasPrefix(null), false); //false;
    // print("\n");
  });

  test('hexStripPrefix', () {
    expect(hexStripPrefix(null), ''); //''
    expect(hexStripPrefix("0x1223"), '1223'); // 1223
    expect(hexStripPrefix('abcd1223'), 'abcd1223'); //abcd1223
    expect(hexStripPrefix('0x'), '');
    // print("\n");
  });

  test('hexToBn', () {
    expect(hexToBn(0x81).toRadixString(16), '81'); //81
    expect(hexToBn(null).toInt(), 0); //0;
    expect(hexToBn('0x').toInt(), 0); //0;
    expect(hexToBn('0x0100').toInt(), 256); // 256
    expect(hexToBn('0x4500000000000000', endian: Endian.little).toInt(), 69); //69
    expect(hexToBn('0x2efb', endian: Endian.little, isNegative: true).toInt(), -1234); // -1234
    expect(hexToBn('0xfb2e', endian: Endian.big, isNegative: true).toInt(), -1234); // -1234
    expect(
        hexToBn('0x00009c584c491ff2ffffffffffffffff', endian: Endian.little, isNegative: true)
            .toString(),
        '-1000000000000000000'); //-1000000000000000000
    expect(hexToBn('0x0000000000000100', endian: Endian.big).toInt(), 256); // 256
    expect(hexToBn('0x0001000000000000', endian: Endian.little).toInt(), 256); // 256
    expect(hexToBn('0x0001000000000000', endian: Endian.big) == hexToBn('0x0001000000000000'),
        true); // true
    // print("\n");
  });

  test('hexToNumber', () {
    expect(hexToNumber(0x1234), 0x1234); // true
    expect(hexToNumber(null), null);
    // print("\n");
  });

  test('hexToString', () {
    expect(hexToString('0x68656c6c6f'), 'hello'); // hello
    // print("\n");
  });

  test('hexToU8a', () {
    expect(u8aEq(hexToU8a('0x80000a'), Uint8List.fromList([128, 0, 10])), true);
    expect(u8aEq(hexToU8a('0x80000a', 32), Uint8List.fromList([0, 128, 0, 10])), true); // hello
    // print("\n");
  });
}
