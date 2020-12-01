import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  stringReaderTest(); // rename this test name
}

void stringReaderTest() {
  group('string reader Test', () {
    // group global var // use for global setting for serial tests
    final reader = ScaleCodecReader.stringReader;
    var trueLoop = (List<String> testList, List<String> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Read String", () {
      var testList = ['0x3048656c6c6f20576f726c6421'];
      var testExpected = ["Hello World!"];
      trueLoop(testList, testExpected);
    });
  });
}
