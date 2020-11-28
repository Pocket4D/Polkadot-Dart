import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/sha512.dart';

void main() {
  sha512Test();
}

void sha512Test() {
  group("sha512AsU8a", () {
    test("creates a sha-512 hash )", () {
      expect(
          sha512AsU8a(Uint8List.fromList([0x61, 0x62, 0x63, 0x64])),
          Uint8List.fromList([
            216,
            2,
            47,
            32,
            96,
            173,
            110,
            253,
            41,
            122,
            183,
            61,
            204,
            83,
            85,
            201,
            178,
            20,
            5,
            75,
            13,
            23,
            118,
            161,
            54,
            166,
            105,
            210,
            106,
            125,
            59,
            20,
            247,
            58,
            160,
            208,
            235,
            255,
            25,
            238,
            51,
            51,
            104,
            240,
            22,
            75,
            100,
            25,
            169,
            109,
            164,
            158,
            62,
            72,
            23,
            83,
            231,
            233,
            107,
            113,
            107,
            220,
            203,
            111
          ]));
    });
  });
}
