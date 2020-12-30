import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/create/createTypes.dart';
import 'package:polkadot_dart/types/generic/AccountIndex.dart';
import 'package:polkadot_dart/types/generic/Call.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/primitives/Text.dart';
import 'package:polkadot_dart/types/primitives/U32.dart';
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  callTest(); // rename this test name
}

void callTest() {
  final registry = new TypeRegistry();
  var metadata;

  group('Call', () {
    setUp(() async {
      metadata = new Metadata(registry, rpcMetadata.v12);
      registry.setMetadata(metadata);
    });
    test('handles decoding correctly (bare)', () async {
      expect(
          GenericCall(registry, {
            "args": [],
            "callIndex": [6, 1] // balances.setBalance
          }).toU8a(),
          Uint8List.fromList([6, 1, 0, 0, 0]));
    });

    test('handles creation from a hex value properly', () async {
      expect(GenericCall(registry, '0x0601').toU8a(),
          Uint8List.fromList([6, 1, 0, 0, 0])); // balances.setBalance
    });
  });
  group('hasOrigin', () {
    const toTest = {
      "args": [],
      "callIndex": [2, 2] // timestamp
    };

    test('is false with no arguments', () async {
      var meta = FunctionMetadataLatest.create(registry, {"args": []});
      expect(GenericCall(registry, toTest, meta).hasOrigin, false);
    });

    test('is false with first argument as non-Origin', () async {
      var meta = FunctionMetadataLatest.create(registry, {
        "args": [
          {"name": "a", "type": "u32"}
        ]
      });
      expect(GenericCall(registry, toTest, meta).hasOrigin, false);
    });

    test('is false with first argument as non-Origin', () async {
      var meta = FunctionMetadataLatest.create(registry, {
        "args": [
          {"name": "a", "type": "Origin"}
        ]
      });
      var result = GenericCall(registry, toTest, meta);
      expect(result.hasOrigin, true);
    });
  });
}
