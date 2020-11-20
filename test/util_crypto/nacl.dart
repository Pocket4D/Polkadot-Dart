import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/nacl.dart';
import 'package:p4d_rust_binding/utils/string.dart';
import 'package:p4d_rust_binding/utils/u8a.dart';

void main() {
  naclTest();
}

void naclTest() async {
  test('naclKeypairFromSeed', () {
    var testU8a = stringToU8a('12345678901234567890123456789012');
    expect(
        u8aEq(
            naclKeypairFromSeed(testU8a).publicKey,
            Uint8List.fromList([
              0x2f,
              0x8c,
              0x61,
              0x29,
              0xd8,
              0x16,
              0xcf,
              0x51,
              0xc3,
              0x74,
              0xbc,
              0x7f,
              0x08,
              0xc3,
              0xe6,
              0x3e,
              0xd1,
              0x56,
              0xcf,
              0x78,
              0xae,
              0xfb,
              0x4a,
              0x65,
              0x50,
              0xd9,
              0x7b,
              0x87,
              0x99,
              0x79,
              0x77,
              0xee
            ])),
        true);
    expect(
        u8aEq(
            naclKeypairFromSeed(testU8a).secretKey,
            Uint8List.fromList([
              49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49,
              50,
              51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
              // public part
              0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
              0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
              0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
              0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
            ])),
        true);
    expect(
        u8aEq(
            naclKeypairFromSeed(testU8a, useNative: false).publicKey,
            Uint8List.fromList([
              0x2f,
              0x8c,
              0x61,
              0x29,
              0xd8,
              0x16,
              0xcf,
              0x51,
              0xc3,
              0x74,
              0xbc,
              0x7f,
              0x08,
              0xc3,
              0xe6,
              0x3e,
              0xd1,
              0x56,
              0xcf,
              0x78,
              0xae,
              0xfb,
              0x4a,
              0x65,
              0x50,
              0xd9,
              0x7b,
              0x87,
              0x99,
              0x79,
              0x77,
              0xee
            ])),
        true);
    expect(
        u8aEq(
            naclKeypairFromSeed(testU8a, useNative: false).secretKey,
            Uint8List.fromList([
              49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49,
              50,
              51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
              // public part
              0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
              0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
              0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
              0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
            ])),
        true);
    // print("\n");
  });

  test('naclKeypairFromRandom', () {
    final randomNaclKeypair = naclKeypairFromRandom();
    expect(randomNaclKeypair.publicKey.length, 32);
    expect(randomNaclKeypair.secretKey.length, 64);
    // print("\n");
  });

  test('naclKeypairFromSecret', () {
    final testNaclSecretKey = Uint8List.fromList([
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      180,
      114,
      93,
      155,
      165,
      255,
      217,
      82,
      16,
      250,
      209,
      11,
      193,
      10,
      88,
      218,
      190,
      190,
      41,
      193,
      236,
      252,
      1,
      152,
      216,
      214,
      0,
      41,
      45,
      138,
      13,
      53
    ]);
    var expectedNaclKeypairFromSecret = Uint8List.fromList([
      180,
      114,
      93,
      155,
      165,
      255,
      217,
      82,
      16,
      250,
      209,
      11,
      193,
      10,
      88,
      218,
      190,
      190,
      41,
      193,
      236,
      252,
      1,
      152,
      216,
      214,
      0,
      41,
      45,
      138,
      13,
      53
    ]);
    expect(u8aEq(naclKeypairFromSecret(testNaclSecretKey).secretKey, testNaclSecretKey), true);
    expect(u8aEq(naclKeypairFromSecret(testNaclSecretKey).publicKey, expectedNaclKeypairFromSecret),
        true);
    // print("\n");
  });

  test('naclKeypairFromString', () {
    var kpFrmStr = naclKeypairFromString('test');
    var prvFromStr = Uint8List.fromList([
      146,
      139,
      32,
      54,
      105,
      67,
      226,
      175,
      209,
      30,
      188,
      14,
      174,
      46,
      83,
      169,
      59,
      241,
      119,
      164,
      252,
      243,
      91,
      204,
      100,
      213,
      3,
      112,
      78,
      101,
      226,
      2,
      188,
      108,
      179,
      142,
      36,
      142,
      76,
      87,
      77,
      193,
      147,
      139,
      254,
      110,
      196,
      217,
      117,
      233,
      167,
      165,
      250,
      150,
      247,
      237,
      198,
      68,
      129,
      4,
      211,
      209,
      136,
      48
    ]);
    var pubFromStr = Uint8List.fromList([
      188,
      108,
      179,
      142,
      36,
      142,
      76,
      87,
      77,
      193,
      147,
      139,
      254,
      110,
      196,
      217,
      117,
      233,
      167,
      165,
      250,
      150,
      247,
      237,
      198,
      68,
      129,
      4,
      211,
      209,
      136,
      48
    ]);
    expect(u8aEq(kpFrmStr.secretKey, prvFromStr), true);
    expect(u8aEq(kpFrmStr.publicKey, pubFromStr), true);

    // print("\n");
  });

  test('naclEncrypt and naclDecrypt', () {
    var testNaclSecret = Uint8List(32);
    var testNaclMessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    var testNaclNonce = Uint8List(24);
    var testNaclEncrypted = naclEncrypt(testNaclMessage, testNaclSecret, testNaclNonce);

    var testMaclDecrypted =
        naclDecrypt(testNaclEncrypted.encrypted, testNaclEncrypted.nonce, testNaclSecret);
    expect(testNaclEncrypted.nonce, testNaclNonce);
    expect(testMaclDecrypted, testNaclMessage);
  });
  test('naclDeriveHard', () {
    print("⚠️ naclDeriveHard is not tested");
    // print("\n");
  });

  test('naclSeal and naclOpen', () {
    final naclSealmessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    final naclSealsender = naclKeypairFromString('sender');
    final naclSealreceiver = naclKeypairFromString('receiver');
    final naclSealsenderBox = naclBoxKeypairFromSecret(naclSealsender.secretKey);
    final naclSealreceiverBox = naclBoxKeypairFromSecret(naclSealreceiver.secretKey);
    final naclSealsenderBoxSecret = naclSealsenderBox.secretKey;
    final naclSealreceiverBoxPublic = naclSealreceiverBox.publicKey;

    var naclSealed = naclSeal(
        naclSealmessage, naclSealsenderBoxSecret, naclSealreceiverBoxPublic, Uint8List(24));
    expect(naclSealed.nonce, Uint8List(24));

    var naclOpened = naclOpen(naclSealed.sealed, naclSealed.nonce, naclSealsenderBox.publicKey,
        naclSealreceiverBox.secretKey);
    expect(naclOpened, naclSealmessage);
    // print("\n");
  });
}
