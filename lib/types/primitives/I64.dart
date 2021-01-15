import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i64 extends CodecInt {
  i64.empty() : super.empty();
  i64(Registry registry, [dynamic value = 0, String typeName])
      : super(registry, value, 64, typeName);
  static i64 constructor(Registry registry, [dynamic value = 0, String typeName]) =>
      i64(registry, value, typeName);
}
