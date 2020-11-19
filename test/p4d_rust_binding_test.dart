import 'dart:convert';
import 'dart:typed_data';

// import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';

import 'crypto/common.dart';
import 'crypto/ed25519.dart';
import 'crypto/sr25519.dart';
import 'utils/bn.dart';
import 'utils/compact.dart';
import 'utils/hex.dart';
import 'utils/is.dart';
import 'utils/metadata.dart';
import 'utils/string.dart';
import 'utils/u8a.dart';
import 'utils/format.dart';

void main() async {
  commonTest();
  ed25519Test();
  sr25519Test();
  u8aTest();
  formatTest();
  metaDataTest();
  isTest();
  hexTest();
  bnTest();
  compactTest();
  stringTest();

  try {
    print("\n");
    print("----- extractTime");
    const milliseconds = 1e9 + 123;
    print(extractTime(milliseconds)
        .toJson()); // {"days":11,"hours":13,"milliseconds":123,"minutes":46,"seconds":40}

    print("\n");
    print("----- scryptEncode");
    var scryptEncoded = await scryptEncode("123123123");
    print(scryptEncoded); //{N:32768,p:1,r:8,password:[...],salt:[...]}
    var salt = scryptEncoded.salt;
    var sU8a = scryptToU8a(salt, scryptEncoded.params.toMap());
    print(sU8a);
    var mU8a = scryptFromU8a(sU8a);
    print(mU8a); //{N:32768,p:1,r:8,salt:[...]}

    print("\n");
    print("----- xxhash64AsValue");
    print((xxhash64AsValue('abcd', 0xabcd)).toRadixString(16)); // e29f70f8b8c96df7
    print((xxhash64AsValue(Uint8List.fromList([0x61, 0x62, 0x63, 0x64]), 0xabcd))
        .toRadixString(16)); // e29f70f8b8c96df7

    print("\n");
    print("----- xxhashAsU8a");
    print(xxhashAsU8a("abc")); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(await xxhashAsU8aAsync("abc")); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(hexToU8a('0x990977adf52cbc44')); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(xxhashAsU8a('abc',
        bitLength:
            128)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(await xxhashAsU8aAsync("abc",
        bitLength:
            128)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(hexToU8a(
        '0x990977adf52cbc440889329981caa9be')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(xxhashAsU8a('abc',
        bitLength:
            256)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    print(await xxhashAsU8aAsync("abc",
        bitLength:
            256)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    print(hexToU8a(
        '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]

    print("\n");
    print("----- xxhashAsHex");
    print(xxhashAsHex("abc")); // 0x990977adf52cbc44
    print(await xxhashAsHexAsync("abc")); // 0x990977adf52cbc44
    print(xxhashAsHex("abc", bitLength: 128)); // 0x990977adf52cbc440889329981caa9be
    print(await xxhashAsHexAsync("abc",
        bitLength: 128)); // 0x990977ad0x990977adf52cbc440889329981caa9bef52cbc44
    print(xxhashAsHex("abc",
        bitLength: 256)); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
    print(await xxhashAsHexAsync("abc",
        bitLength: 256)); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- naclKeypairFromSeed");
    var testU8a = stringToU8a('12345678901234567890123456789012');
    print(u8aEq(
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
        ])));
    print(u8aEq(
        naclKeypairFromSeed(testU8a).secretKey,
        Uint8List.fromList([
          49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          // public part
          0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
          0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
          0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
          0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
        ])));
    print(u8aEq(
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
        ])));
    print(u8aEq(
        naclKeypairFromSeed(testU8a, useNative: false).secretKey,
        Uint8List.fromList([
          49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          // public part
          0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
          0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
          0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
          0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
        ])));
    print("\n");
    print("----- naclKeypairFromRandom");
    final randomNaclKeypair = naclKeypairFromRandom();
    print(randomNaclKeypair.publicKey.length == 32);
    print(randomNaclKeypair.secretKey.length == 64);

    print("\n");
    print("----- naclKeypairFromSecret");
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
    print(u8aEq(naclKeypairFromSecret(testNaclSecretKey).secretKey, testNaclSecretKey));
    print(u8aEq(naclKeypairFromSecret(testNaclSecretKey).publicKey, expectedNaclKeypairFromSecret));

    print("\n");
    print("----- naclKeypairFromString");
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
    print(u8aEq(kpFrmStr.secretKey, prvFromStr));
    print(u8aEq(kpFrmStr.secretKey, prvFromStr));

    print("\n");
    print("----- naclEncrypt");
    var testNaclSecret = Uint8List(32);
    var testNaclMessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    var testNaclNonce = Uint8List(24);
    var testNaclEncrypted = naclEncrypt(testNaclMessage, testNaclSecret, testNaclNonce);
    print(testNaclEncrypted.encrypted);
    print(testNaclEncrypted.nonce);

    print("\n");
    print("----- naclDecrypt");
    var testMaclDecrypted =
        naclDecrypt(testNaclEncrypted.encrypted, testNaclEncrypted.nonce, testNaclSecret);
    print(testMaclDecrypted);

    print("\n");
    print("----- naclDeriveHard");

    print("\n");
    print("----- naclSeal");
    final naclSealmessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    final naclSealsender = naclKeypairFromString('sender');
    final naclSealreceiver = naclKeypairFromString('receiver');
    final naclSealsenderBox = naclBoxKeypairFromSecret(naclSealsender.secretKey);
    final naclSealreceiverBox = naclBoxKeypairFromSecret(naclSealreceiver.secretKey);
    final naclSealsenderBoxSecret = naclSealsenderBox.secretKey;
    final naclSealreceiverBoxPublic = naclSealreceiverBox.publicKey;

    var naclSealed = naclSeal(
        naclSealmessage, naclSealsenderBoxSecret, naclSealreceiverBoxPublic, Uint8List(24));

    print(naclSealed.toMap());

    print("\n");
    print("----- naclOpen");
    var naclOpened = naclOpen(naclSealed.sealed, naclSealed.nonce, naclSealsenderBox.publicKey,
        naclSealreceiverBox.secretKey);
    print(naclOpened);

    print("\n");
    print("----- blake2AsU8a");
    var bbb = blake2AsU8a("abc", bitLength: 512);
    print(u8aEq(
        bbb,
        hexToU8a(
            '0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923')));

    print("\n");
    print("---- blake2AsHex");

    print(blake2AsHex('abc')); // 0xbddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319
    print(blake2AsHex('abc', bitLength: 64)); // 0xd8bb14d833d59559
    print(blake2AsHex('abc', bitLength: 128)); // 0xcf4ab791c62b8d2b2109c90275287816
    print(blake2AsHex('abc',
        bitLength:
            512)); // 0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
    print(blake2AsHex(
        hexToU8a(
            '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000'),
        bitLength: 256)); // 0x1025e5db74fdaf4d2818822dccf0e1604ae9ccc62f26cecfde23448ff0248abf

    print(blake2AsHex(
        textDecoder(hexToU8a(
            '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000')),
        bitLength: 256));
  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- keyExtractPath");
    var keyExtractPathResult = keyExtractPath('/1');
    print(keyExtractPathResult.parts); // ["/1"]
    print(keyExtractPathResult.path.length); // 1
    print(keyExtractPathResult.path[0].isHard); // false
    print(keyExtractPathResult.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    var keyExtractPathResult2 = keyExtractPath('//1');
    print(keyExtractPathResult2.parts); // ["//1"]
    print(keyExtractPathResult2.path.length); // 1
    print(keyExtractPathResult2.path[0].isHard); // true
    print(keyExtractPathResult2.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    var keyExtractPathResult3 = keyExtractPath('//1/2');
    print(keyExtractPathResult3.parts); // ["//1","/2"]
    print(keyExtractPathResult3.path.length); // 2
    print(keyExtractPathResult3.path[0].isHard); // true
    print(keyExtractPathResult3.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractPathResult3.path[1].isHard); // false
    print(keyExtractPathResult3.path[1]
        .chainCode); // Uint8List.fromList([2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    print("\n");
    print("----- keyExtractSuri");
    var keyExtractSuriTest = keyExtractSuri('hello world');
    print(keyExtractSuriTest.phrase); // 'hello world'
    print(keyExtractSuriTest.path.length); // 0

    var keyExtractSuriTest2 = keyExtractSuri('hello world/1');
    print(keyExtractSuriTest2.password); // ''
    print(keyExtractSuriTest2.phrase); // 'hello world'
    print(keyExtractSuriTest2.path.length); // 1
    print(keyExtractSuriTest2.path[0].isHard); // false
    print(keyExtractSuriTest2.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest3 = keyExtractSuri('hello world/DOT');
    print(keyExtractSuriTest3.password); // ''
    print(keyExtractSuriTest3.phrase); // 'hello world'
    print(keyExtractSuriTest3.path.length); // 1
    print(keyExtractSuriTest3.path[0].isHard); // false
    print(keyExtractSuriTest3.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest4 = keyExtractSuri('hello world//1');
    print(keyExtractSuriTest4.password); // ''
    print(keyExtractSuriTest4.phrase); // 'hello world'
    print(keyExtractSuriTest4.path.length); // 1
    print(keyExtractSuriTest4.path[0].isHard); // true
    print(keyExtractSuriTest4.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest5 = keyExtractSuri('hello world//DOT');
    print(keyExtractSuriTest5.password); // ''
    print(keyExtractSuriTest5.phrase); // 'hello world'
    print(keyExtractSuriTest5.path.length); // 1
    print(keyExtractSuriTest5.path[0].isHard); // true
    print(keyExtractSuriTest5.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest6 = keyExtractSuri('hello world//1/DOT');
    print(keyExtractSuriTest6.password); // ''
    print(keyExtractSuriTest6.phrase); // 'hello world'
    print(keyExtractSuriTest6.path.length); // 2
    print(keyExtractSuriTest6.path[0].isHard); // true
    print(keyExtractSuriTest6.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest6.path[1].isHard); // false
    print(keyExtractSuriTest6.path[1]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest7 = keyExtractSuri('hello world//DOT/1');
    print(keyExtractSuriTest7.password); // ''
    print(keyExtractSuriTest7.phrase); // 'hello world'
    print(keyExtractSuriTest7.path.length); // 2
    print(keyExtractSuriTest7.path[0].isHard); // false
    print(keyExtractSuriTest7.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest7.path[1].isHard); // true
    print(keyExtractSuriTest7.path[1]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest8 = keyExtractSuri('hello world///password');
    print("\n");
    print(keyExtractSuriTest8.password); // 'password'
    print(keyExtractSuriTest8.phrase); // 'hello world'
    print(keyExtractSuriTest8.path.length); // 0

    var keyExtractSuriTest9 = keyExtractSuri('hello world//1/DOT///password');
    print("\n");
    print(keyExtractSuriTest9.password); // 'password'
    print(keyExtractSuriTest9.phrase); // 'hello world'
    print(keyExtractSuriTest9.path.length); // 0
    print(keyExtractSuriTest9.path[0].isHard); // true
    print(keyExtractSuriTest9.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest9.path[1].isHard); // false
    print(keyExtractSuriTest9.path[1]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest10 = keyExtractSuri(
        'bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice/1///password');
    print("\n");
    print(keyExtractSuriTest10.password); // 'password'
    print(keyExtractSuriTest10
        .phrase); // 'bottom drive obey lake curtain smoke basket hold race lonely fit walk world'
    print(keyExtractSuriTest10.path.length); // 2
    print(keyExtractSuriTest10.path[0].isHard); // true
    print(keyExtractSuriTest10.path[0]
        .chainCode); // Uint8List.fromList([20, 65, 108, 105, 99, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest10.path[1].isHard); // false
    print(keyExtractSuriTest10.path[1]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- schnorrkel");
    const tests = [
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about',
        '0x00000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank yellow',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0x4313249608fe8ac10fd5886c92c4579007272cb77c21551ee5b8d60b780416850f1e26c1f4b8d88ece681cb058ab66d6182bc2ce5a03181f7b74c27576b5c8bf',
        '0x20666c9dd63c5b04a6a14377579af14aba60707752d134726304d0804992e26f9092c47fbb9e14c02fd53c702c8a3cfca4735638599da5c4362e0d0560dceb58'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage above',
        '0x80808080808080808080808080808080',
        '0x27f3eb595928c60d5bc91a4d747da40ed236328183046892ed6cd5aa9ae38122acd1183adf09a89839acb1e6eaa7fb563cc958a3f9161248d5a036e0d0af533d',
        '0x709e8254d0a9543c6b35b145dd23349e6369d487a1d10b0cfe09c05ff521f4691ad8bb8221339af38fc48510ec2dfc3104bb94d38f1fa241ceb252943df7b6b5'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong',
        '0xffffffffffffffffffffffffffffffff',
        '0x227d6256fd4f9ccaf06c45eaa4b2345969640462bbb00c5f51f43cb43418c7a753265f9b1e0c0822c155a9cabc769413ecc14553e135fe140fc50b6722c6b9df',
        '0x88206f4b4102ad30ee40b4b5943c5259db77fd576d95d79eeea00160197e406308821814dea9442675a5d3fa375b3bd65ffe92be43e07dbf6bb4ab84e9d4449d'
      ],
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon agent',
        '0x000000000000000000000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal will',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0xcb1d50e14101024a88905a098feb1553d4306d072d7460e167a60ccb3439a6817a0afc59060f45d999ddebc05308714733c9e1e84f30feccddd4ad6f95c8a445',
        '0x50dcb74f223740d6a256000a2f1ccdb60044b39ce3aad71a3bd7761848d5f55d5a34f96e0b96ecb45d7a142e07ddfde734f9525f9f88310ab50e347da5789d3e'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic avoid letter always',
        '0x808080808080808080808080808080808080808080808080',
        '0x9ddecf32ce6bee77f867f3c4bb842d1f0151826a145cb4489598fe71ac29e3551b724f01052d1bc3f6d9514d6df6aa6d0291cfdf997a5afdb7b6a614c88ab36a',
        '0x88112947a30e864b511838b6daf6e1e13801ae003d6d9b73eb5892c355f7e37ab3bb71200092d004467b06fe67bc153ee4e2bb7af2f544815b0dde276d2dae75'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo when',
        '0xffffffffffffffffffffffffffffffffffffffffffffffff',
        '0x8971cb290e7117c64b63379c97ed3b5c6da488841bd9f95cdc2a5651ac89571e2c64d391d46e2475e8b043911885457cd23e99a28b5a18535fe53294dc8e1693',
        '0x4859cdeda3f957b7ffcd2d59257c30e43996796f38e1be5c6136c9bf3744e047ce9a52c11793c98d0dc8caee927576ce46ef2e5f4b3f1d5e4b1344b2c31ebe8e'
      ],
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art',
        '0x0000000000000000000000000000000000000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth title',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0x3037276a5d05fcd7edf51869eb841bdde27c574dae01ac8cfb1ea476f6bea6ef57ab9afe14aea1df8a48f97ae25b37d7c8326e49289efb25af92ba5a25d09ed3',
        '0xe8962ace15478f69fa42ddd004aad2c285c9f5a02e0712860e83fbec041f89489046aa57b21db2314d93aeb4a2d7cbdab21d4856e8e151894abd17fb04ae65e1'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic bless',
        '0x8080808080808080808080808080808080808080808080808080808080808080',
        '0x2c9c6144a06ae5a855453d98c3dea470e2a8ffb78179c2e9eb15208ccca7d831c97ddafe844ab933131e6eb895f675ede2f4e39837bb5769d4e2bc11df58ac42',
        '0x78667314bf1e52e38d29792cdf294efcaddadc4fa9ce48c5f2bef4daad7ed95d1db960d6f6f895c1a9d2a3ddcc0398ba6578580ea1f03f65ea9a68e97cf3f840'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo vote',
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        '0x047e89ef7739cbfe30da0ad32eb1720d8f62441dd4f139b981b8e2d0bd412ed4eb14b89b5098c49db2301d4e7df4e89c21e53f345138e56a5e7d63fae21c5939',
        '0xe09f4ae0d4e22f6c9bbc4251c880e73d93d10fdf7f152c393ce36e4e942b3155a6f4b48e6c6ebce902a10d4ab46ef59cd154c15aeb8f7fcd4e1e26342d40806d'
      ],
      [
        'ozone drill grab fiber curtain grace pudding thank cruise elder eight picnic',
        '0x9e885d952ad362caeb4efe34a8e91bd2',
        '0xf4956be6960bc145cdab782e649a5056598fd07cd3f32ceb73421c3da27833241324dc2c8b0a4d847eee457e6d4c5429f5e625ece22abaa6a976e82f1ec5531d',
        '0xb0eb046f48eacb7ad6c4da3ff92bfc29c9ad471bae3e554d5d63e58827160c70c7e5165598761f96b5659ab28c474f50e89ee13c67e30bca40fdcf4335835649'
      ],
      [
        'gravity machine north sort system female filter attitude volume fold club stay feature office ecology stable narrow fog',
        '0x6610b25967cdcca9d59875f5cb50b0ea75433311869e930b',
        '0xfbcc5229ade0c0ff018cb7a329c5459f91876e4dde2a97ddf03c832eab7f26124366a543f1485479c31a9db0d421bda82d7e1fe562e57f3533cb1733b001d84d',
        '0xd8da734285a13967647dd906288e1ac871e1945d0c6b72fa259de4051a9b75431be0c4eb40b1ca38c780f445e3e2809282b9efef4dcc3538355e68094f1e79fa'
      ],
      [
        'hamster diagram private dutch cause delay private meat slide toddler razor book happy fancy gospel tennis maple dilemma loan word shrug inflict delay length',
        '0x68a79eaca2324873eacc50cb9c6eca8cc68ea5d936f98787c60c7ebc74e6ce7c',
        '0x7c60c555126c297deddddd59f8cdcdc9e3608944455824dd604897984b5cc369cad749803bb36eb8b786b570c9cdc8db275dbe841486676a6adf389f3be3f076',
        '0x883b72fa7fb06b6abd0fc2cdb0018b3578e086e93074256bbbb8c68e53c04a56391bc0d19d7b2fa22a8148ccbe191d969c4323faca1935a576cc1b24301f203a'
      ],
      [
        'scheme spot photo card baby mountain device kick cradle pact join borrow',
        '0xc0ba5a8e914111210f2bd131f3d5e08d',
        '0xc12157bf2506526c4bd1b79a056453b071361538e9e2c19c28ba2cfa39b5f23034b974e0164a1e8acd30f5b4c4de7d424fdb52c0116bfc6a965ba8205e6cc121',
        '0x7039a64150089f8d43188af964c7b8e2b8c9ba20aede085baca5672e978a47576c7193c3e557f37cdeeee5e5131b854e4309efc55259b050474e1f0884a7a621'
      ],
      [
        'horn tenant knee talent sponsor spell gate clip pulse soap slush warm silver nephew swap uncle crack brave',
        '0x6d9be1ee6ebd27a258115aad99b7317b9c8d28b6d76431c3',
        '0x23766723e970e6b79dec4d5e4fdd627fd27d1ee026eb898feb9f653af01ad22080c6f306d1061656d01c4fe9a14c05f991d2c7d8af8730780de4f94cd99bd819',
        '0xe07a1f3073edad5b63585cdf1d5e6f8e50e3145de550fc8eb1fb430cce62d76d251904272c5d25fd634615d413bb31a2bc7b5d6eeb2f6ddc68a2b95ac6bd49bc'
      ],
      [
        'panda eyebrow bullet gorilla call smoke muffin taste mesh discover soft ostrich alcohol speed nation flash devote level hobby quick inner drive ghost inside',
        '0x9f6a2878b2520799a44ef18bc7df394e7061a224d2c33cd015b157d746869863',
        '0xf4c83c86617cb014d35cd87d38b5ef1c5d5c3d58a73ab779114438a7b358f457e0462c92bddab5a406fe0e6b97c71905cf19f925f356bc673ceb0e49792f4340',
        '0x607f8595266ac0d4aa91bf4fddbd2a868889317f40099979be9743c46c418976e6ff3717bd11b94b418f91c8b88eae142cecb19104820997ddf5a379dd9da5ae'
      ],
      [
        'cat swing flag economy stadium alone churn speed unique patch report train',
        '0x23db8160a31d3e0dca3688ed941adbf3',
        '0x719d4d4de0638a1705bf5237262458983da76933e718b2d64eb592c470f3c5d222e345cc795337bb3da393b94375ff4a56cfcd68d5ea25b577ee9384d35f4246',
        '0xd078b66bb357f1f06e897a6fdfa2f3dfb0da05836ded1fd0793373068b7e854e783a548a6d194f142e1ba78bf42a49fa58e3673b363ba6f6494efffa28f168df'
      ],
      [
        'light rule cinnamon wrap drastic word pride squirrel upgrade then income fatal apart sustain crack supply proud access',
        '0x8197a4a47f0425faeaa69deebc05ca29c0a5b5cc76ceacc0',
        '0x7ae1291db32d16457c248567f2b101e62c5549d2a64cd2b7605d503ec876d58707a8d663641e99663bc4f6cc9746f4852e75e7e54de5bc1bd3c299c9a113409e',
        '0x5095fe4d0144b06e82aa4753d595fd10de9bba3733eba8ce0784417182317e725fac31b2fb53f4856a5e38866501425b485f4d2eaf2666a9f20ae68f4331ed2c'
      ],
      [
        'all hour make first leader extend hole alien behind guard gospel lava path output census museum junior mass reopen famous sing advance salt reform',
        '0x066dca1a2bb7e8a1db2832148ce9933eea0f3ac9548d793112d9a95c9407efad',
        '0xa911a5f4db0940b17ecb79c4dcf9392bf47dd18acaebdd4ef48799909ebb49672947cc15f4ef7e8ef47103a1a91a6732b821bda2c667e5b1d491c54788c69391',
        '0x8844cb50f3ba8030ab61afee623534836d4ea3677d42bae470fc5e251ea0ca7ec9ea65c8c40be191c7c8683165848279ced81f3a121c9450078a496b6c59f610'
      ],
      [
        'vessel ladder alter error federal sibling chat ability sun glass valve picture',
        '0xf30f8c1da665478f49b001d94c5fc452',
        '0x4e2314ca7d9eebac6fe5a05a5a8d3546bc891785414d82207ac987926380411e559c885190d641ff7e686ace8c57db6f6e4333c1081e3d88d7141a74cf339c8f',
        '0x18917f0c7480c95cd4d98bdc7df773c366d33590252707da1358eb58b43a7b765e3c513878541bfbfb466bb4206f581edf9bf601409c72afac130bcc8b5661b5'
      ],
      [
        'scissors invite lock maple supreme raw rapid void congress muscle digital elegant little brisk hair mango congress clump',
        '0xc10ec20dc3cd9f652c7fac2f1230f7a3c828389a14392f05',
        '0x7a83851102849edc5d2a3ca9d8044d0d4f00e5c4a292753ed3952e40808593251b0af1dd3c9ed9932d46e8608eb0b928216a6160bd4fc775a6e6fbd493d7c6b2',
        '0xb0bf86b0955413fc95144bab124e82042d0cce9c292c1bfd0874ae5a95412977e7bc109aeef33c7c90be952a83f3fe528419776520de721ef6ec9e814749c3fc'
      ],
      [
        'void come effort suffer camp survey warrior heavy shoot primary clutch crush open amazing screen patrol group space point ten exist slush involve unfold',
        '0xf585c11aec520db57dd353c69554b21a89b20fb0650966fa0a9d6f74fd989d8f',
        '0x938ba18c3f521f19bd4a399c8425b02c716844325b1a65106b9d1593fbafe5e0b85448f523f91c48e331995ff24ae406757cff47d11f240847352b348ff436ed',
        '0xc07ba4a979657576f4f7446e3bd2672c87131fa0f472a8bc1f2e9b28c11fb04c66da12cd280662196a5888d8a77178dab8034ed42b11d1654a31db6e1ff4d4c5'
      ]
    ];
    var test2 = stringToU8a('12345678901234567890123456789012');
    var result2 = {
      "publicKey": Uint8List.fromList([
        116,
        28,
        8,
        160,
        111,
        65,
        197,
        150,
        96,
        143,
        103,
        116,
        37,
        155,
        217,
        4,
        51,
        4,
        173,
        250,
        93,
        62,
        234,
        98,
        118,
        11,
        217,
        190,
        151,
        99,
        77,
        99
      ]),
      "secretKey": Uint8List.fromList([
        240,
        16,
        102,
        96,
        195,
        221,
        162,
        63,
        22,
        218,
        169,
        172,
        91,
        129,
        27,
        150,
        48,
        119,
        245,
        188,
        10,
        248,
        159,
        133,
        128,
        79,
        13,
        232,
        228,
        36,
        240,
        80,
        249,
        141,
        102,
        243,
        148,
        66,
        80,
        111,
        249,
        71,
        253,
        145,
        31,
        24,
        199,
        167,
        165,
        218,
        99,
        154,
        99,
        232,
        211,
        180,
        226,
        51,
        247,
        65,
        67,
        217,
        81,
        193
      ])
    };

    // schnorrkelKeypairFromSeed(test2);
    print(schnorrkelKeypairFromSeed(test2).toJson() == json.encode(result2));

    tests.forEach((t) {
      var seed = mnemonicToMiniSecret(t[0], 'Substrate');
      var pair = schnorrkelKeypairFromSeed(seed);
      print(u8aToHex(pair.secretKey) == t[3]);
    });

    var schnorrkelMessage = stringToU8a('this is a message');
    var kp = schnorrkelKeypairFromSeed(randomAsU8a());
    var schnorrkelSig = schnorrkelSign(schnorrkelMessage, kp);
    print(schnorrkelSig.length == 64);
    print(schnorrkelVerify(schnorrkelMessage, schnorrkelSig, kp.publicKey));
  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- secp256k1");
    const secp256k1Tests = [
      [
        'life fee table ahead modify maximum dumb such tobacco boss dry nurse',
        '0xf2360e871c830d397fe221382b503f07ddd8763df81a94bb2504390a2fb91f59',
        '0x036b0aa6beab469dd2b748a0ff5ddbe3d13df1e15c9d28a2aa057212994e127bea',
        '0xae8e8fcacbaeb607bcdf0bbd7e615f2b4ef484ee54f19d68a7393fb6db2dd9cd'
      ],
      [
        'tide survey cradle cover column ugly author wait eye state elder blame',
        '0x5385355a5118ec732b9dbcf1668ba21db38b07cf79082dafa9a7cc4b52e4abb0',
        '0x03929e4f93cdad265751ad8f6365185d8e937610d19b510400f5867d542d60a313',
        '0xf80ea815da66c42f870b687e1530770d5a7936ae81a147b009506d85bd6d621c'
      ],
      [
        'laugh fish flee cake approve butter april dynamic myth license ticket lobster',
        '0x83ec65cf9a8a7442d808aef6f8987599f1ba3be880769bb3a20621b13adbd476',
        '0x0388299e4cfaa33d180a026bd54a46ad98df129a131320a9d2fd6f80e64bc3db39',
        '0x35036238dd195f4c2169379354bda6cba5746f67bde03ef59a77a4cea80729bc'
      ],
      [
        'animal thing fork recipe exotic pilot inquiry pledge obey slab obtain reveal',
        '0x0fd50580eb5a58b0eee60c77656dffa50094b539262366f1227d3babfd7343e5',
        '0x036edc954685ad89f0a23b0fb1eb2b9c3a8600eee9091c758426dfb2bc7889a7c3',
        '0x2a94b10d1f28810dc4628e7e424b2d08bd3d17fb08f9416d112f17e86c8fa77c'
      ]
    ];

    var singleTest = hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae');
    var singleResult = KeyPair.fromMap({
      "publicKey": hexToU8a('0x03fd8c74f795ced92064b86191cb2772b1e3a0947740aa0a5a6e379592471fd85b'),
      "secretKey": hexToU8a('0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae')
    });
    print(secp256k1KeypairFromSeed(singleTest).toJson() == singleResult.toJson());

    secp256k1Tests.forEach((t) {
      var phrase = t[0];
      var sk = t[1];
      var pk = t[2];
      var seed = mnemonicToMiniSecret(phrase);
      var pair = secp256k1KeypairFromSeed(seed);
      print(u8aToHex(pair.secretKey) == sk);
      print(u8aToHex(pair.publicKey) == pk);
    });
  } catch (e) {
    throw e;
  }
}
