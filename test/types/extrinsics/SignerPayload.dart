import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/extrinsics/index.dart';
import 'package:polkadot_dart/types/extrinsic/SignerPayload.dart';
import 'package:polkadot_dart/types/extrinsic/impls.dart';
import 'package:polkadot_dart/types/extrinsic/v4/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicSignature.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata, Call;
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  signerPayloadTest(); // rename this test name
}

void signerPayloadTest() {
  final registry = new TypeRegistry();
  final metadata = new Metadata(registry, rpcMetadata.v12);
  registry.setMetadata(metadata);

  group('GenericSignerPayload', () {
    const TEST = {
      "address": '5DTestUPts3kjeXSTMyerHihn1uwMfLj8vU8sqF7qYrFabHE',
      "blockHash": '0xde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7',
      "blockNumber": '0x00231d30',
      "era": '0x0703',
      "genesisHash": '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
      "method": '0x0600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c',
      "nonce": '0x00001234',
      "signedExtensions": ['CheckNonce', 'CheckWeight'],
      "specVersion": '0x00000006',
      "tip": '0x00000000000000000000000000005678',
      "transactionVersion": '0x00000007',
      "version": 4
    };

    test('creates a valid JSON output', () {
      expect(
          new GenericSignerPayload(registry, {
            "address": '5DTestUPts3kjeXSTMyerHihn1uwMfLj8vU8sqF7qYrFabHE',
            "blockHash": '0xde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7',
            "blockNumber": '0x231d30',
            "era": registry.createType('ExtrinsicEra', {"current": 2301232, "period": 200}),
            "genesisHash": '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
            "method": registry.createType('Call',
                '0x0600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c'),
            "nonce": 0x1234,
            "signedExtensions": ['CheckNonce'],
            "tip": 0x5678,
            "version": 4,
            "runtimeVersion": registry.createType("RuntimeVersion")
          }).toPayload().toMap(),
          {
            "address": '5DTestUPts3kjeXSTMyerHihn1uwMfLj8vU8sqF7qYrFabHE',
            "blockHash": '0xde8f69eeb5e065e18c6950ff708d7e551f68dc9bf59a07c52367c0280f805ec7',
            "blockNumber": '0x00231d30',
            "era": '0x0703',
            "genesisHash": '0xdcd1346701ca8396496e52aa2785b1748deb6db09551b72159dcb3e08991025b',
            "method":
                '0x0600ffd7568e5f0a7eda67a82691ff379ac4bba4f9c9b859fe779b5d46363b61ad2db9e56c',
            "nonce": '0x00001234',
            "signedExtensions": ['CheckNonce'],
            "specVersion": '0x00000000',
            "tip": '0x00000000000000000000000000005678',
            "transactionVersion": '0x00000000',
            "version": 4
          });
    });

    // test('re-constructs from JSON', () {
    //   expect(
    //     new GenericSignerPayload(registry, {
    //       ...TEST,
    //       "runtimeVersion": { "specVersion": 0x06, "transactionVersion": 0x07 }
    //     }).toPayload()
    //   ,TEST);
    // });

    // test('re-constructs from itself', () {
    //   expect(
    //     new GenericSignerPayload(
    //       registry,
    //       new GenericSignerPayload(registry, {
    //         ...TEST,
    //         "runtimeVersion": { "specVersion": 0x06, "transactionVersion": 0x07 }
    //       })
    //     ).toPayload()
    //   ,TEST);
    // });

    // test('can be used as a feed to ExtrinsicPayload', () {
    //   final signer = new GenericSignerPayload(registry, TEST).toPayload();
    //   final payload = registry.createType('ExtrinsicPayload', [signer, { "version": signer.version }]);

    //   expect(payload.era.toHex(),TEST.era);
    //   expect(payload.method.toHex(),TEST.method);
    //   expect(payload.blockHash.toHex(),TEST.blockHash);
    //   expect(payload.nonce.eq(TEST.nonce),true);
    //   expect(payload.tip.eq(TEST.tip),true);
    // });
  });
}
