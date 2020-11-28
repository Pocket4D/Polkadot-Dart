import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/types/codec/reader/bool_optional_reader.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';

void main() {
  boolOptionalReaderTest();
}

void boolOptionalReaderTest() {
  group('boolOptionalReader', () {
    var reader = BoolOptionalReader();
    test("Reads existing true bool", () {
      var codec = ScaleCodecReader('0x02'.toU8a());
      var act = codec.read(reader);
      act.ifPresent((val) {
        expect(val, true);
      });
    });
    test("Reads existing false bool", () {
      var codec = ScaleCodecReader('0x01'.toU8a());
      var act = codec.read(reader);
      act.ifPresent((val) {
        expect(val, false);
      });
    });
    test("Reads no bool", () {
      var codec = ScaleCodecReader('0x00'.toU8a());
      var act = codec.read(reader);
      expect(act.isEmpty, true);
    });
    test("Errors if no input", () {
      var codec = ScaleCodecReader('0x'.toU8a());
      expect(() => codec.read(reader), throwsA(contains("Cannot read 0 of")));
    });
    test("Errors if invalid value", () {
      var codec = ScaleCodecReader('0x03'.toU8a());
      expect(() => codec.read(reader), throwsA(contains("Not a boolean option: ")));
    });
    test("Reads bool through codec optional method", () {
      final testList = ["0x00", "0x01", "0x02"];
      final testExpected = [
        Optional<bool>.empty(),
        Optional<bool>.of(false),
        Optional<bool>.of(true)
      ];
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        var result = codec.readOptional(reader);
        expect(result.value, testExpected[i]);
      }
    });
  });
}
