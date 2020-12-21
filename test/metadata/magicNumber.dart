import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/MagicNumber.dart';
import 'package:polkadot_dart/types-known/index.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../testUtils/throws.dart';

void main() {
  magicNumberTest(); // rename this test name
}

void magicNumberTest() {
  group('MagicNumber', () {
    final registry = new TypeRegistry();

    test('succeeds when the magic number matches', () {
      expect(MagicNumber(registry, MAGIC_NUMBER).value, BigInt.from(MAGIC_NUMBER));
    });

    test('fails when the magic number mismatches', () {
      expect(() => MagicNumber(registry, 0x12345), throwsA(assertionThrowsContains("MagicNumber")));
    });
  });
}
