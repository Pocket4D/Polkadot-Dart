import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Data.dart';

void main() {
  dataTest(); // rename this test name
}

void dataTest() {
  final registry = TypeRegistry();
  group('Data', () {
    test('encodes a normal None', () {
      expect(Data(registry).toHex(), '0x00');
    });

    test('encodes a hashed value correctly', () {
      expect(
          Data(registry, {
            "Keccak256": '0x0102030405060708091011121314151617181920212223242526272829303132'
          }).toHex(),
          '0x240102030405060708091011121314151617181920212223242526272829303132');
    });

    test('encodes a Raw value correctly', () {
      expect(Data(registry, {"Raw": '0x0102030405060708'}).toHex(), '0x090102030405060708');
    });
  });
}
