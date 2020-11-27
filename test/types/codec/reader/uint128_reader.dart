import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/types/codec/reader/uint128_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  uint128ReaderTest(); // rename this test name
}

void uint128ReaderTest() {
  group('uin128 reader Test', () {
    // group global var // use for global setting for serial tests
    final reader = UInt128Reader();
    var trueLoop = (List<String> testList, List<String> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result.toString(), testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Reads", () {
      var testList = ['0xf70af5f6f3c843050000000000000000'];
      var testExpected = ["379367743775116023"];
      trueLoop(testList, testExpected);
    });
    test("Reads", () {
      var testList = ['0x0000c52ebca2b1000000000000000000'];
      var testExpected = ["50000000000000000"];
      trueLoop(testList, testExpected);
    });
    test("Reads", () {
      var codec = ScaleCodecReader('0xf70af5f6f3c84305000000000000'.toU8a());
      expect(() => codec.read(reader), throwsA(isRangeError)); // normal throws eg: throw "";
    });
  });
}
