import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/utils/extension.dart';
import 'package:polkadot_dart/utils/is.dart'; // use extendsion methods for fast data format converting

void main() {
  extensionTest(); // rename this test name
}

void extensionTest() {
  group('extension', () {
    // group global var // use for global setting for serial tests
    group("on String", () {
      testExt(String to, String value, dynamic result, [dynamic params1, dynamic params2]) {
        test("$to with $value | [${params1 ?? ''},${params2 ?? ''}]", () {
          switch (to) {
            case "isHex":
              expect(value.isHex(params1 ?? -1, params2 ?? false), result);
              break;
            case "isHexString":
              expect(value.isHexString(), result);
              break;
            case "camelCase":
              expect(value.camelCase(), result);
              break;
            default:
              break;
          }
        });
      }

      testExt("isHex", "123", false);
      testExt("isHex", "0x1234", true, 16);
      testExt("isHex", "0x1234", false, 8);
      testExt("isHex", "0x1234", true);
      testExt("isHex", "0x1234", true, -1, true);
      testExt("isHex", "0x12345", false);

      testExt("isHexString", "0x1234", true);
      testExt("isHexString", "1234", true);
      testExt("isHexString", "ab12", true);
      testExt("isHexString", "lolz", false);

      testExt("camelCase", "SUBSTRATE", "substrate");
      testExt("camelCase", "SubStrate", "subStrate");
      testExt("camelCase", "substrate", "substrate");
      testExt("camelCase", "subStrate", "subStrate");
    });

    group("on BigInt", () {
      testExt(String to, BigInt value, dynamic result,
          [dynamic params1, dynamic params2, dynamic params3, dynamic params4]) {
        test("$to with $value | [${params1 ?? ''},${params2 ?? ''}]", () {
          switch (to) {
            case "toBn":
              expect(value.toBn(), result);
              break;
            case "toHex":
              expect(
                  value.toHex(
                      bitLength: params1 ?? -1,
                      endian: params2 ?? Endian.big,
                      isNegative: params3 ?? false),
                  result);
              break;
            case "bitNot":
              expect(value.bitNot(bitLength: params1), result);
              break;
            default:
              break;
          }
        });
      }

      testExt("toBn", BigInt.from(100), BigInt.from(100));

      testExt("toHex", BigInt.from(128), "0x80");
      testExt("toHex", BigInt.from(128), "0x0080", 16);
      testExt("toHex", BigInt.from(128), "0x8000", 16, Endian.little);
      testExt("toHex", BigInt.from(-1234), "0xfb2e", null, null, true);
      testExt("toHex", BigInt.from(1234), "0xfffffb2e", 32, null, true);

      // testExt("bitNot", BigInt.from(100), "substrate");
      // testExt("bitNot", BigInt.from(100), "subStrate");
      // testExt("bitNot", BigInt.from(100), "substrate");
      // testExt("bitNot", BigInt.from(100), "subStrate");

      // print(BigInt.from(10000000).bitNot());
    });
  });
}
