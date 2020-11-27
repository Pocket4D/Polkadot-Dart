import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/types/codec/reader/era_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  eraReaderTest(); // rename this test name
}

void eraReaderTest() {
  group('eraReader Test', () {
    // group global var // use for global setting for serial tests
    final reader = EraReader();
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Reads immortal era", () {
      var testList = ['0x00'];
      var testExpected = [0];
      trueLoop(testList, testExpected);
    });
    test("Reads mortal era", () {
      var testList = ['0xe500'];
      var testExpected = [229];
      trueLoop(testList, testExpected);
    });
    test("Reads all cases", () {
      var testList = [
        '0x00',
        '0x0400',
        '0x3200',
        '0x3502',
        '0xdb00',
        '0xe500',
        '0xeb00',
        '0xf501',
        '0xfb00'
      ];
      var testExpected = [0, 4, 50, 565, 219, 229, 235, 501, 251];
      trueLoop(testList, testExpected);
    });
    test("Errors if no input", () {
      var codec = ScaleCodecReader(("0x").toU8a());
      expect(() => codec.read(reader), throwsA(contains("Cannot read 0 of")));
    });
  });
}
