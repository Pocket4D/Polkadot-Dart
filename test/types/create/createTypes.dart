import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/codec/Set.dart';
import 'package:polkadot_dart/types/create/createClass.dart';
import 'package:polkadot_dart/types/create/createTypes.dart';
import 'package:polkadot_dart/types/create/registry.dart';

// import 'package:polkadot_dart/types/interfaces/offchain/definitions.info.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  createTypeTest(); // rename this test name
}

void createTypeTest() {
  group('createType', () {
    final registry = new TypeRegistry();

    test('allows creation of a H256 (with proper toRawType)', () {
      final h256 = registry.createType('H256');
      expect(h256.runtimeType.toString(), "U8aFixed");
      expect(h256.toRawType(), 'H256');
      expect(registry.createType('Hash').toRawType(), 'H256');
    });

    test('allows creation of a Fixed64 (with proper toRawType & instance)', () {
      final f64 = registry.createType<CodecInt>('Fixed64');
      expect(f64.toRawType(), 'Fixed64');
      expect(f64.bitLength, 64);
      expect(f64.isUnsigned, false);
      expect(f64 is CodecInt, true);
    });

    test('allows creation of a Struct', () {
      final raw = '{"balance":"Balance","index":"u32"}';
      final struct = createTypeUnsafe(registry, raw, [
        {"balance": 1234, "index": '0x10'}
      ]);

      expect(struct.toJSON(), {"balance": 1234, "index": 16});
      expect(struct.toRawType(), raw);
    });

    test('allows creation of a BTreeMap', () {
      expect(
          createTypeUnsafe(registry, 'BTreeMap<Text,u32>', ['0x041c62617a7a696e6745000000'])
              .toString(),
          '{"bazzing":69}');
    });

    test('allows creation of a BTreeSet', () {
      expect(
          createTypeUnsafe(registry, 'BTreeSet<u32>', ['0x1002000000180000001e00000050000000'])
              .toString(),
          '[2,24,30,80]');
    });

    test('allows creation of a Enum (simple)', () {
      final result = createTypeUnsafe(registry, '{"_enum": ["A", "B", "C"]}', [1]);
      expect(result.toJSON(), 'B');
    });

    test('allows creation of a Enum (parametrised)', () {
      expect(
          createTypeUnsafe(registry, '{"_enum": {"A": null, "B": "u32", "C": null} }', [1])
              .toJSON(),
          {"B": 0});
    });

    test('allows creation of a Result', () {
      expect(createTypeUnsafe(registry, 'Result<u32,Text>', ['0x011064656667']).toJSON(),
          {"Error": 'defg'});
    });

    test('allows creation of a Set', () {
      expect(
          createTypeUnsafe(
              registry,
              '{"_set": { "A": 1, "B": 2, "C": 4, "D": 8, "E": 16, "G": 32, "H": 64, "I": 128 } }',
              [1 + 4 + 16 + 64]).cast<CodecSet>().strings,
          ['A', 'C', 'E', 'H']);
    });

    test('allows creation of a Tuple', () {
      expect(
          createTypeUnsafe(registry, '(Balance,u32)', [
            [1234, 5678]
          ]).toJSON(),
          [1234, 5678]);
    });

    test('allows creation for a UInt<bitLength>', () {
      expect(createTypeUnsafe(registry, 'UInt<2048>').toRawType(), 'u2048');
    });

    test('fails creation for a UInt<bitLength> where bitLength is not power of 8', () {
      expect(
          () => createTypeUnsafe(registry, 'UInt<20>').toRawType(),
          throwsA(assertionThrowsContains(
              'UInt<20>: Only support for UInt<bitLength>, where length <= 8192 and a power of 8')));
    });

    test('fails on creation of DoNotConstruct', () {
      // ignore: non_constant_identifier_names
      final Clazz = createClass(registry, 'DoNotConstruct<UnknownSomething>');
      expect(() => Clazz(registry), throwsA(contains('Cannot construct unknown type')));
    });

    test('allows creation of a [u8; 8]', () {
      expect(
          createTypeUnsafe(registry, '[u8; 8]', [
            [0x12, 0x00, 0x23, 0x00, 0x45, 0x00, 0x67, 0x00]
          ]).toHex(),
          '0x1200230045006700');
    });

    test('allows creation of a [u16; 4]', () {
      // print(createTypeUnsafe(registry, '[u16; 4]', [
      //   [0x1200, 0x2300, 0x4500, 0x6700]
      // ]));
      expect(
          createTypeUnsafe(registry, '[u16; 4]', [
            [0x1200, 0x2300, 0x4500, 0x6700]
          ]).toU8a(),
          Uint8List.fromList([0x00, 0x12, 0x00, 0x23, 0x00, 0x45, 0x00, 0x67]));
    });

    group('instanceof', () {
      test('instanceof should work (primitive type)', () {
        final value = registry.createType('Balance', 1234);
        final balance = registry.createClass('Balance')(registry);

        expect(value.toRawType() == balance.toRawType(), true);
      });

      test('instanceof should work (srml type)', () {
        final value = registry.createType('Gas', 1234);
        // ignore: non_constant_identifier_names
        final Gas = registry.createClass('Gas')(registry);

        expect(value.toRawType() == Gas.toRawType(), true);
      });

      test('instanceof should work (complex type)', () {
        registry.register({
          "TestComplex": {
            "balance": 'Balance',
            // eslint-disable-next-line sort-keys
            "accountId": 'AccountId',
            "log": '(u64, u32)',
            // eslint-disable-next-line sort-keys
            "fromSrml": 'Gas'
          }
        });

        final value = createTypeUnsafe(registry, 'TestComplex', [
          {
            "accountId": '0x1234567812345678123456781234567812345678123456781234567812345678',
            "balance": 123,
            "fromSrml": 0,
            "log": [456, 789]
          }
        ]);

        expect(
            value.toRawType() == createClass(registry, 'TestComplex')(registry).toRawType(), true);
      });

      test('allows for re-registration of a type', () {
        final balDef = registry.createType('Balance');
        final bb = Balance.from(balDef);
        expect(bb.toRawType(), 'Balance');
        expect(bb.bitLength, 128);

        registry.register({"Balance": 'u32'});

        final balu32 = registry.createType('Balance');
        final bb32 = Balance.from(balu32);
        expect(bb32.toRawType(), "u32");
        expect(bb32.bitLength, 32);
      });

      test('allows for re-registration of a type (affecting derives)', () {
        registry.register({
          "Balance": 'u128',
          "TestComplex": {
            "balance": 'Balance',
            // eslint-disable-next-line sort-keys
            "accountId": 'AccountId',
            "log": '(u64, u32)',
            // eslint-disable-next-line sort-keys
            "fromSrml": 'Gas'
          }
        });

        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        final cmpDef = createTypeUnsafe(registry, 'TestComplex').cast<Struct>();
        expect(cmpDef.getCodec("balance").cast<u128>().bitLength, 128);

        registry.register({"Balance": 'u32'});

        // // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        final cmpu32 = createTypeUnsafe(registry, 'TestComplex').cast<Struct>();

        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access,@typescript-eslint/no-unsafe-call
        expect(cmpu32.getCodec("balance").cast<u32>().bitLength, 32);

        var sk = registry.createType("StorageKind");
        print((sk as Enum).originDef);
        // print((sk as Enum).type);
        // print((sk as Enum).iskeys);
        var sk4 = registry.createClass("StorageKind")(registry, {"Local": "123"});

        print(sk4);

        var kkk = registry.createType("NetworkState");
        // print(((kkk as Struct).getCodec("connectedPeers") as CodecMap).valClass);
      });
    });
  });
}
