import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/polkadot_dart.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  unionReaderTest(); // rename this test name
}

void unionReaderTest() {
  group('union reader Test', () {
    // group global var // use for global setting for serial tests
    final reader = UnionReader<dynamic>([UByteReader(), BoolReader()]);

    test("Read Int", () {
      var codec = ScaleCodecReader("0x002a".toU8a());
      expect(codec.hasNext(), true);
      var act = codec.read(reader);
      expect(act.index, 0);
      expect(act.value is int, true);
      expect(act.value, 42);
      expect(codec.hasNext(), false);
    });
    test("Read Bool", () {
      var codec = ScaleCodecReader("0x0101".toU8a());
      expect(codec.hasNext(), true);
      var act = codec.read(reader);
      expect(act.index, 1);
      expect(act.value is bool, true);
      expect(act.value, true);
      expect(codec.hasNext(), false);
    });
    test("Read Bool", () {
      var codec = ScaleCodecReader("0x032a".toU8a());
      expect(codec.hasNext(), true);
      expect(() => codec.read(reader), throwsA(contains("Unknown type index")));
    });
    test("Read Optional enum", () {
      var codec = ScaleCodecReader("0x01002a".toU8a());
      expect(codec.hasNext(), true);
      var act = codec.readOptional(reader);
      act.ifPresent((val) {
        expect(val.value, 42);
        expect(val.index, 0);
      });
      expect(codec.hasNext(), false);
    });
  });
}
