import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/extrinsics/index.dart';
import 'package:polkadot_dart/types/extrinsic/impls.dart';
import 'package:polkadot_dart/types/extrinsic/v4/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicSignature.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata, Call;
import '../../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  extrinsicV4Test(); // rename this test name
}

void extrinsicV4Test() {
  final registry = new TypeRegistry();
  final metadata = new Metadata(registry, rpcMetadata.v12);
  registry.setMetadata(metadata);
  final tx = decorateExtrinsics(registry, metadata.asLatest, metadata.version);
  final keyring = createTestPairs(KeyringOptions(type: 'ed25519'), false);
  group('ExtrinsicV4', () {
    test('constructs a sane Uint8Array (default)', () {
      expect(
          new GenericExtrinsicV4(registry).toU8a(),
          new Uint8List.fromList([
            0, 0, // index
            0, 0, 0, 0 // fillBlock Perbill
          ]));
    });

    test('creates a unsigned extrinsic', () {
      final call =
          (tx["balances"]["transfer"]).callFunction([keyring["bob"].publicKey, BigInt.from(6969)]);

      expect(
          new GenericExtrinsicV4(registry, call).toHex(),
          '0x' +
              '0600' + // balance.transfer
              'ff' +
              'd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9' +
              'e56c');
    });

    test('creates a signed extrinsic', () {
      final call =
          (tx["balances"]["transfer"]).callFunction([keyring["bob"].publicKey, BigInt.from(6969)]);
      final kp = KeyringPairImpl(
          address: keyring["alice"].address,
          addressRaw: keyring["alice"].addressRaw,
          publicKey: keyring["alice"].publicKey,
          sign: keyring["alice"].sign);

      final signOptions = SignatureOptionsImpl.fromMap({
        "blockHash": '0xec7afaf1cca720ce88c1d1b689d81f0583cc15a97d621cf046dd9abf605ef22f',
        "genesisHash": '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
        "nonce": 1,
        "runtimeVersion": {
          "apis": [],
          "authoringVersion": BigInt.from(123),
          "implName": 'test',
          "implVersion": BigInt.from(123),
          "specName": 'test',
          "specVersion": BigInt.from(123),
          "transactionVersion": BigInt.from(123)
        },
        "tip": 2
      });

      /// https://github.com/polkadot-js/api/issues/2997 awaits confirm and clear

      // expect(
      //     new GenericExtrinsicV4(registry, call).sign(kp, signOptions).toHex(),
      //     '0x' +
      //         'ff' +
      //         'd172a74cda4c865912c32ba0a80a57ae69abae410e5ccb59dee84e2f4432db4f' +
      //         '00' + // ed25519
      //         'b8065808da3d11ddb4167afb156eafb51e8104ba792589bb443653a7fab82b90' +
      //         'c6530e838df06bfc8befcbbcfca7e219350cff865439b815b10b8e64ae1e9b01' +
      //         '000408' + // era. nonce, tip
      //         '0600' +
      //         'ff' +
      //         'd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9' +
      //         'e56c');
      expect(
          new GenericExtrinsicV4(registry, call).sign(kp, signOptions).toHex(),
          '0x' +
              'ff' +
              'd172a74cda4c865912c32ba0a80a57ae69abae410e5ccb59dee84e2f4432db4f' +
              '00' + // ed25519
              'aa683a020e4577c12bc2aa79ebedcc1c3030515f2eca92bb0302702d3b5f462e' +
              '4435dcd97d0c81e2fdc2d71aa5a3e4c78c5892dff6df05ba8a85bd0af6ad5e0c' +
              '000408' + // era. nonce, tip
              '0600' +
              'ff' +
              'd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9' +
              'e56c');
    });
  });
}
