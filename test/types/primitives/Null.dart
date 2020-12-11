import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Null.dart';

import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  nullTest(); // rename this test name
}

void nullTest() {
  group('Null', () {
    final registry = new TypeRegistry();

    test('compares against null', () {
      expect(CodecNull(registry).eq(null), true);
    });

    test('compares against Null', () {
      expect(CodecNull(registry).eq(CodecNull(registry)), true);
    });

    test('compares against other (failed)', () {
      // expect(CodecNull(registry).eq(), false);
    });

    test('has no hash', () {
      expect(() => CodecNull(registry).hash, throwsA(contains('')));
    });

    test('isEmpty', () {
      expect(CodecNull(registry).isEmpty, true);
    });

    test('has an empty hex', () {
      expect(CodecNull(registry).toHex(), '0x');
    });

    test('has a Null type', () {
      expect(CodecNull(registry).toRawType(), 'Null');
    });
  });
}
