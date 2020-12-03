import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u128 extends UInt {
  u128(Registry registry, [int value = 0]) : super(registry, value, 128);
  static u128 constructor(Registry registry, [dynamic value = 0]) => u128(registry, value);
}
