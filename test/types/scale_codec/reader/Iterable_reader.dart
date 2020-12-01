import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/scale_codec/reader/iterable_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  iterableReaderTest(); // rename this test name
}

enum TestEnum { ZERO, ONE, TWO, THREE }
void iterableReaderTest() {
  group('iterableReaderTest', () {
    // use for global setting for serial tests
    final reader = IterableReader(TestEnum.values);

    void trueLoop<T>(ScaleCodecReader codec, List<T> testExpected) {
      for (var i = 0; i < testExpected.length; i += 1) {
        var result = Function.apply(codec.read, [reader]);
        expect(result, testExpected[i]);
        if (i != testExpected.length - 1) {
          expect(codec.hasNext(), true);
        } else {
          expect(codec.hasNext(), false);
        }
      }
    }

    test("Reads single byte int", () {
      var codec = ScaleCodecReader("0x0001020302".toU8a());
      final testExpected = [
        TestEnum.ZERO,
        TestEnum.ONE,
        TestEnum.TWO,
        TestEnum.THREE,
        TestEnum.TWO
      ];
      trueLoop<TestEnum>(codec, testExpected);
    });
    test("Reads two byte int", () {
      var codec = ScaleCodecReader("04".toU8a());
      var rdr = IterableReader(TestEnum.values);

      expect(() => codec.read(rdr),
          throwsA(contains('Unknown enum value:'))); // normal throws eg: throw "";
    });
    test("Cannot create without enums list", () {
      try {
        IterableReader(null);
      } catch (e) {
        expect(e, contains("List of iterable is null"));
      }
    });
    test("Cannot create without enums list", () {
      try {
        IterableReader([]);
      } catch (e) {
        expect(e, contains("List of iterable is empty"));
      }
    });
  });
}
