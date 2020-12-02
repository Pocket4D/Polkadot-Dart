import 'package:polkadot_dart/types/codec/Int.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class i8 extends CodecInt {
  i8(Registry registry, [int value = 0, String typeName]) : super(registry, value, 8, typeName);
}
