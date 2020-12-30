import 'package:polkadot_dart/metadata/decorate/storage/createFunction.dart';
import 'package:polkadot_dart/metadata/decorate/storage/getStorage.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

Map<String, Map<String, StorageEntry>> decorateStorage(
    Registry registry, MetadataLatest metadataLatest, int metaVersion) {
  return metadataLatest.modules.value.fold({...getStorage(registry, metaVersion)},
      (result, moduleMetadata) {
    if (moduleMetadata.storage == null || moduleMetadata.storage.isNone) {
      return result;
    }

    final name = moduleMetadata.name;
    final section = stringCamelCase(name.toString());
    final unwrapped = moduleMetadata.storage.unwrap();
    final prefix = unwrapped.prefix.toString();

    // For access, we change the index names, i.e. System.Account -> system.account
    result[section] =
        unwrapped.items.value.fold(Map<String, StorageEntry>.from({}), (newModule, meta) {
      final method = meta.name.toString();

      newModule[stringLowerFirst(method)] = createFunction(
          registry,
          CreateItemFnImpl.fromMap(
              registry, {"meta": meta, "method": method, "prefix": prefix, "section": section}),
          CreateItemOptions.fromMap({"metaVersion": metaVersion}));

      return newModule;
    });

    return result;
  });
}
