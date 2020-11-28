import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/codec/reader/int32_reader.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  int32ReaderTest(); // rename this test name
}

void int32ReaderTest() {
  group('int32ReaderTest', () {
    // group global var // use for global setting for serial tests
    final reader = Int32Reader();
    var trueLoop = (List<String> testList, List<int> testExpected) {
      for (var i = 0; i < testList.length; i += 1) {
        var codec = ScaleCodecReader((testList[i]).toU8a());
        expect(codec.hasNext(), true);
        var result = codec.read(reader);
        expect(result, testExpected[i]);
        expect(codec.hasNext(), false);
      }
    };
    test("Read positive", () {
      var testList = [
        '0x00000000',
        '0x01000000',
        '0x01020304',
        '0xff000000',
        '0xffff0000',
        '0xffffff00',
        '0xffffff7f'
      ];
      var testExpected = [0, 0x01, 0x04030201, 0xff, 0xffff, 0xffffff, 2147483647];
      trueLoop(testList, testExpected);
    });
    test("Read negative", () {
      var testList = [
        '0xffffffff',
        '0x9cffffff',
        '0x0100ffff',
        '0xfefeffff',
        '0xfdfdfeff',
        '0x00000080',
      ];
      var testExpected = [-1, -100, -0xffff, -0x0102, -0x010203, -2147483648];
      trueLoop(testList, testExpected);
    });
  });
}
