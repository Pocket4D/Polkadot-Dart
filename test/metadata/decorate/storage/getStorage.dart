import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/metadata/decorate/storage/getStorage.dart';

import 'package:polkadot_dart/types/types.dart';

void main() {
  getStorageTest(); // rename this test name
}

void getStorageTest() {
  group('getSorage', () {
    final registry = new TypeRegistry();
    final storage = getStorage(registry, 8);

    test('should return well known keys', () {
      // expect(typeof storage.substrate,'object');
      expect(storage["substrate"] is Map<String, StorageEntry>, true);
      expect(storage["substrate"]["changesTrieConfig"] != null, true);
      expect(storage["substrate"]["childStorageKeyPrefix"] != null, true);
      expect(storage["substrate"]["code"] != null, true);
      expect(storage["substrate"]["extrinsicIndex"] != null, true);
      expect(storage["substrate"]["heapPages"] != null, true);
    });
  });
}
