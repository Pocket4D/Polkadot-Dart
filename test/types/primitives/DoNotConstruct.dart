import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  doNotConstructTest(); // rename this test name
}

void doNotConstructTest() {
  group('DoNotConstruct', () {
    final registry = TypeRegistry();

    test('does not allow construction', () {
      expect(() => (DoNotConstruct.withParams())(registry),
          throwsA(contains("Cannot construct unknown type")));
    });

    test('does not allow construction (with Name)', () {
      expect(() => (DoNotConstruct.withParams('Something'))(registry),
          throwsA(contains("Cannot construct unknown type")));
    });
  });
}
