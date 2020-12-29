import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/ExtrinsicEra.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata;

import '../../testUtils/throws.dart';
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  extrinsicEraTest(); // rename this test name
}

void extrinsicEraTest() {
  group('ExtrinsicEra', () {
    final registry = new TypeRegistry();

    test('decodes an Extrinsic Era with immortal', () {
      final extrinsicEra = new GenericExtrinsicEra(registry, Uint8List.fromList([0]));

      expect(extrinsicEra.asImmortalEra is ImmortalEra, true);
      expect(extrinsicEra.toJSON(), {"ImmortalEra": '0x00'});
    });

    test('decodes an Extrinsic Era from u8 as mortal', () {
      final extrinsicEra = new GenericExtrinsicEra(registry, Uint8List.fromList([78, 156]));

      expect(extrinsicEra.asMortalEra.period.toNumber(), 32768);
      expect(extrinsicEra.asMortalEra.phase.toNumber(), 20000);
    });

    test('decoded from an existing GenericExtrinsicEra', () {
      final extrinsicEra = new GenericExtrinsicEra(
          registry, new GenericExtrinsicEra(registry, Uint8List.fromList([78, 156])));

      expect(extrinsicEra.asMortalEra.period.toNumber(), 32768);
      expect(extrinsicEra.asMortalEra.phase.toNumber(), 20000);
    });

    test('encode an Extrinsic Era from Object with blocknumber & period as mortal instance', () {
      final extrinsicEra = new GenericExtrinsicEra(registry, {"current": 1400, "period": 200});

      expect(extrinsicEra.asMortalEra.period.toNumber(), 256);
      expect(extrinsicEra.asMortalEra.phase.toNumber(), 120);
    });

    test('serializes and de-serializes from JSON', () {
      final extrinsicEra = new GenericExtrinsicEra(registry, Uint8List.fromList([78, 156]));
      final u8a = extrinsicEra.toU8a();
      final json = extrinsicEra.toJSON();

      expect(u8a, Uint8List.fromList([78, 156]));
      expect(json, {"MortalEra": '0x4e9c'});
      expect(new GenericExtrinsicEra(registry, json).toU8a(), u8a);
    });

    test('creates from an actual valid era', () {
      final currBlock = 2251519;
      final mortalEra = new GenericExtrinsicEra(registry, '0xc503').asMortalEra;

      expect(mortalEra.period.toNumber(), 64);
      expect(mortalEra.phase.toNumber(), 60);
      expect(mortalEra.birth(currBlock), 2251516);
      expect(mortalEra.death(currBlock), 2251580);
    });

    test('creates for an actual era (2)', () {
      final mortalEra = new GenericExtrinsicEra(registry, '0x8502').asMortalEra;

      expect(mortalEra.period.toNumber(), 64);
      expect(mortalEra.phase.toNumber(), 40);
    });

    test('creates form an actual era (3)', () {
      final mortalEra = new GenericExtrinsicEra(registry, '0x6502').asMortalEra;

      expect(mortalEra.period.toNumber(), 64);
      expect(mortalEra.phase.toNumber(), 38);
    });

    test('creates from an actual era, 100 block hash count', () {
      final mortalEra = new GenericExtrinsicEra(registry, '0xd607').asMortalEra;

      expect(mortalEra.period.toNumber(), 128);
      expect(mortalEra.phase.toNumber(), 125);
    });

    test('creates from a actual 2400 block hash count', () {
      final mortalEra = new GenericExtrinsicEra(registry, '0x9be3').asMortalEra;

      expect(mortalEra.period.toNumber(), 4096);
      expect(mortalEra.phase.toNumber(), 3641);
    });
  });
}
