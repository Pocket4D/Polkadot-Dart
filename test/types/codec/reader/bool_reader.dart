import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';

import 'package:p4d_rust_binding/utils/utils.dart';
import 'package:p4d_rust_binding/types/codec/reader/bool_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';

void main() {
  boolReaderTest();
}

void boolReaderTest() {
  group('boolReaderTest', () {
    var reader = BoolReader();
    test("Reads true bool", () {
      var codec = ScaleCodecReader('0x01'.toU8a());
      var act = codec.read(reader);
      expect(act, true);
      expect(codec.hasNext(), false);
    });
    test("Reads false bool", () {
      var codec = ScaleCodecReader('0x00'.toU8a());
      var act = codec.read(reader);
      expect(act, false);
      expect(codec.hasNext(), false);
    });
    test("Errors if no input", () {
      var codec = ScaleCodecReader('0x'.toU8a());
      expect(() => codec.read(reader), throwsA(contains("Cannot read")));
      expect(codec.hasNext(), false);
    });
    test("Errors if invalid value", () {
      var codec = ScaleCodecReader('0x02'.toU8a());
      expect(() => codec.read(reader), throwsA(contains("Not a boolean value:")));
      expect(codec.hasNext(), false);
    });
    test("Reads bool through codec optional method", () {
      final testList = ["0x00", "0x01", "0x02"];
      final testExpected = [Optional<bool>.empty(), Optional.of(false), Optional.of(true)];
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        var result = codec.readOptional(reader);
        expect(result.value, testExpected[i]);
      }
    });
  });
}
