import 'package:polkadot_dart/types/codec/abstract_int.dart';
import 'package:polkadot_dart/types/codec/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

UInt Function(Registry, [dynamic]) uintWith(int bitLength, [String typeName]) {
  return (Registry registry, [dynamic value]) => UInt(registry, value, bitLength);
}

class UInt extends AbstractInt {
  String _typeName;
  UInt(Registry registry, [dynamic value = 0, int bitLength]) : super(registry, value, bitLength);

  static UInt constructor(Registry registry, [dynamic value = 0, int bitLength]) =>
      UInt(registry, value, bitLength);

  static Constructor<UInt> withParams(int bitLength, [String typeName]) =>
      uintWith(bitLength, typeName);

  toRawType() {
    return _typeName ?? super.toRawType();
  }
}
