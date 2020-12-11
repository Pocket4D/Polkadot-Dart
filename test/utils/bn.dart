import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/utils/bn.dart';
import 'package:polkadot_dart/utils/u8a.dart';

void main() {
  bnTest();
}

void bnTest() {
  test('bnToHex', () {
    expect(bnToHex(null), '0x00'); // 0x00
    expect(bnToHex(BigInt.from(128)), '0x80'); // 0x80 -- >
    expect(bnToHex(BigInt.from(128), bitLength: 16), '0x0080'); // 0x0080 -- >
    expect(bnToHex(BigInt.from(128), bitLength: 16, endian: Endian.little), '0x8000'); // 0x8000
    expect(bnToHex(BigInt.from(-1234), isNegative: true), '0xfb2e'); // 0xfb2e
    expect(
        bnToHex(BigInt.from(-1234), bitLength: 32, isNegative: true), '0xfffffb2e'); // 0xfffffb2e
    // print("\n");
  });

  test('bnToU8a', () {
    expect(u8aEq(bnToU8a(null, bitLength: 32, isNegative: false), Uint8List.fromList([0, 0, 0, 0])),
        true); // [0,0,0,0]
    expect(
        u8aEq(bnToU8a(BigInt.from(0x123456), bitLength: -1, endian: Endian.big),
            Uint8List.fromList([0x12, 0x34, 0x56])),
        true); // [0x12, 0x34, 0x56]
    expect(
        u8aEq(bnToU8a(BigInt.from(0x123456), bitLength: 32, endian: Endian.big),
            Uint8List.fromList([0x00, 0x12, 0x34, 0x56])),
        true); // [0x00, 0x12, 0x34, 0x56]
    expect(
        u8aEq(bnToU8a(BigInt.from(0x123456), bitLength: 32, endian: Endian.little),
            Uint8List.fromList([0x56, 0x34, 0x12, 0x00])),
        true); // [0x56, 0x34, 0x12, 0x00]
    expect(
        u8aEq(bnToU8a(BigInt.from(-1234), endian: Endian.little, isNegative: true),
            Uint8List.fromList([46, 251])),
        true); // [46,251]
    expect(
        u8aEq(bnToU8a(BigInt.from(-1234), endian: Endian.big, isNegative: true),
            Uint8List.fromList([251, 46])),
        true); // [251,46]
    expect(
        u8aEq(bnToU8a(BigInt.from(-1234), bitLength: 32, isNegative: true),
            Uint8List.fromList([46, 251, 255, 255])),
        true); // [46, 251, 255, 255] -- different from [46,251,255,255]
    expect(
        u8aEq(bnToU8a(BigInt.from(1234), bitLength: 32, isNegative: true),
            Uint8List.fromList([46, 251, 255, 255])),
        true);
    // print("\n");
  });

  test('bnMax', () {
    expect(bnMax([BigInt.from(1), BigInt.from(2), BigInt.from(3)]).toString(), '3'); // 3
    // print("\n");
  });

  test('bnMin', () {
    expect(bnMin([BigInt.from(1), BigInt.from(2), BigInt.from(3)]).toString(), '1'); // 1
  });

  test('bnSqrt', () {
    expect(bnSqrt(BigInt.from(16)), BigInt.from(4)); // 4
  });
  group('bnToBn', () {
    test('converts null values to 0x00', () {
      expect(bnToBn(null).toInt(), 0);
    });

    test('converts BN values to BN', () {
      expect(bnToBn(BigInt.from(128)).toInt(), 128);
    });

    test('converts BigInt values to BN', () {
      expect(bnToBn(BigInt.from(128821)).toInt(), 128821);
    });

    test('converts number values to BN', () {
      expect(bnToBn(128).toInt(), 128);
    });

    test('converts string to BN', () {
      expect(bnToBn('123').toInt(), 123);
    });

    test('converts hex to BN', () {
      expect(bnToBn('0x0123').toInt(), 0x123);
    });

    test('converts Compact to BN', () {
      expect(bnToBn({"something": 'test', "toBn": () => BigInt.from(1234)}).toInt(), 1234);
    });
    test('constants', () {
      expect(bnZero.toInt(), 0);
      expect(bnOne.toInt(), 1);
      expect(bnTen.toInt(), 10);
      expect(bnHundred.toInt(), 100);
      expect(bnThrousand.toInt(), 1000);
    });
    test('throws error', () {
      expect(() => bnToBn("throws this"),
          throwsA(contains("failed converting:'throws this' to BigInt")));
    });
  });
}
