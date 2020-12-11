import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  uintTest(); // rename this test name
}

void uintTest() {
  final registry = TypeRegistry();
  test('fails on a number that is too large for the bits specified', () {
    expect(
        () => UInt(registry, '12345678901234567890123456789012345678901234567890', 32),
        throwsA(assertionThrowsContains(
            'u32: Input too large. Found input with 164 bits, expected 32')));
  });

  test('fails on negative numbers', () {
    expect(() => UInt(registry, -123, 32),
        throwsA(assertionThrowsContains('u32: Negative number passed to unsigned type')));
  });

  test('allows for construction via BigInt', () {
    expect(UInt(registry, BigInt.parse('123456789123456789123456789'), 128).toHuman(),
        '123,456,789,123,456,789,123,456,789');
  });

  test('provides a toBigInt interface', () {
    expect(UInt(registry, BigInt.parse('9876543210123456789')).toBigInt(),
        BigInt.parse('9876543210123456789'));
  });

  test('provides a toBn interface', () {
    expect(UInt(registry, 987).toBn().toInt(), 987);
  });

  test('provides a toNumber interface', () {
    expect(UInt(registry, 4567).toNumber(), 4567);
  });

  test('converts to Little Endian from the provided value', () {
    expect(UInt(registry, 1234567).toU8a(), Uint8List.fromList([135, 214, 18, 0, 0, 0, 0, 0]));
  });

  test('converts to Little Endian from the provided value (bitLength)', () {
    expect(UInt(registry, 1234567, 32).toU8a(), Uint8List.fromList([135, 214, 18, 0]));
  });

  test('converts to hex/string', () {
    final u = UInt(registry, '0x12', 16);

    expect(u.toHex(), '0x0012');
    expect(u.toString(), '18');
  });

  test('converts to equivalents', () {
    final a = UInt(registry, '123');

    expect(UInt(registry, a).toNumber(), 123);
  });

  test('converts to JSON representation based on size', () {
    expect(UInt(registry, '0x12345678', 64).toJSON(), 0x12345678);
    expect(UInt(registry, '0x1234567890', 64).toJSON(), 0x1234567890);
    expect(UInt(registry, '0x1234567890abcdef', 64).toJSON(), '0x1234567890abcdef');
  });

  group('eq', () {
    final toTest = UInt(registry, 12345);

    test('compares against other BN values', () {
      expect(toTest.eq(BigInt.from(12345)), true);
    });

    test('compares against other number values', () {
      expect(toTest.eq(12345), true);
    });

    test('compares against hex values', () {
      expect(toTest.eq('0x3039'), true);
    });
  });

  group('isMax()', () {
    test('is false where not full', () {
      expect(UInt(registry, '0x1234', 32).isMax(), false);
      expect(UInt(registry, '0xffffff', 32).isMax(), false);
      expect(UInt(registry, '0x12345678', 32).isMax(), false);
      expect(UInt(registry, '0xfffffff0', 32).isMax(), false);
    });

    test('is true when full', () {
      expect(UInt(registry, '0xffffffff', 32).isMax(), true);
    });
  });

  group('static with', () {
    test('allows default toRawType', () {
      expect((UInt.withParams(64))(registry).toRawType(), 'u64');
    });

    test('allows toRawType override', () {
      expect((UInt.withParams(64, 'SomethingElse'))(registry).toRawType(), 'SomethingElse');
    });

    test('has proper toHuman() for PerMill/PerBill/Percent/Balance', () {
      BalanceFormatter.instance
          .setDefaults(Defaults(decimals: 0, unit: SI[SI_MID]["text"] as String));
      expect(registry.createType('Perbill', 12340000).toHuman(), '1.23%');
      expect(registry.createType('Percent', 12).toHuman(), '12.00%');
      expect(registry.createType('Permill', 16900).toHuman(), '1.69%');
      expect(registry.createType('Balance', '123456789012345').toHuman(), '123.4567 Unit');
    });
  });
}
