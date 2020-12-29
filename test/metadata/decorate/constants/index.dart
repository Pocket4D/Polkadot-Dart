import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/constants/index.dart';
import 'package:polkadot_dart/metadata/decorate/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;

import '../../v12/v12.dart' as rpcMetadata;
import '../../v10/v10.dart' as rpcMetadataV10;

void main() {
  metadataTest(); // rename this test name
}

void metadataTest() {
  init(String meta) {
    final registry = new TypeRegistry();
    final metadata = new Metadata(registry, meta);

    registry.setMetadata(metadata);

    return [decorateConstants(registry, metadata.asLatest), registry];
  }

  group('fromMetadata', () {
    test('should return constants with the correct type and value', () {
      final initResult = init(rpcMetadata.v12);

      final consts = initResult.first as Map<String, Map<String, ConstantCodec>>;
      final blockNumber = BlockNumber.from(consts["democracy"]["cooloffPeriod"].value);
      expect(blockNumber.toRawType(), 'BlockNumber');
      // 3 second blocks, 28 days
      expect(blockNumber.toInt(), 28 * 24 * 60 * (60 / 3));
    });

    // removed from session
    test('correctly handles bytes (V10)', () {
      final initResult = init(rpcMetadataV10.v10);
      final consts = initResult.first as Map<String, Map<String, ConstantCodec>>;
      // 0x34 removes as the length prefix removed
      expect(consts["session"]["dedupKeyPrefix"].value.toHex(), '0x3a73657373696f6e3a6b657973');
    });
  });
}
