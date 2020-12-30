import 'package:polkadot_dart/types/codec/abstract_int.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

CodecInt Function(Registry, [dynamic]) intWith(int bitLength, [String typeName]) {
  return (Registry registry, [dynamic value]) => CodecInt(registry, value, bitLength, typeName);
}

class CodecInt extends AbstractInt {
  String _typeName;
  String get typeName => _typeName;
  Registry registry;
  CodecInt(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super.withReg(registry, value, bitLength, true) {
    _typeName = typeName;
    registry = registry;
  }
  static CodecInt constructor(Registry registry,
          [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName]) =>
      CodecInt(registry, value, bitLength, typeName);

  toRawType() {
    return _typeName ?? super.toRawType();
  }

  static Constructor<T> withParams<T extends CodecInt>(int bitLength, [String typeName]) =>
      intWith(bitLength, typeName);

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }
}
