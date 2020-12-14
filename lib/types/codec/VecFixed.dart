import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Vec.dart';
import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

VecFixed<T> Function(Registry, [dynamic]) vecFixedWith<T extends BaseCodec>(
    dynamic type, int length) {
  return (Registry registry, [dynamic value]) => VecFixed<T>(registry, type, length, value);
}

class VecFixed<T extends BaseCodec> extends AbstractArray<T> {
  Constructor<T> _type;

  VecFixed(Registry registry, dynamic type, int length, [dynamic value])
      : super(
            registry,
            VecFixed.decodeVecFixed(
                registry, typeToConstructor<T>(registry, type), length, value ?? [])) {
    final clazz = typeToConstructor<T>(registry, type);
    this._type = clazz;
  }

  /// @internal */
  static List<T> decodeVecFixed<T extends BaseCodec>(
      Registry registry, Constructor<T> type, int allocLength, dynamic value) {
    final values = Vec.decodeVec(
        registry, type, isU8a(value) ? u8aConcat([compactToU8a(allocLength), value]) : value);

    while (values.length < allocLength) {
      values.add(type(registry));
    }

    assert(values.length == allocLength, "Expected a length of exactly $allocLength entries");

    return values;
  }

  static VecFixed constructor(Registry registry, [dynamic type, int length, dynamic value]) =>
      VecFixed(registry, type, length, value);

  static Constructor<VecFixed<O>> withParams<O extends BaseCodec>(dynamic type, int length) =>
      vecFixedWith(type, length);

  /// @description The type for the items
  String get type {
    return this._type(this.registry).toRawType();
  }

  /// @description The length of the value when encoded as a Uint8List
  int get encodedLength {
    return this.toU8a().length;
  }

  Uint8List toU8a([dynamic isBare]) {
    // we override, we don't add the length prefix for ourselves, and at the same time we
    // ignore isBare on entries, since they should be properly encoded at all times
    final encoded = this.value.map((entry) => entry.toU8a());

    return encoded.length != 0 ? u8aConcat([...encoded]) : Uint8List.fromList([]);
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "[${this.type};${this.length}]";
  }

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }
}
