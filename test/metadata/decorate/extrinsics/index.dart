import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';

import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/extrinsics/index.dart';
import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/impls.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;

import '../../../testUtils/throws.dart';
import '../../v12/v12.dart' as rpcMetadata;

void main() {
  metadataTest(); // rename this test name
}

void metadataTest() {
  final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
  final registry = new TypeRegistry();
  final metadata = new Metadata(registry, rpcMetadata.v12);

  registry.setMetadata(metadata);

  final tx = decorateExtrinsics(registry, metadata.asLatest, metadata.version);

  group('extrinsics', () {
    test('encodes an actual transfer (actual data)', () {
      // print(extrinsics);
      final call = (tx["balances"]["transfer"]).callFunction([keyring["bob"].publicKey, 6969]);
      // final extrinsic = registry.createType('Extrinsic', call) as GenericExtrinsic;

      final extrinsic = GenericExtrinsic(registry, call);
      expect(
          extrinsic
              .sign(
                  KeyringPairImpl.fromKeyPair(keyring["alice"]),
                  SignatureOptionsImpl.fromMap({
                    "blockHash":
                        '0xec7afaf1cca720ce88c1d1b689d81f0583cc15a97d621cf046dd9abf605ef22f',
                    "genesisHash":
                        '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
                    "nonce": 0,
                    "runtimeVersion": {
                      "apis": [],
                      "authoringVersion": BigInt.from(123),
                      "implName": 'test',
                      "implVersion": BigInt.from(123),
                      "specName": 'test',
                      "specVersion": BigInt.from(123),
                      "transactionVersion": BigInt.from(123)
                    }
                  }))
              .toHex(),
          '0x' +
              '2d02' + // length
              '84' + // signed flag
              'ffd172a74cda4c865912c32ba0a80a57ae69abae410e5ccb59dee84e2f4432db4f' + // who
              '00' + // ed25519
              '4634f7b973084f983ef48e2afbd72a990f7d4dd9d86c39e645cb34d9a45466b6' + // sig1
              '263f0f2020363a6475f91e323a8b1bd43dedd97e78ec3c5d5b5197466305400e' + // sig2
              '000000' + // nonce, era, tip
              '0600' + // balances.transfer
              'ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9' + // to
              'e56c' // value
          );
    });
  });

  group('fromMetadata', () {
    test('should throw if an incorrect number of args is supplied', () {
      expect(() => tx["balances"]["setBalance"].callFunction([]),
          throwsA(assertionThrowsContains("expects 3 arguments")));
    });

    test('should return a value if the storage function does not expect an argument', () {
      expect(
          () => tx["balances"]["setBalance"]
              .callFunction(['5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF', 2, 3]),
          returnsNormally);
    });

    test('should return properly-encoded transactions', () {
      expect(
          registry
              .createType(
                  'Extrinsic',
                  tx["timestamp"]["set"].callFunction([
                    [10101]
                  ]))
              .toU8a(),
          new Uint8List.fromList([
            // length (encoded)
            4 << 2,
            // version, no signature
            4,
            // index
            3, 0,
            // values, Compact<Moment>
            116
          ]));
    });
    test('has working .is', () {
      final theTx = tx["balances"]["setBalance"]
          .callFunction(['5C62W7ELLAAfix9LYrcx5smtcffbhvThkM5x7xfMeYXCtGwF', 2, 3]);
      expect(tx["balances"]["setBalance"].isCall(theTx), true);
      expect(tx["balances"]["transfer"].isCall(theTx), false);
    });
  });
}
