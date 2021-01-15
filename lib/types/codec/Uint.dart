import 'package:polkadot_dart/types/codec/abstract_int.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

UInt Function(Registry, [dynamic]) uintWith(int bitLength, [String typeName]) {
  return (Registry registry, [dynamic value]) {
    var result = UInt(registry, value, bitLength);
    result.setRawType(typeName);
    return result;
  };
}

class UInt extends AbstractInt {
  String _typeName;
  String get typeName => _typeName;
  UInt.empty();
  UInt(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super.withReg(registry, value, bitLength);
  static UInt constructor(Registry registry,
          [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS]) =>
      UInt(registry, value, bitLength);

  static Constructor<T> withParams<T extends UInt>(int bitLength, [String typeName]) =>
      uintWith(bitLength, typeName);

  static getExtends(int bitLength, [String typeName]) {}

  String toRawType() {
    return _typeName ?? super.toRawType();
  }

  void setRawType(String name) {
    _typeName = name;
  }

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }
}
