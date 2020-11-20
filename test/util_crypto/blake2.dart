import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/blake2.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  blake2Test();
}

void blake2Test() {
  test('blake2AsU8a', () {
    var bbb = blake2AsU8a("abc", bitLength: 512);
    expect(
        u8aEq(
            bbb,
            hexToU8a(
                '0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923')),
        true);
    // print("\n");
  });
  test('blake2AsHex', () {
    expect(blake2AsHex('abc'),
        '0xbddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319'); // 0xbddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319
    expect(blake2AsHex('abc', bitLength: 64), '0xd8bb14d833d59559'); // 0xd8bb14d833d59559
    expect(blake2AsHex('abc', bitLength: 128),
        '0xcf4ab791c62b8d2b2109c90275287816'); // 0xcf4ab791c62b8d2b2109c90275287816
    expect(blake2AsHex('abc', bitLength: 512),
        '0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923'); // 0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
    expect(
        blake2AsHex(
            hexToU8a(
                '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000'),
            bitLength: 256),
        '0x1025e5db74fdaf4d2818822dccf0e1604ae9ccc62f26cecfde23448ff0248abf'); // 0x1025e5db74fdaf4d2818822dccf0e1604ae9ccc62f26cecfde23448ff0248abf

    // print(blake2AsHex(
    //     textDecoder(hexToU8a(
    //         '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000')),
    //     bitLength: 256));
    // print("\n");
  });
}
