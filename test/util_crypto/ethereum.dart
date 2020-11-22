import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/ethereum.dart';
import 'package:p4d_rust_binding/util_crypto/keccak.dart';

import '../testUtils/throws.dart';

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

  group('formatAddress', () {
    group('address to address encoding', () {
      const ADDRESS = '0x00a329c0648769A73afAc7F9381E08FB43dBEA72';

      test('returns 0x for no address', () {
        expect(ethereumEncode(null), '0x');
      });

      test('returns fails on invalid address', () {
        expect(() => ethereumEncode('0xnotaddress'),
            throwsA(assertionThrowsContains("Invalid address or publicKey passed")));
      });

      test('converts lowercase to the checksummed address', () {
        expect(ethereumEncode(ADDRESS.toLowerCase()), ADDRESS);
      });

      test('converts uppercase to the checksummed address', () {
        expect(ethereumEncode(ADDRESS.toUpperCase().replaceAll('0X', '0x')), ADDRESS);
      });

      test('returns formatted address on checksum input', () {
        expect(ethereumEncode(ADDRESS), ADDRESS);
      });
    });

    group('from publicKey', () {
      const ADDRESS = '0x4119b2e6c3Cb618F4f0B93ac77f9BeeC7FF02887';

      test('encodes a compressed publicKey', () {
        expect(
            ethereumEncode('0x03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077'),
            ADDRESS);
      });

      test('encodes an expanded publicKey', () {
        expect(
            ethereumEncode(
                '0x04b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af'),
            ADDRESS);
      });

      test('encodes a pre-hashed key', () {
        expect(
            ethereumEncode(keccakAsU8a(
                '0xb9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af')),
            ADDRESS);
      });
    });
  });
}
