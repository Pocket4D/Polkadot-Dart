import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/createClass.dart';
import 'package:polkadot_dart/types/create/types.dart';
import 'package:polkadot_dart/types/types.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  createClassTest(); // rename this test name
}

void createClassTest() {
  group('createClass', () {
    final registry = new TypeRegistry();

    test('should memoize from strings', () {
      final a = createClass(registry, 'BabeWeight');
      final b = createClass(registry, 'BabeWeight');
      expect(a, b);
    });

    test('should return equivalents for Bytes & Vec<u8>', () {
      final a = createClass(registry, 'Vec<u8>');
      final b = createClass(registry, 'Bytes');
      expect(a.runtimeType, b.runtimeType);
      // expect(A(registry).runtimeType == B(registry).runtimeType, true);
    });
  });

  group('getTypeClass', () {
    final registry = new TypeRegistry();

    test('warns on invalid types', () {
      final typeDef = TypeDef.fromMap({"info": TypeDefInfo.Plain, "type": 'ABC'});
      var result = getTypeClass(registry, typeDef);
      print(result);
    });
  });
}
