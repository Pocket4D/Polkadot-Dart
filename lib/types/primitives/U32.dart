import 'package:polkadot_dart/types/codec/Uint.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class u32 extends UInt {
  u32(Registry registry, [int value = 0]) : super(registry, value, 32);
}
