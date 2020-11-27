import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/types/codec/reader/list_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  listReaderTest(); // rename this test name
}

void listReaderTest() {
  group('list reader Test', () {
    // group global var // use for global setting for serial tests
    final reader = ListReader(ScaleCodecReader.uInt16Reader);
    var trueLoop = (List<String> testList, List<List<int>> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Reads list of 16-bit ints", () {
      var testList = ['0x18040008000f00100017002a00'];
      var testExpected = [
        [4, 8, 15, 16, 23, 42]
      ];
      trueLoop(testList, testExpected);
    });
  });
}
