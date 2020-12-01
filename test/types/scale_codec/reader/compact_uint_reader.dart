import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/scale_codec/reader/compact_uint_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  compactUIntReaderTest(); // rename this test name
}

void compactUIntReaderTest() {
  group('CompactUIntReaderTest', () {
    var reader = CompactUIntReader(); // use for global setting for serial tests
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Reads single byte int", () {
      final testList = ["0x00", "0x04", "0xa8", "0xfc"];
      final testExpected = [0, 1, 42, 63];
      trueLoop(testList, testExpected);
    });
    test("Reads two byte int", () {
      final testList = ["0x0101", "0x1501", "0xfdff"];
      final testExpected = [64, 69, 16383];
      trueLoop(testList, testExpected);
    });
    test("Reads four byte int", () {
      final testList = ["0x02000100", "0xfeffffff"];
      final testExpected = [
        16384,
        0x3fffffff,
      ];
      trueLoop(testList, testExpected);
    });
  });
}
