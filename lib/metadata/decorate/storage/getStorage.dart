import 'package:polkadot_dart/metadata/decorate/storage/substrate.dart';
import 'package:polkadot_dart/types/types.dart' hide Storage;

final substrate = {
  "code": code,
  "heapPages": heapPages,
  "extrinsicIndex": extrinsicIndex,
  "changesTrieConfig": changesTrieConfig,
  "childStorageKeyPrefix": childStorageKeyPrefix
};

Map<String, Map<String, StorageEntry>> getStorage(Registry registry, int metaVersion) {
  return {
    "substrate": substrate.entries.fold(Map<String, StorageEntry>.from({}), (storage, entry) {
      (storage)[entry.key] = entry.value(registry, metaVersion);
      return storage;
    })
  };
}
