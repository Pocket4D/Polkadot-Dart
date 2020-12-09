import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  btreeMapTest(); // rename this test name
}

void btreeMapTest() {
  final registry = TypeRegistry();
  final mockU32TextMap = Map<CodecText, u32>();
  //  mockU32TextMap.set(new Text(registry, 'bazzing'), new U32(registry, 69));
  mockU32TextMap.putIfAbsent(CodecText(registry, 'bazzing'), () => u32(registry, 69));

  group('BTreeMap', () {
    test('decodes null', () {
      expect(
          (BTreeMap.withParams(CodecText.constructor, u32.constructor))(registry, null).toString(),
          '{}');
    });

    test('decodes reusing instantiated inputs', () {
      final key = CodecText(registry, 'foo');
      final val = CodecText(registry, 'bar');
      expect(
          (BTreeMap.withParams(CodecText.constructor, CodecText.constructor))(
                  registry, Map<CodecText, CodecText>.from({key: val}))
              .eq(Map<CodecText, CodecText>.from({key: val})),
          true);
    });

    test('decodes within more complicated types', () {
      final s = Struct(registry, {"placeholder": u32.constructor, "value": 'u32'});

      s.put('value',
          (BTreeMap.withParams(CodecText.constructor, u32.constructor))(registry, mockU32TextMap));

      expect(s.toString(), '{"placeholder":0,"value":{"bazzing":69}}');
    });

    test('throws when it cannot decode', () {
      expect(() => (BTreeMap.withParams(CodecText.constructor, u32.constructor))(registry, 'ABC'),
          throwsA(contains("Map: cannot decode type")));
    });

    test('correctly encodes length', () {
      expect(
          (BTreeMap.withParams(CodecText.constructor, u32.constructor))(registry, mockU32TextMap)
              .encodedLength,
          13);
    });

    test('generates sane toRawTypes', () {
      // var rt = BTreeMap.withParams(CodecText.constructor, u32.constructor)(registry).toRawType();

      expect((BTreeMap.withParams(CodecText.constructor, u32.constructor))(registry).toRawType(),
          'BTreeMap<Text,u32>');
      expect(
          (BTreeMap.withParams(CodecText.constructor, CodecText.constructor))(registry).toRawType(),
          'BTreeMap<Text,Text>');
      expect(
          (BTreeMap.withParams(CodecText.constructor,
                  Struct.withParams({'a': u32.constructor, 'b': CodecText.constructor})))(registry)
              .toRawType(),
          'BTreeMap<Text,{"a":"u32","b":"Text"}>');
    });
  });
}
