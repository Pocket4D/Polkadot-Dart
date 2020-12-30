import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/metadata/Metadata.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;

import './v12/v12.dart' as substrateData;

void main() {
  metadataTest(); // rename this test name
}

void metadataTest() {
  group('Metadata', () {
    test('allows creation from hex with JSON equivalence', () {
      final testData = new Metadata(new TypeRegistry(), substrateData.v12);
      // expect(new Metadata(new TypeRegistry(), testData.toHex()).toJSON()).toEqual(test.toJSON());
      expect(new Metadata(new TypeRegistry(), testData.toHex()).toJSON(), testData.toJSON());
    });
  });
}
