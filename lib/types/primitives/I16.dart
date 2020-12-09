import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i16 extends CodecInt {
  i16(Registry registry, [dynamic value = 0, String typeName])
      : super(registry, value, 16, typeName);
  static i16 constructor(Registry registry, [dynamic value = 0, String typeName]) =>
      i16(registry, value, typeName);
}
