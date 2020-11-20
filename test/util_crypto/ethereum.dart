import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/ethereum.dart';

void main() {
  ethereumTest();
}

void ethereumTest() {
  const ADDRESS = '0x00a329c0648769A73afAc7F9381E08FB43dBEA72';
  test('returns false on invalid address', () {
    expect(isEthereumChecksum('0x00a329c0648769'), false);
  });

  test('returns false on non-checksum address', () {
    expect(isEthereumChecksum('0x1234567890abcdeedcba1234567890abcdeedcba'), false);
  });

  test('returns false when fully lowercase', () {
    expect(isEthereumChecksum(ADDRESS.toLowerCase()), false);
  });

  test('returns false when fully uppercase', () {
    expect(isEthereumChecksum(ADDRESS.toUpperCase().replaceAll('0X', '0x')), false);
  });

  test('returns true on a checksummed address', () {
    expect(isEthereumChecksum(ADDRESS), true);
  });

  test('returns true when fully lowercase', () {
    expect(isEthereumAddress(ADDRESS.toLowerCase()), true);
  });

  test('returns true when fully uppercase', () {
    expect(isEthereumAddress(ADDRESS.toUpperCase().replaceAll('0X', '0x')), true);
  });

  test('returns true when checksummed', () {
    expect(isEthereumAddress(ADDRESS), true);
  });

  test('returns false when empty address', () {
    expect(isEthereumAddress(null), false);
  });

  test('returns false when invalid address', () {
    expect(isEthereumAddress('0xinvalid'), false);
  });

  test('returns false when invalid address of correct length', () {
    expect(isEthereumAddress('0xinvalid000123456789012345678901234567890'), false);
  });
}
