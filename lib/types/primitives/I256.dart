import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i256 extends CodecInt {
  i256(Registry registry, [dynamic value = 0, String typeName])
      : super(registry, value, 256, typeName);
  static i256 constructor(Registry registry, [dynamic value = 0, String typeName]) =>
      i256(registry, value, typeName);
}
