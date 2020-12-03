import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u8 extends UInt {
  u8(Registry registry, [int value = 0]) : super(registry, value, 8);
  static u8 constructor(Registry registry, [dynamic value = 0]) => u8(registry, value);
}
