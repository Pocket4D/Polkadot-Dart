import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;

// import '../testUtils.dart';
import './v9.dart' as substrateData;

void main() {
  metadataV9(); // rename this test name
}

void metadataV9() {
  final file = new File('test/metadata/v9/static.json');
  Map<String, dynamic> substrateJson;
  final registry = new TypeRegistry();
  Metadata metadata;
  setUp(() async {
    substrateJson = Map<String, dynamic>.from(jsonDecode(await file.readAsString()));
    metadata = Metadata(registry, substrateData.v9);
    registry.setMetadata(metadata);
  });
  group('MetadataV9 (substrate)', () {
    test('decodes latest substrate properly', () async {
      // final filename = 'test/metadata/v9/gen.json';
      // new File(filename).writeAsString(jsonEncode(metadata.toJSON())).then((File file) {
      //   // Do something with the file.
      // });
      // try {
      //  expect(metadata.version, version);
      // expect(jsonEncode(metadata.toJSON()), jsonEncode(substrateJson));

      //   // expect((metadata["asV${version}" as keyof Metadata] as unknown as MetadataInterface<Modules>).modules.length).not.toBe(0);
      expect(metadata.toJSON(), substrateJson);
      // } catch (error) {
      //   // print(jsonEncode(metadata.toJSON()));
      //   throw error;
      // }
    });
    test("converts v9 to latest", () async {
      ExtractionMetadata metadataInit = metadata.asV9;

      final metadataLatest = metadata.asLatest;

      expect(getUniqTypes(registry, metadataInit, false),
          getUniqTypes(registry, metadataLatest, false));
    });

    test('storage with default values', () async {
      metadata.asLatest.modules.value
          .where((module) => module.storage != null && module.storage.isSome)
          .forEach((mod) {
        mod.storage.unwrap().items.value.forEach((storage) {
          final storageReWrap = StorageEntryMetadataLatest.from(storage);
          final inner = unwrapStorageType(StorageEntryTypeLatest.from(storageReWrap.type));
          final location = "${mod.name.toString()}.${storageReWrap.name.toString()}: $inner";
          expect(() {
            try {
              registry.createType(inner, storageReWrap.fallback.toString());
            } catch (error) {
              final message = "$location::with::${storageReWrap.fallback}:: $error";

              if (true) {
                throw message;
              }
            }
          }, returnsNormally);
        });
      });
    });
  });
}
