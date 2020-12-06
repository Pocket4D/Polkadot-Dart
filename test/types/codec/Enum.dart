import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../../testUtils/throws.dart';

void main() {
  enumTest(); // rename this test name
}

void enumTest() {
  final registry = TypeRegistry();
  group('typed enum (previously EnumType)', () {
    test('provides a clean toString() (value)', () {
      expect(
          Enum(registry, {"Text": CodecText.constructor, "U32": u32.constructor},
              Uint8List.fromList([0, 2 << 2, 49, 50])).value.toString(),
          '12');
    });

    test('provides a clean toString() (enum)', () {
      var result = Enum(registry, {"Text": CodecText.constructor, "U32": u32.constructor},
          Uint8List.fromList([1, 2 << 2, 49, 50])).toString();
      expect(result, '{"U32":3289352}');
    });

    test('decodes from a JSON input (lowercase)', () {
      expect(
          Enum(registry, {"Text": CodecText.constructor, "U32": u32.constructor},
              {"text": 'some text value'}).value.toString(),
          'some text value');
    });

    test('decodes reusing instanciated inputs', () {
      final foo = CodecText(registry, 'bar');

      expect(Enum(registry, {"foo": CodecText.constructor}, {"foo": foo}).value, foo);

      expect(Enum(registry, {"foo": CodecText.constructor}, foo, 0).value, foo);

      expect(
          Enum(registry, {foo: CodecText.constructor},
              Enum(registry, {"foo": CodecText.constructor}, {"foo": foo})).value,
          foo);
    });

    test('decodes from hex', () {
      expect(
          Enum(registry, {"Text": CodecText.constructor, "U32": u32.constructor}, '0x0134120000')
              .value
              .toString(),
          '4660'); // 0x1234 in decimal
    });

    // test('decodes from hex (string types)', () {
    //   expect(
    //       Enum(
    //               registry,
    //               // eslint-disable-next-line sort-keys
    //               {"foo": 'Text', "bar": 'u32'},
    //               '0x0134120000')
    //           .value
    //           .toString(),
    //       '4660'); // 0x1234 in decimal
    // });

    test('decodes from a JSON input (mixed case)', () {
      expect(
          Enum(registry, {"Text": CodecText.constructor, 'u32': u32.constructor}, {"U32": 42})
              .value
              .toString(),
          '42');
    });

    test('decodes from JSON string', () {
      expect(Enum(registry, {"Null": CodecNull.constructor, "U32": u32.constructor}, 'null').type,
          'Null');
    });

    test('has correct isXyz/asXyz (Enum.withParams)', () {
      final test = (Enum.withParams({
        "First": CodecText.constructor,
        "Second": u32.constructor,
        "Third": u32.constructor
      }))(registry, {"Second": 42});
      expect(test.isKey("First"), false);
      expect(test.isKey("Second"), true);
      expect((test.askey("Second") as u32).toNumber(), 42);
      expect(() => test.askey("Third"),
          throwsA(assertionThrowsContains("Cannot convert 'Second' via asThird")));
    });

    test('stringifies with custom types', () {
      expect(Test(registry).toJSON(), {"a": null});
    });

    test('creates via with', () {
      final Test2 = enumWith({"A": A.constructor, "D": D.constructor, "C": C.constructor});

      expect(Test2(registry).toJSON(), {"A": null});
      expect(Test2(registry, 1234, 1).toJSON(), {"D": 1234});
      expect(Test2(registry, 0x1234, 1).toU8a(), Uint8List.fromList([1, 0x34, 0x12, 0x00, 0x00]));
      expect(Test2(registry, 0x1234, 1).toU8a(true), Uint8List.fromList([0x34, 0x12, 0x00, 0x00]));
    });

    test('allows accessing the type and value', () {
      final text = CodecText(registry, 'foo');
      final enumType =
          Enum(registry, {"Text": CodecText.constructor, "U32": u32.constructor}, {"Text": text});

      expect(enumType.type, 'Text');
      expect(enumType.value, text);
    });
  });
  group('utils', () {
    final DEF = {"num": u32.constructor, "str": CodecText.constructor};
    final u8a = Uint8List.fromList([1, 3 << 2, 88, 89, 90]);
    final toTest = Enum(registry, DEF, u8a);

    test('compares against index', () {
      expect(toTest.eq(1), true);
    });

    test('compares against u8a', () {
      expect(toTest.eq(u8a), true);
    });

    test('compares against hex', () {
      expect(toTest.eq(u8aToHex(u8a)), true);
    });

    test('compares against another enum', () {
      expect(toTest.eq(Enum(registry, DEF, u8a)), true);
    });

    test('compares against another object', () {
      expect(toTest.eq({"str": 'XYZ'}), true);
    });

    test('compares against values', () {
      expect(toTest.eq('XYZ'), true);
    });

    test('compares basic enum on string', () {
      expect(Enum(registry, ['A', 'B', 'C'], 1).eq('B'), true);
    });
  });
  group('string-only construction (old Enum)', () {
    testDecode(String type, dynamic input, dynamic expected) {
      test("can decode from $type", () {
        final e = Enum(registry, ['foo', 'bar'], input);

        expect(e.toString(), expected);
      });
    }

    testEncode(String to, dynamic expected) {
      test("can encode $to", () {
        // : 'toJSON' | 'toNumber' | 'toString' | 'toU8a'
        final s = Enum(registry, ['Foo', 'Bar'], 1);
        switch (to) {
          case 'toNumber':
            expect(s.toNumber(), expected);
            break;
          case 'toHex':
            expect(s.toHex(), expected);
            break;
          case 'toJSON':
            expect(s.toJSON(), expected);
            break;
          case 'toU8a':
            expect(s.toU8a(), expected);
            break;
          default:
            break;
        }
      });
    }

    testDecode('Enum', null, 'foo');
    testDecode('Enum', Enum(registry, ['foo', 'bar'], 1), 'bar');
    testDecode('number', 0, 'foo');
    testDecode('number', 1, 'bar');
    testDecode('string', 'bar', 'bar');
    testDecode('Uint8Array', Uint8List.fromList([0]), 'foo');
    testDecode('Uint8Array', Uint8List.fromList([1]), 'bar');

    testEncode('toJSON', 'Bar');
    testEncode('toNumber', 1);
    testEncode('toString', 'Bar');
    testEncode('toU8a', Uint8List.fromList([1]));

    test('provides a clean toString()', () {
      expect(Enum(registry, ['foo', 'bar']).toString(), 'foo');
    });

    test('provides a clean toString() (enum)', () {
      expect(Enum(registry, ['foo', 'bar'], Enum(registry, ['foo', 'bar'], 1)).toNumber(), 1);
    });

    test('converts to and from Uint8Array', () {
      expect(
          Enum(registry, ['foo', 'bar'], Uint8List.fromList([1])).toU8a(), Uint8List.fromList([1]));
    });

    test('converts from JSON', () {
      expect(Enum(registry, ['foo', 'bar', 'baz', 'gaz', 'jaz'], 4).toNumber(), 4);
    });

    test('has correct isXyz getters (Enum.with)', () {
      final test = (Enum.withParams(['First', 'Second', 'Third']))(registry, 'Second');

      expect(test.isKey("Second"), true);
    });
  });
  group('utils', () {
    test('compares against the index value', () {
      expect(Enum(registry, ['foo', 'bar'], 1).eq(1), true);
    });

    test('compares against the index value (false)', () {
      expect(Enum(registry, ['foo', 'bar'], 1).eq(0), false);
    });

    test('compares against the string value', () {
      expect(Enum(registry, ['foo', 'bar'], 1).eq('bar'), true);
    });

    test('compares against the string value (false)', () {
      expect(Enum(registry, ['foo', 'bar'], 1).eq('foo'), false);
    });

    test('has isNone set, with correct index (i.e. no values are used)', () {
      final test = Enum(registry, ['foo', 'bar'], 1);

      expect(test.isNone, true);
      expect(test.index, 1);
    });
  });
  group('index construction', () {
    test('creates enum where index is specified', () {
      final Test = enumWith({"A": u32.constructor, "B": u32.constructor});
      final test = Test(registry, u32(registry, 123), 1);

      expect(test.type, 'B');
      expect((test.value as u32).toNumber(), 123);
    });

    test('creates enum when value is an enum', () {
      final Test = enumWith({A: u32.constructor, B: u32.constructor});
      final test = Test(registry, Test(registry, 123, 1));

      expect(test.type, 'B');
      expect((test.value as u32).toNumber(), 123);
    });

    test('creates via enum with nested enums as the value', () {
      final Nest = enumWith({C: u32.constructor, D: u32.constructor});
      final Test = enumWith({A: u32.constructor, B: Nest.call});
      final test = Test(registry, Nest(registry, 123, 1), 1);

      expect(test.type, 'B');
      expect((test.value as Enum).type, 'D');
      expect(((test.value as Enum).value as u32).toNumber(), 123);
    });
  });
}

class A extends CodecNull {
  A(Registry registry) : super(registry);
  static A constructor(Registry registry, [dynamic val]) {
    return A(registry);
  }
}

class B extends CodecNull {
  B(Registry registry) : super(registry);
  static B constructor(Registry registry, [dynamic val]) {
    return B(registry);
  }
}

class D extends u32 {
  D(Registry registry, [dynamic value]) : super(registry, value);
  static D constructor(Registry registry, [dynamic value]) {
    return D(registry, value);
  }
}

class C extends CodecNull {
  C(Registry registry) : super(registry);
  static C constructor(Registry registry, [dynamic val]) {
    return C(registry);
  }
}

class Test extends Enum {
  Test(Registry registry, [String value, int index])
      : super(registry, {"a": A.constructor, "b": B.constructor, "c": C.constructor}, value, index);
  static Test constructor(Registry registry, [dynamic value, int index]) =>
      Test(registry, value, index);
}
