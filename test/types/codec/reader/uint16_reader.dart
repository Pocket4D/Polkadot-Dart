import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  uint16ReaderTest(); // rename this test name
}

void uint16ReaderTest() {
  group('uint16 reader test', () {
    // group global var // use for global setting for serial tests
    final reader = ScaleCodecReader.uInt16Reader;
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Read String", () {
      var testList = ['0x2a00'];
      var testExpected = [42];
      trueLoop(testList, testExpected);
    });
    test("Error for short", () {
      var codec = ScaleCodecReader("0xff".toU8a());
      expect(() => codec.read(reader), throwsA(contains("Cannot read 1 of")));
    });
    test("Reads optional existing", () {
      var codec = ScaleCodecReader("0x012a00".toU8a());
      expect(codec.hasNext(), true);
      expect(codec.readOptional(reader), Optional.of(42));
      expect(codec.hasNext(), false);
    });
    test("Reads optional none", () {
      var codec = ScaleCodecReader("0x00".toU8a());
      expect(codec.hasNext(), true);
      expect(codec.readOptional(reader), Optional.empty());
      expect(codec.hasNext(), false);
    });
    test("Read all cases", () {
      var testList = ['0x0000', '0x00ff', '0xff00', '0xffff', '0xf0f0', '0x0f0f', '0xf00f'];
      var testExpected = [0x0000, 0xff00, 0x00ff, 0xffff, 0xf0f0, 0x0f0f, 0x0ff0];
      trueLoop(testList, testExpected);
    });
  });
}
