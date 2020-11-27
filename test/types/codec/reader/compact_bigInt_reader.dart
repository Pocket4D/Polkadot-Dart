import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/types/codec/reader/compact_bigInt_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  compactBigIntReaderTest(); // rename this test name
}

void compactBigIntReaderTest() {
  group('compactBigIntReaderTest', () {
    var reader = CompactBigIntReader(); // use for global setting for serial tests
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i].toBn());
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
    test("Reads four byte bigint", () {
      final testList = [
        "0x0300000040",
        "0x0370605040",
        "0x03000000ff",
        "0x030000ffff",
        "0x03ffffffff"
      ];
      final testExpected = [0x40000000, 0x40506070, 0xff000000, 0xffff0000, 0xffffffff];
      // trueLoop(testList, testExpected);
      trueLoop(testList, testExpected);
    });
    test("Reads bigint", () {
      final testList = [
        "0x0700ffffffff",
        "0x07ffffffffff",
        "0x33aabbccddeeff00112233445566778899",
      ];
      final testExpected = ['0xffffffff00', '0xffffffffff', '0x99887766554433221100ffeeddccbbaa'];
      // trueLoop(testList, testExpected);
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i].hexToBn());
        expect(codec.hasNext(), false);
      }
    });
  });
}
