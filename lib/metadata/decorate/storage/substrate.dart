import 'package:polkadot_dart/metadata/decorate/storage/createFunction.dart';
import 'package:polkadot_dart/types/types.dart';

StorageEntry Function(Registry registry, int metaVersion) createRuntimeFunction(
    String method, String key,
    {String documentation, String type}) {
  return (Registry registry, int metaVersion) {
    return createFunction(
        registry,
        CreateItemFnImpl.fromMap(registry, {
          "meta": {
            "documentation": registry.createType('Vec<Text>', [
              [documentation]
            ]),
            "modifier": registry.createType('StorageEntryModifierLatest', 1), // required
            "toJSON": () => key,
            "type": registry.createType('StorageEntryTypeLatest', [type, 0])
          },
          "method": method,
          "prefix": 'Substrate',
          "section": 'substrate'
        }),
        CreateItemOptions.fromMap({"key": key, "metaVersion": metaVersion, "skipHashing": true}));
  };
}

final code = createRuntimeFunction('code', ':code',
    documentation: 'Wasm code of the runtime.', type: 'Bytes');

final heapPages = createRuntimeFunction('heapPages', ':heappages',
    documentation: 'Number of wasm linear memory pages required for execution of the runtime.',
    type: 'u64');

final extrinsicIndex = createRuntimeFunction('extrinsicIndex', ':extrinsic_index',
    documentation: 'Current extrinsic index (u32) is stored under this key.', type: 'u32');

final changesTrieConfig = createRuntimeFunction('changesTrieConfig', ':changes_trie',
    documentation: 'Changes trie configuration is stored under this key.', type: 'u32');

final childStorageKeyPrefix = createRuntimeFunction('childStorageKeyPrefix', ':child_storage:',
    documentation: 'Prefix of child storage keys.', type: 'u32');
