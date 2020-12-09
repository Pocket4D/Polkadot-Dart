import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i8 extends CodecInt {
  i8(Registry registry, [dynamic value = 0, String typeName]) : super(registry, value, 8, typeName);
  static i8 constructor(Registry registry, [dynamic value = 0, String typeName]) =>
      i8(registry, value, typeName);
}
