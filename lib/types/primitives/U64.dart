import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u64 extends UInt {
  u64(Registry registry, [dynamic value = 0]) : super(registry, value, 64);
  static u64 constructor(Registry registry, [dynamic value = 0]) => u64(registry, value);
}
