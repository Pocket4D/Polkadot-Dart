import 'package:polkadot_dart/types/codec/abstract_int.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

UInt Function(Registry, [num]) uintWith(int bitLength, [String typeName]) {
  return (Registry registry, [num value]) => UInt(registry, value, bitLength);
}

class UInt extends AbstractInt {
  String _typeName;
  UInt(Registry registry, [int value = 0, int bitLength]) : super(registry, value, bitLength);

  static Constructor<UInt> withParams(int bitLength, [String typeName]) =>
      uintWith(bitLength, typeName);

  toRawType() {
    return _typeName ?? super.toRawType();
  }
}
