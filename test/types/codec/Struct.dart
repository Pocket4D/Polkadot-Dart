import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  structTest(); // rename this test name
}

void structTest() {
  final registry = TypeRegistry();
  group('decoding', () {
    testDecode(String type, dynamic input) {
      test("can decode from $type", () {
        final s =
            new Struct(registry, {"foo": CodecText.constructor, "bar": u32.constructor}, input);

        expect([...s.value.keys], ['foo', 'bar']);
        expect([...s.value.values].map((v) => v.toString()), ['bazzing', '69']);
      });
    }

    testDecode('array', ['bazzing', 69]);
    testDecode('hex', '0x1c62617a7a696e6745000000');
    testDecode('object', {"foo": 'bazzing', "bar": 69});
    testDecode(
        'Uint8Array', Uint8List.fromList([28, 98, 97, 122, 122, 105, 110, 103, 69, 0, 0, 0]));
  });
  group('encoding', () {
    testEncode(String to, dynamic expected) {
      test("can encode $to", () {
        final s = new Struct(registry, {"foo": CodecText.constructor, "bar": u32.constructor},
            {"foo": 'bazzing', "bar": 69});

        switch (to) {
          case 'toHex':
            expect(s.toHex(), expected);
            break;
          case 'toJSON':
            expect(s.toJSON(), expected);
            break;
          case 'toString':
            expect(s.toString(), expected);
            break;
          case 'toU8a':
            expect(s.toU8a(), expected);
            break;
          default:
            break;
        }
      });
    }

    testEncode('toHex', '0x1c62617a7a696e6745000000');
    testEncode('toJSON', {"foo": 'bazzing', "bar": 69});
    testEncode('toU8a', Uint8List.fromList([28, 98, 97, 122, 122, 105, 110, 103, 69, 0, 0, 0]));
    testEncode('toString', '{"foo":"bazzing","bar":69}');
  });
  test('decodes null', () {
    expect(
        (Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor}))(registry, null)
            .toString(),
        '{}');
  });

  test('decodes reusing instantiated inputs', () {
    final foo = new CodecText(registry, 'bar');
    expect(
        (new Struct(registry, {"foo": CodecText.constructor}, {"foo": foo})).getCodec('foo'), foo);
  });

  // test('decodes a more complicated type', () {
  //   final s = new Struct(registry, {
  //     "foo": Vec.withParams(Struct.withParams({"bar": CodecText.constructor}))
  //   }, {
  //     "foo": [
  //       {"bar": 1},
  //       {"bar": 2}
  //     ]
  //   });

  //   expect(s.toString(), '{"foo":[{"bar":"1"},{"bar":"2"}]}');
  // });

  test('decodes from a Map input', () {
    final input = new Struct(
        registry, {"a": u32.constructor, "txt": CodecText.constructor}, {"a": 42, "txt": 'fubar'});
    final s = new Struct(registry,
        {"txt": CodecText.constructor, "foo": u32.constructor, "bar": u32.constructor}, input);

    expect(s.toString(), '{"txt":"fubar","foo":0,"bar":0}');
  });

  test('decodes from a snake_case input', () {
    final input = new Struct(registry, {
      "snakeCaseA": u32.constructor,
      "snakeCaseB": CodecText.constructor,
      "other": u32.constructor
    }, {
      "snake_case_a": 42,
      "snake_case_b": 'fubar',
      "other": 69
    });

    expect(input.toString(), '{"snakeCaseA":42,"snakeCaseB":"fubar","other":69}');
  });

  test('throws when it cannot decode', () {
    expect(
        () => (Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor}))(
            registry, 'ABC'),
        throwsA(contains("Cannot decode value")));
  });

  test('provides a clean toString()', () {
    expect(
        Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor})(
            registry, {"txt": 'foo', "u32": 0x123456}).toString(),
        '{"txt":"foo","u32":1193046}');
  });

  // test('provides a clean toString() (string types)', () {
  //   expect(
  //       Struct.withParams({"txt": 'Text', "num": 'u32', "cls": u32.constructor})(
  //           registry, {"txt": 'foo', num: 0x123456, "cls": 123}).toString(),
  //       '{"txt":"foo","num":1193046,"cls":123}');
  // });

  test('exposes the properties on the object', () {
    final struct = (Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor})(
        registry, {"txt": 'foo', "u32": 0x123456}));
    // print(struct.getKey("txt"));
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access,@typescript-eslint/no-unsafe-call
    // expect((struct).txt.toString(),'foo');
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access,@typescript-eslint/no-unsafe-call
    // expect((struct).u32.toNumber(),0x123456);
  });

  test('correctly encodes length', () {
    expect(
        (Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor}))(
            registry, {"foo": 'bazzing', "bar": 69}).encodedLength,
        5);
  });

  test('exposes the types', () {
    expect(
        new Struct(
            registry,
            {"foo": CodecText.constructor, "bar": CodecText.constructor, "baz": u32.constructor},
            {"foo": 'foo', "bar": 'bar', "baz": 3}).Type,
        {"foo": 'Text', "bar": 'Text', "baz": 'u32'});
  });

  test('gets the value at a particular index', () {
    expect(
        (Struct.withParams({"txt": CodecText.constructor, "u32": u32.constructor}))(
            registry, {"txt": 'foo', "u32": 1234}).getAtIndex(1).toString(),
        '1234');
  });

  group('utils', () {
    test('compares against other objects', () {
      const test = {"foo": 'foo', "bar": 'bar', "baz": 3};
      var structData = Struct(
          registry,
          {"foo": CodecText.constructor, "bar": CodecText.constructor, "baz": u32.constructor},
          test);
      var structData2 = Struct.withParams(
              {"foo": CodecText.constructor, "bar": CodecText.constructor, "baz": u32.constructor})(
          registry, test);
      expect(structData.eq(test), true);
      expect(structData.eq(structData2), true);
    });
  });

  // test('allows toString with large numbers', () {
  //   // replicate https://github.com/polkadot-js/api/issues/640
  //   expect(
  //     new Struct(registry, {
  //       "blockNumber": registry.createClass('Option<BlockNumber>')
  //     }, { "blockNumber": '0x0000000010abcdef' }).toString()
  //   ,'{"blockNumber":279694831}');
  // });

  // test('generates sane toRawType', () {
  //   expect(
  //     new Struct(registry, {
  //       "accountId": 'AccountId',
  //       "balanceCompact": registry.createClass('Compact<Balance>'),
  //       "blockNumber": registry.createClass('BlockNumber'),
  //       "compactNumber": registry.createClass('Compact<BlockNumber>'),
  //       "optionNumber": registry.createClass('Option<BlockNumber>'),
  //       "counter": u32.constructor,
  //       "vector": Vec.withParams('AccountId')
  //     }).toRawType()
  //   ,jsonEncode({
  //     "accountId": 'AccountId',
  //     "balanceCompact": 'Compact<Balance>', // Override in Uint
  //     "blockNumber": 'BlockNumber',
  //     "compactNumber": 'Compact<BlockNumber>',
  //     "optionNumber": 'Option<BlockNumber>',
  //     "counter": 'u32',
  //     "vector": 'Vec<AccountId>'
  //   }));
  // });

  // test('generates sane toRawType (via with)', () {
  //   final typeFunc = Struct.withParams({
  //     "accountId": 'AccountId',
  //     "balance": registry.createClass('Balance')
  //   });

  //   expect(
  //      typeFunc(registry).toRawType()
  //   ,jsonEncode({
  //     "accountId": 'AccountId',
  //     "balance": 'Balance' // Override in Uint
  //   }));
  // });

  // group('toU8a', () {
  //   const def = {"foo": 'Bytes', "method": 'Bytes', "bar": 'Option<u32>', "baz": 'bool'};
  //   const val = {"foo": '0x4269', "method": '0x99', "bar": 1, "baz": true};

  //   test('generates toU8a with undefined', () {
  //     expect(new Struct(registry, def, val).toU8a(),
  //         new Uint8List.fromList([2 << 2, 0x42, 0x69, 1 << 2, 0x99, 1, 1, 0, 0, 0, 1]));
  //   });

  //   test('generates toU8a with true', () {
  //     expect(new Struct(registry, def, val).toU8a(true),
  //         new Uint8List.fromList([0x42, 0x69, 0x99, 1, 0, 0, 0, 1]));
  //   });

  //   test('generates toU8a with { method: true }', () {
  //     expect(new Struct(registry, def, val).toU8a({"method": true}),
  //         new Uint8List.fromList([2 << 2, 0x42, 0x69, 0x99, 1, 1, 0, 0, 0, 1]));
  //   });
  // });
}
