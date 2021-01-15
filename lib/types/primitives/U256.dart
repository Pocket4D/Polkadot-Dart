import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u256 extends UInt {
  u256.empty() : super.empty();
  u256(Registry registry, [dynamic value = 0]) : super(registry, value, 256);
  static u256 constructor(Registry registry, [dynamic value = 0]) => u256(registry, value);
}
