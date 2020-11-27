import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  uint32ReaderTest(); // rename this test name
}

void uint32ReaderTest() {
  group('uint32 reader Test', () {
    // group global var // use for global setting for serial tests
    final reader = ScaleCodecReader.uInt32Reader;
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Reads", () {
      var testList = ['0xffffff00'];
      var testExpected = [16777215];
      trueLoop(testList, testExpected);
    });
    test("Error for short", () {
      var codec = ScaleCodecReader("0xff".toU8a());
      expect(() => codec.read(reader), throwsA(contains("Cannot read 1 of")));
    });
    test("Reads optional existing", () {
      var codec = ScaleCodecReader("0x01ffffff00".toU8a());
      expect(codec.hasNext(), true);
      expect(codec.readOptional(reader), Optional.of(16777215));
      expect(codec.hasNext(), false);
    });
    test("Reads optional none", () {
      var codec = ScaleCodecReader("0x00".toU8a());
      expect(codec.hasNext(), true);
      expect(codec.readOptional(reader), Optional.empty());
      expect(codec.hasNext(), false);
    });
    test("Read all cases", () {
      var testList = [
        '0x00000000',
        '0x000000ff',
        '0x0000ff00',
        '0x00ff0000',
        '0xff000000',
        '0x0f0f0f0f',
        '0xf0f0f0f0',
        '0xffffff00',
        '0x00060000',
        '0x00030000',
        '0x7d010000',
      ];
      var testExpected = [
        0x00000000,
        0xff000000,
        0x00ff0000,
        0x0000ff00,
        0x000000ff,
        0x0f0f0f0f,
        0xf0f0f0f0,
        0x00ffffff,
        0x00000600,
        0x00000300,
        0x0000017d
      ];
      trueLoop(testList, testExpected);
    });
  });
}
