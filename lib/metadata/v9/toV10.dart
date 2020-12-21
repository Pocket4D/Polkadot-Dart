// migrate a storage hasher type
// see https://github.com/paritytech/substrate/pull/4462
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';

/** @internal */
StorageHasherV10 createStorageHasher(Registry registry, StorageHasherV9 hasher) {
  // Blake2_128_Concat has been added at index 2, so we increment all the
  // indexes greater than 2
  if (hasher.toNumber() >= 2) {
    return StorageHasherV10.from(registry.createType('StorageHasherV10', hasher.toNumber() + 1));
  }

  return StorageHasherV10.from(registry.createType('StorageHasherV10', hasher));
}

/** @internal */
List<dynamic> createStorageType(Registry registry, StorageEntryTypeV9 entryType) {
  if (entryType.isMap) {
    return [
      {...entryType.asMap.value, "hasher": createStorageHasher(registry, entryType.asMap.hasher)},
      1
    ];
  }

  if (entryType.isDoubleMap) {
    return [
      {
        ...entryType.asDoubleMap.value,
        "hasher": createStorageHasher(registry, entryType.asDoubleMap.hasher),
        "key2Hasher": createStorageHasher(registry, entryType.asDoubleMap.key2Hasher)
      },
      2
    ];
  }

  return [entryType.asPlain, 0];
}

// /** @internal */
ModuleMetadataV10 convertModule(Registry registry, ModuleMetadataV9 mod) {
  final storage = mod.storage.unwrapOr(null);

  return ModuleMetadataV10.from(registry.createType('ModuleMetadataV10', {
    ...mod.value,
    "storage": storage != null
        ? {
            ...(storage as StorageMetadataV9).value,
            "items": (storage as StorageMetadataV9)
                .items
                .map((StorageEntryMetadataV9 item, [index, list]) {
              var result = createStorageType(registry, item.type);
              var type10 =
                  StorageEntryTypeV10.from(registry.createType('StorageEntryTypeV10', result));
              return {...item.value, "type": type10};
            })
          }
        : null
  }));
}

// /** @internal */
MetadataV10 toV10(Registry registry, MetadataV9 metadataV9) {
  return MetadataV10.from(registry.createType('MetadataV10',
      {"modules": metadataV9.modules.map((mod, [index, list]) => convertModule(registry, mod))}));
}
