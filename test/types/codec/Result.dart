import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  rawTest(); // rename this test name
}

void rawTest() {
  group('Result', () {
    final registry = TypeRegistry();
    final Type = Result.withParams({"Error": CodecText.constructor, "Ok": u32.constructor});

    test('has a sane toRawType representation', () {
      expect(Type(registry).toRawType(), 'Result<u32,Text>');
    });

    test('decodes from a u8a (success)', () {
      final result = Type(registry, Uint8List.fromList([0, 1, 2, 3, 4]));

      expect(result.isOk, true);
      expect(result.asOk.toU8a(), Uint8List.fromList([1, 2, 3, 4]));
      expect(result.toHex(), '0x0001020304');
      expect(result.toJSON(), {"Ok": 0x04030201});
    });

    test('decodes from a u8a (error)', () {
      final result = Type(registry, Uint8List.fromList([1, 4 << 2, 100, 101, 102, 103]));

      expect(result.isError, true);
      expect(result.asError.toU8a(), Uint8List.fromList([4 << 2, 100, 101, 102, 103]));
      expect(result.toHex(), '0x011064656667');
      expect(result.toJSON(), {"Error": hexToString('0x64656667')});
    });

    test('decodes from a JSON representation', () {
      final result = Type(registry, {"Error": 'error'});

      expect(result.toHex(), '0x01146572726f72');
    });

    test('decodes reusing instanciated inputs', () {
      final foo = CodecText(registry, 'bar');

      expect(Result(registry, CodecText.constructor, CodecText.constructor, {"Ok": foo}).asOk, foo);
    });

    test('returns a proper raw typedef rom a built-in', () {
      expect(registry.createType('DispatchResult').toRawType(), 'Result<(),DispatchError>');
    });
  });
}
