import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/random.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  randomTest();
}

void randomTest() {
  group('randomAsU8a', () {
    test('generates a Uint8Array', () {
      expect(isU8a(randomAsU8a()), true);
    });

    test('generated results does not match', () {
      expect(u8aEq(randomAsU8a(), randomAsU8a()), false);
    });

    test('generates 32 bytes by default', () {
      expect(randomAsU8a().length, 32);
    });

    test('generates with the suuplied length', () {
      expect(randomAsU8a(66).length, 66);
    });
  });
  group('randomAsNumber', () {
    test('generates subsequent non-matching numbers', () {
      expect(randomAsNumber() != randomAsNumber(), true);
    });
  });

  group('randomAsHex', () {
    test('generated results does not match', () {
      expect(randomAsHex() != randomAsHex(), true);
    });

    test('is a valid hex number', () {
      expect(isHex(randomAsHex()), true);
    });

    test('generates 32 bytes by default', () {
      expect(randomAsHex().length, 32 * 2 + 2);
    });

    test('generates with the supplied length', () {
      expect(randomAsHex(66).length, 66 * 2 + 2);
    });
  });
}
