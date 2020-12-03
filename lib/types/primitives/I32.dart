import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i32 extends CodecInt {
  i32(Registry registry, [int value = 0, String typeName]) : super(registry, value, 32, typeName);
  static i32 constructor(Registry registry, [dynamic value = 0, String typeName]) =>
      i32(registry, value, typeName);
}
