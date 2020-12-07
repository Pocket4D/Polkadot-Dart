import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/utils/bn.dart';
import 'package:polkadot_dart/utils/compact.dart';
import 'package:polkadot_dart/utils/hex.dart';
import 'package:polkadot_dart/utils/u8a.dart';

void main() {
  compactTest();
}

void compactTest() {
  test('compactToU8a', () {
    expect(compactToU8a(18), Uint8List.fromList([18 << 2])); // Uint8List.fromList([18 << 2])
    expect(
        compactToU8a(BigInt.from(63)),
        bnToU8a(BigInt.tryParse('11111100',
            radix:
                2))); // new Uint8Array([0b11111100]) -> expect(bnToU8a(BigInt.tryParse('11111100', radix: 2)));
    expect(
        compactToU8a(511),
        bnToU8a(BigInt.tryParse('0000011111111101', radix: 2),
            endian: Endian
                .little)); // new Uint8Array([0b11111101, 0b00000111]) -> expect(bnToU8a(BigInt.tryParse('0000011111111101', radix: 2), endian: Endian.little));
    expect(compactToU8a(111), Uint8List.fromList([0xbd, 0x01])); // new Uint8Array([0xbd, 0x01])

    expect(
        compactToU8a(0x1fff), Uint8List.fromList([253, 127])); // new Uint8Array([254, 255, 3, 0])
    expect(compactToU8a(0xffff),
        Uint8List.fromList([254, 255, 3, 0])); // new Uint8Array([254, 255, 3, 0])

    expect(
        compactToU8a(0xfffffff9),
        Uint8List.fromList([
          3 + ((4 - 4) << 2),
          249,
          255,
          255,
          255
        ])); // new Uint8Array([3 + ((4 - 4) << 2), 249, 255, 255, 255])

    expect(
        compactToU8a(BigInt.parse('00005af3107a4000', radix: 16)),
        Uint8List.fromList([
          3 + ((6 - 4) << 2),
          0x00,
          0x40,
          0x7a,
          0x10,
          0xf3,
          0x5a
        ])); // new Uint8Array([3 + ((6 - 4) << 2), 0x00, 0x40, 0x7a, 0x10, 0xf3, 0x5a])
    // print("\n");
  });
  test('compactToU8a testCases', () {
    List<Map<String, dynamic>> testCases = [
      {"expected": '00', "value": BigInt.parse('0')},
      {"expected": 'fc', "value": BigInt.parse('63')},
      {"expected": '01 01', "value": BigInt.parse('64')},
      {"expected": 'fd ff', "value": BigInt.parse('16383')},
      {"expected": '02 00 01 00', "value": BigInt.parse('16384')},
      {"expected": 'fe ff ff ff', "value": BigInt.parse('1073741823')},
      {"expected": '03 00 00 00 40', "value": BigInt.parse('1073741824')},
      {
        "expected": '03 ff ff ff ff',
        "value": BigInt.parse("${1}${'0' * (32)}", radix: 2) - BigInt.one
      },
      {"expected": '07 00 00 00 00 01', "value": BigInt.parse("1${'0' * (32)}", radix: 2)},
      {"expected": '0b 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (40)}", radix: 2)},
      {"expected": '0f 00 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (48)}", radix: 2)},
      {
        "expected": '0f ff ff ff ff ff ff ff',
        "value": BigInt.parse("1${'0' * (56)}", radix: 2) - BigInt.one
      },
      {"expected": '13 00 00 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (56)}", radix: 2)},
      {
        "expected": '13 ff ff ff ff ff ff ff ff',
        "value": BigInt.parse("1${'0' * (64)}", radix: 2) - BigInt.one
      }
    ];

    testCases.forEach((t) {
      var map = Map<String, dynamic>.from(t);
      var expected = map["expected"] as String;
      var u8List = Uint8List.fromList(expected.split(" ").map((element) {
        return int.parse(element, radix: 16);
      }).toList());
      expect(u8aEq(u8List, compactToU8a(map["value"] as BigInt)), true);
    });
    // print("\n");
  });

  test('compactAddLength', () {
    expect(compactAddLength(Uint8List.fromList([12, 13])),
        Uint8List.fromList([8, 12, 13])); // [8, 12, 13]
    // print("\n");
  });
  test('compactStripLength', () {
    expect(compactStripLength(Uint8List.fromList([2 << 2, 12, 13])), [
      3,
      [12, 13]
    ]); // [8, 12, 13]
    // print("\n");
  });
  group('compactFromU8a', () {
    test('decoded u8 value', () {
      expect(compactFromU8a(Uint8List.fromList([int.parse("11111100", radix: 2)])),
          [1, BigInt.from(63)]);
    });

    test('decodes from same u16 encoded value', () {
      expect(
          compactFromU8a(
              Uint8List.fromList(
                  [int.parse('11111101', radix: 2), int.parse('00000111', radix: 2)]),
              bitLength: 32),
          [2, BigInt.from(511)]);
    });

    test('decodes from same u32 encoded value (short)', () {
      expect(compactFromU8a(Uint8List.fromList([254, 255, 3, 0]), bitLength: 32),
          [4, BigInt.from(0xffff)]);
    });

    test('decodes from same u32 encoded value (full)', () {
      expect(compactFromU8a(Uint8List.fromList([3, 249, 255, 255, 255]), bitLength: 32),
          [5, BigInt.from(0xfffffff9)]);
    });

    test('decodes from same u32 as u64 encoded value (full, default)', () {
      expect(
          compactFromU8a(Uint8List.fromList([3 + ((4 - 4) << 2), 249, 255, 255, 255]),
              bitLength: 64),
          [5, BigInt.from(0xfffffff9)]);
    });

    test('decodes an actual value', () {
      expect(compactFromU8a(hexToU8a('0x0b00407a10f35a')),
          [7, BigInt.parse('5af3107a4000', radix: 16)]);
    });
  });
}
