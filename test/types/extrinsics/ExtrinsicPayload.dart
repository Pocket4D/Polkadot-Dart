import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/ExtrinsicPayload.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata;
import 'package:polkadot_dart/utils/utils.dart';
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  extrinsicPayloadTest(); // rename this test name
}

void extrinsicPayloadTest() {
  final registry = new TypeRegistry();

  final TEST = {
    "address": '5DTestUPts3kjeXSTMyerHihn1uwMfLj8vU8sqF7qYrFabHE',
    "blockHash": '0xde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7',
    "era": '0x0703',
    "genesisHash": '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
    "method": '0x0600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c',
    "nonce": '0x00001234',
    "specVersion": 123,
    "tip": '0x00000000000000000000000000005678'
  };
  group('ExtrinsicPayload', () {
    test('creates and can re-create from itself (U8a)', () {
      final a = new GenericExtrinsicPayload(registry, TEST, ExtrinsicPayloadOptions(version: 4));
      final b =
          new GenericExtrinsicPayload(registry, a.toU8a(), ExtrinsicPayloadOptions(version: 4));

      expect(a.raw.toJSON(), b.raw.toJSON());
    });

    test('creates and can re-create from itself (hex)', () {
      final a = new GenericExtrinsicPayload(registry, TEST, ExtrinsicPayloadOptions(version: 4));
      final b =
          new GenericExtrinsicPayload(registry, a.toHex(), ExtrinsicPayloadOptions(version: 4));

      expect(a.raw.toJSON(), b.raw.toJSON());
    });

    test('handles toU8a(true) correctly', () {
      expect(
          u8aToHex(new GenericExtrinsicPayload(registry, TEST, ExtrinsicPayloadOptions(version: 4))
              .toU8a(true)),
          // no method length prefix
          '0x0600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c0703d148e25901007b000000dcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025bde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7');
    });

    test('handles toU8a(false) correctly', () {
      expect(
          u8aToHex(new GenericExtrinsicPayload(registry, TEST, ExtrinsicPayloadOptions(version: 4))
              .toU8a()),
          // with method length prefix
          '0x940600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c0703d148e25901007b000000dcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025bde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7');
    });
  });
}
