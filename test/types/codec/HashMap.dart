import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  hashMapTest(); // rename this test name
}

void hashMapTest() {
  final registry = TypeRegistry();
  group('HashMap', () {
    test('generates sane toRawTypes', () {
      var result1 =
          (HashMap.withParams(CodecText.constructor, u32.constructor)(registry)).toRawType();

      expect(result1, 'HashMap<Text,u32>');
      expect(
          (HashMap.withParams(CodecText.constructor, CodecText.constructor))(registry).toRawType(),
          'HashMap<Text,Text>');
      expect(
          (HashMap.withParams(CodecText.constructor,
                  Struct.withParams({"a": u32.constructor, "b": CodecText.constructor})))(registry)
              .toRawType(),
          'HashMap<Text,{"a":"u32","b":"Text"}>');
    });
  });
}
