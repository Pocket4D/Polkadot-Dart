import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  vecFixedTest(); // rename this test name
}

void vecFixedTest() {
  final registry = TypeRegistry();
  group('construction', () {
    test('constructs via empty', () {
      expect(VecFixed(registry, CodecText.constructor, 2).toHex(), '0x0000');
    });

    test('constructs via Uint8Array', () {
      expect(
          VecFixed(registry, CodecText.constructor, 2, Uint8List.fromList([0x00, 0x04, 0x31]))
              .toHex(),
          '0x000431');
    });

    test('decodes reusing instance inputs', () {
      final foo = CodecText(registry, 'bar');

      expect((VecFixed(registry, CodecText.constructor, 1, [foo])).value[0], foo);
    });
  });

  group('utils', () {
    final toTest =
        VecFixed.withParams(CodecText.constructor, 5)(registry, ['1', '2', '3', null, '5']);
    test('has a sane string types', () {
      expect(toTest.toRawType(), '[Text;5]');
      expect(toTest.type, 'Text');
    });

    test('has a correct toHex', () {
      // each entry length 1 << 2, char as hex (0x31 === `1`), one empty
      expect(toTest.toHex(), '0x043104320433000435');
    });

    test('has empty Uint8Array when length is 0', () {
      final toTest = (VecFixed.withParams(CodecText.constructor, 0))(registry);

      expect(toTest.encodedLength, 0);
      expect(toTest.toU8a(), Uint8List.fromList([]));
    });

    test('has equivalent to 1 Uint8Array when length is 1', () {
      final toTest = (VecFixed.withParams(CodecText.constructor, 1))(registry, ['hello']);

      expect(toTest.encodedLength, 1 + 5);
      expect(toTest.toU8a(), Uint8List.fromList([20, 104, 101, 108, 108, 111]));
    });
  });
}
