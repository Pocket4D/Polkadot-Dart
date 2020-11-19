import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/utils/number.dart';
import 'package:p4d_rust_binding/utils/string.dart';
import 'package:p4d_rust_binding/utils/u8a.dart';

void main() {
  u8aTest();
}

void u8aTest() {
  test("u8aConcat", () async {
    var a = Uint8List.fromList([1, 2, 3]);
    var b = Uint8List.fromList([4, 5, 6]);
    var some2 = u8aConcat([a, b]);
    expect(some2, Uint8List.fromList([1, 2, 3, 4, 5, 6]));
    var c = "hello";
    var space = " ";
    var d = "world";
    var some3 = u8aConcat([c, space, d]);
    expect(some3, Uint8List.fromList([104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100]));
    print("\n");
  });
  test("u8aSorted", () async {
    var a = Uint8List.fromList([1, 2, 3]);
    var b = Uint8List.fromList([4, 5, 6]);
    expect(u8aSorted([a, b]), [
      Uint8List.fromList([1, 2, 3]),
      Uint8List.fromList([4, 5, 6])
    ]);
    var c = "hello";
    var space = " ";
    var d = "world";
    var sooor = u8aSorted([stringToU8a(c), stringToU8a(space), stringToU8a(d)]);
    expect(sooor, [
      Uint8List.fromList([32]),
      Uint8List.fromList([104, 101, 108, 108, 111]),
      Uint8List.fromList([119, 111, 114, 108, 100])
    ]);
    print("\n");
  });

  test("u8aEq", () async {
    var c = "hello";
    var space = " ";
    var d = "world";
    var some3 = u8aConcat([c, space, d]);
    var e = "hello world";
    var some4 = stringToU8a(e);
    expect(u8aEq(some3, some4), true);
    print("\n");
  });
  test("u8aFixLength", () async {
    var f = '0x1234';
    var some5 = stringToU8a(f, 'hex');
    expect(bytesToHex(u8aFixLength(some5, bitLength: 16), include0x: true), f);
    print("\n");
  });
  test("u8aToHex", () async {
    var g = Uint8List.fromList([0x68, 0x65, 0x6c, 0xf]);
    expect(u8aToHex(g), "0x68656c0f");
    print("\n");
  });
  test("u8aToBn", () async {
    var g = Uint8List.fromList([0x68, 0x65, 0x6c, 0xf]);
    expect(u8aToBn(g).toInt(), 258762088);
    print("\n");
  });
  test("u8aToBuffer", () async {
    var g = Uint8List.fromList([0x68, 0x65, 0x6c, 0xf]);
    expect(u8aToBuffer(g).asUint8List(), g);
    print("\n");
  });
  test("u8aToString", () async {
    var h = Uint8List.fromList([0x68, 0x65, 0x6c, 0x6c, 0x6f]);
    expect(u8aToString(h), "hello");
    print("\n");
  });
}
