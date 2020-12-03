import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u32 extends UInt {
  u32(Registry registry, [dynamic value = 0]) : super(registry, value, 32);
  static u32 constructor(Registry registry, [dynamic value = 0]) => u32(registry, value);
}
