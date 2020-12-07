import 'package:polkadot_dart/types/codec/abstract_int.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

CodecInt Function(Registry, [int]) intWith(int bitLength, [String typeName]) {
  return (Registry registry, [int value]) => CodecInt(registry, value, bitLength, typeName);
}

class CodecInt extends AbstractInt {
  String _typeName;
  Registry registry;
  CodecInt(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value, bitLength, true) {
    _typeName = typeName;
    registry = registry;
  }
  static CodecInt constructor(Registry registry,
          [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName]) =>
      CodecInt(registry, value, bitLength, typeName);

  toRawType() {
    return _typeName ?? super.toRawType();
  }

  static Constructor<CodecInt> withParams(int bitLength, [String typeName]) =>
      intWith(bitLength, typeName);
}
