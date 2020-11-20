import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/keccak.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  keccakTest();
}

void keccakTest() {
  final input = 'test value';
  final hex = '0x2d07364b5c231c56ce63d49430e085ea3033c750688ba532b24029124c26ca5e';
  final output = hexToU8a(hex);
  test('keccakAsU8a', () {
    expect(keccakAsU8a(input), output);
    expect(keccakAsU8a(stringToU8a(input)), output);
    expect(keccakAsU8a(stringToU8a(input, useDartEncode: false)), output);
  });
  test('keccakAsHex', () {
    expect(keccakAsHex(input), hex);
  });
}
