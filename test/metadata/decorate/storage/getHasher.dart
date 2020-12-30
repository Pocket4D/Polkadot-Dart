import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/metadata/decorate/storage/getHasher.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  getHasherTest(); // rename this test name
}

void getHasherTest() {
  group('getHasher', () {
    final registry = new TypeRegistry();

    group('Twox64Concat', () {
      test('matches the foo test from Rust', () {
        final hasher =
            getHasher(StorageHasher.from(registry.createType('StorageHasher', 'Twox64Concat')));
        final hash = hasher('foo');
        final xxhash = xxhashAsU8a('foo', bitLength: 128);

        expect([hash.sublist(0, 8), hash.sublist(8)], [xxhash.sublist(0, 8), stringToU8a('foo')]);
      });
    });
  });
}
