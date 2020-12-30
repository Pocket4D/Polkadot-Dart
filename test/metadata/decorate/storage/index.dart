import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';

import 'package:polkadot_dart/metadata/decorate/storage/index.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;
import 'package:polkadot_dart/utils/utils.dart';
import '../../../metadata/v12/v12.dart' as rpcMetadata;
import '../../../testUtils/throws.dart';

void main() {
  getStorageTest(); // rename this test name
}

void getStorageTest() {
  final keyring = createTestPairs(KeyringOptions(type: 'ed25519'));

  group('decorateStorage', () {
    group('latest', () {
      final registry = new TypeRegistry();
      final metadata = new Metadata(registry, rpcMetadata.v12);

      registry.setMetadata(metadata);

      final query = decorateStorage(registry, metadata.asLatest, metadata.version);

      test('should throw if the storage function expects an argument', () {
        expect(() => query["balances"]["account"].call(),
            throwsA(assertionThrowsContains("requires one argument")));
      });

      test('should return a value if the storage function does not expect an argument', () {
        expect(() => query["timestamp"]["now"].call(), returnsNormally);
      });

      test('should return the correct length-prefixed storage key', () {
        expect(u8aToHex(query["system"]["account"].call(keyring["alice"].address)),
            '0x410126aa394eea5630e07c48ae0c9558cef7b99d880ec681799c0cf30e8886371da9de1e86a9a8c739864cf3cc5ec2bea59fd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');
      });
    });
  });
}
