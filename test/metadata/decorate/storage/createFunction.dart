import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/decorate/storage/createFunction.dart';

import 'package:polkadot_dart/types/types.dart' hide Metadata;
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  createFunctionTest(); // rename this test name
}

void createFunctionTest() {
  group('createFunction', () {
    final registry = new TypeRegistry();

    test('allows creating of known DoubleMap keys (with Bytes)', () {
      final storageFn = createFunction(
          registry,
          CreateItemFnImpl.fromMap(registry, {
            // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
            "meta": {
              "type": {
                "DoubleMap": {
                  "hasher": registry.createType('StorageHasher', 'Twox64Concat'),
                  "key1": new CodecText(registry, 'Bytes'),
                  "key2": new CodecText(registry, 'AccountId'),
                  "key2Hasher": registry.createType('StorageHasher', 'Blake2_256'),
                  "value": new CodecText(registry, 'SessionKeys5')
                },
              }
            },
            "method": 'NextKeys',
            "prefix": 'Session',
            "section": 'session'
          }),
          CreateItemOptions.fromMap({"metaVersion": 9}));

      expect(
          u8aToHex(storageFn.call([
            // hex, without length prefix
            '0x3a73657373696f6e3a6b657973',
            // address
            'DB2mp5nNhbFN86J9hxoAog8JALMhDXgwvWMxrRMLNUFMEY4'
          ])),
          '0x' +
              '5901' + // length
              'cec5070d609dd3497f72bde07fc96ba0' + // twox 128
              '4c014e6bf8b8c2c011e7290b85696bb3' + // twox 128
              '9fe6329cc0b39e09' + // twox 64
              '343a73657373696f6e3a6b657973' + // twox 64 (concat, with length)
              '5eb36b60f0fc4b9177116eba3e5cd57fea6289a57f5f5b9ffeb0475c66e7a521' // blake2
          );
    });
  });
}
