import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';

import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const MAX_LENGTH = 64 * 1024;

Vec<T> Function(Registry, [dynamic]) vecWith<T extends BaseCodec>(dynamic type) {
  return (Registry registry, [dynamic value]) {
    if (value is Vec<T>) {
      return Vec.empty()
        ..setType(value.constructorType)
        ..originType = value.originType
        ..originValue = value.originValue
        ..registry = value.registry
        ..setValues(value.value);
    }
    return Vec<T>(registry, type, value);
  };
}

typedef CodecTransformer<T> = T Function<T extends BaseCodec>(BaseCodec data);

class Vec<T extends BaseCodec> extends AbstractArray<T> {
  Constructor<T> _type;
  Constructor<T> get constructorType => _type;
  dynamic originType;
  dynamic originValue;
  Vec.empty() : super.empty();
  Vec(Registry registry, dynamic type, [dynamic value])
      : super.withReg(
            registry,
            Vec.decodeVec(registry, typeToConstructor<T>(registry, type),
                value is Vec ? value.value : value ?? [])) {
    originType = type;
    originValue = value;
    if (value == null) {
      value = [];
    }
    final clazz = typeToConstructor<T>(registry, type);
    this._type = clazz;
  }

  static constructor(Registry registry, [dynamic type, dynamic value]) =>
      Vec(registry, type, value);

  static Vec<T> fromVec<T extends BaseCodec>(Vec codec, List<T> list) {
    return Vec.empty()
      ..setType(null)
      ..originType = codec.originType
      ..originValue = codec.originValue
      ..registry = codec.registry
      ..setValues(list);
  }

  static Vec<T> withTransformer<T extends BaseCodec, F extends BaseCodec>(
      Vec codec, T Function(F) transformer) {
    return Vec.empty()
      ..setType(null)
      ..originType = codec.originType
      ..originValue = codec.originValue
      ..registry = codec.registry
      ..setValues(codec.value.map((value) => transformer(value)).toList());
  }

  void setType(Constructor<T> toSet) {
    this._type = toSet;
  }

  static List<T> decodeVec<T extends BaseCodec>(
      Registry registry, Constructor<T> type, dynamic value) {
    var theValue = value;
    if (theValue is Iterable && !isU8a(theValue)) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-return
      List<T> result = List<T>.generate(theValue.length, (index) => null);
      for (int i = 0; i < theValue.length; i += 1) {
        try {
          result[i] = theValue.elementAt(i) is Constructor<T>
              ? theValue.elementAt(i)
              : type(registry, theValue.elementAt(i));
        } catch (error) {
          throw "Unable to decode on index $i $error";
        }
      }
      return result;
    }

    var u8a = theValue is Uint8List ? theValue : u8aToU8a(theValue);

    final compact = compactFromU8a(u8a);

    final offset = compact[0] as int;
    final length = compact[1] as BigInt;
    if (u8a.isEmpty) {
      u8a = Uint8List.fromList([0]);
    }

    assert(length.toInt() <= (MAX_LENGTH), "Vec length ${length.toString()} exceeds $MAX_LENGTH");
    return decodeU8a(registry, u8a.sublist(offset > u8a.length ? u8a.length : offset),
        List.filled(length.toInt(), type));
  }

  static Constructor<Vec<O>> withParams<O extends BaseCodec>(dynamic type) => vecWith(type);

  /// @description The type for the items
  get type {
    Type typeName = T;
    return typeName.toString();
  }

  /// @description Finds the index of the value in the array
  int indexOf([dynamic _other]) {
    // convert type first, this removes overhead from the eq
    final other = _other is BaseCodec ? _other : this._type(this.registry, _other);

    for (var i = 0; i < this.length; i++) {
      if (other.eq(this.value[i])) {
        return i;
      }
    }

    return -1;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "Vec<${this.registry.getClassName(this._type) ?? this._type(this.registry).toRawType()}>";
  }

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }

  Vec.fromList(List<T> list, [Registry registry, String dataType]) {
    this.setValues(list);
    this.registry = registry;
    this.originType = dataType;
    this.originValue = list;
  }
}
