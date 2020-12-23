import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
import 'package:polkadot_dart/types/types.dart' hide Call, Metadata;

/** @internal */
void decodeLatestSubstrate<Modules extends BaseCodec>(
    Registry registry, int version, String rpcData, Map<String, dynamic> staticSubstrate) {
  test('decodes latest substrate properly', () {
    final metadata = Metadata(registry, rpcData);

    registry.setMetadata(metadata);

    try {
      expect(metadata.version, version);
      // expect((metadata["asV${version}" as keyof Metadata] as unknown as MetadataInterface<Modules>).modules.length).not.toBe(0);
      expect(metadata.toJSON(), staticSubstrate);
    } catch (error) {
      print(jsonEncode(metadata.toJSON()));

      throw error;
    }
  });
}

/** @internal */
void toLatest<Modules extends Codec>(Registry registry, int version, String rpcData,
    [bool withThrow = true]) {
  test("converts v$version to latest", () {
    final metadata = new Metadata(registry, rpcData);

    registry.setMetadata(metadata);
    ExtractionMetadata metadataInit;
    switch (version) {
      case 9:
        metadataInit = metadata.asV9;
        break;
      case 10:
        metadataInit = metadata.asV10;
        break;
      case 11:
        metadataInit = metadata.asV11;
        break;
      case 12:
        metadataInit = metadata.asV12;
        break;
    }

    final metadataLatest = metadata.asLatest;

    expect(getUniqTypes(registry, metadataInit, withThrow),
        getUniqTypes(registry, metadataLatest, withThrow));
  });
}

/** @internal */
void defaultValues(Registry registry, String rpcData, [bool withThrow = true]) {
  group('storage with default values', () {
    final metadata = new Metadata(registry, rpcData);

    metadata.asLatest.modules.value.where((module) => module.storage.isSome).forEach((mod) {
      mod.storage.unwrap().items.value.forEach((storage) {
        final inner = unwrapStorageType(storage.type);
        final location = "${mod.name.toString()}.${storage.name.toString()}: $inner";

        test("creates default types for $location", () {
          expect(() {
            try {
              registry.createType(inner, storage.fallback);
            } catch (error) {
              final message = "$location:: $error";

              if (withThrow) {
                throw message;
              } else {
                print(message);
              }
            }
          }, returnsNormally);
        });
      });
    });
  });
}
