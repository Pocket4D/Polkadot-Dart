import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/xxhash.dart';
import 'package:p4d_rust_binding/utils/hex.dart';

void main() {
  xxhashTest();
}

void xxhashTest() {
  test('xxhash64AsValue', () {
    expect((xxhash64AsValue('abcd', 0xabcd)).toRadixString(16),
        'e29f70f8b8c96df7'); // e29f70f8b8c96df7
    expect(
        (xxhash64AsValue(Uint8List.fromList([0x61, 0x62, 0x63, 0x64]), 0xabcd)).toRadixString(16),
        'e29f70f8b8c96df7'); // e29f70f8b8c96df7
    print("\n");
  });
  test('xxhash64AsValue', () async {
    expect(
        xxhashAsU8a("abc"),
        Uint8List.fromList(
            [153, 9, 119, 173, 245, 44, 188, 68])); // [153, 9, 119, 173, 245, 44, 188, 68]
    expect(
        await xxhashAsU8aAsync("abc"),
        Uint8List.fromList(
            [153, 9, 119, 173, 245, 44, 188, 68])); // [153, 9, 119, 173, 245, 44, 188, 68]
    expect(
        hexToU8a('0x990977adf52cbc44'),
        Uint8List.fromList(
            [153, 9, 119, 173, 245, 44, 188, 68])); // [153, 9, 119, 173, 245, 44, 188, 68]
    expect(
        xxhashAsU8a('abc', bitLength: 128),
        Uint8List.fromList([
          153,
          9,
          119,
          173,
          245,
          44,
          188,
          68,
          8,
          137,
          50,
          153,
          129,
          202,
          169,
          190
        ])); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    expect(
        await xxhashAsU8aAsync("abc", bitLength: 128),
        hexToU8a(
            '0x990977adf52cbc440889329981caa9be')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]

    expect(
        xxhashAsU8a('abc', bitLength: 256),
        hexToU8a(
            '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    expect(
        await xxhashAsU8aAsync("abc", bitLength: 256),
        hexToU8a(
            '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    print("\n");
  });

  test('xxhashAsHex', () async {
    expect(xxhashAsHex("abc"), '0x990977adf52cbc44'); // 0x990977adf52cbc44
    expect(await xxhashAsHexAsync("abc"), '0x990977adf52cbc44'); // 0x990977adf52cbc44
    expect(xxhashAsHex("abc", bitLength: 128),
        '0x990977adf52cbc440889329981caa9be'); // 0x990977adf52cbc440889329981caa9be
    expect(await xxhashAsHexAsync("abc", bitLength: 128),
        '0x990977adf52cbc440889329981caa9be'); // 0x990977adf52cbc440889329981caa9be
    expect(xxhashAsHex("abc", bitLength: 256),
        '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b'); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
    expect(await xxhashAsHexAsync("abc", bitLength: 256),
        '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b'); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
    print("\n");
  });
}
