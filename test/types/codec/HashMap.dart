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
      print("⚠️: TODO ");
      // var result1 =
      //     (HashMap.withParams(CodecText.constructor, u32.constructor)(registry)).toRawType();

      // expect(result1, 'HashMap<Text,u32>');
      // expect((HashMap.withParams(Text, Text))(registry).toRawType()),'HashMap<Text,Text>');
      // expect( (HashMap.withParams(Text, Struct.with({ a: U32, b: Text })))(registry).toRawType())
      //   ,'HashMap<Text,{"a":"u32","b":"Text"}>');
    });
  });
}
