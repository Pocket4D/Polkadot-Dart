import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';

import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const MAX_LENGTH = 64 * 1024;

Vec<T> Function(Registry, [dynamic]) vecWith<T extends BaseCodec>(dynamic type) {
  return (Registry registry, [dynamic value]) => Vec<T>(registry, type, value);
}

class Vec<T extends BaseCodec> extends AbstractArray<T> {
  Constructor<T> _type;
  Constructor<T> get constructorType => _type;
  dynamic originType;
  dynamic originValue;

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

  /// @internal */
  // static List<T> decodeVec<T extends BaseCodec>(
  //     Registry registry, Constructor<T> type, dynamic value) {
  //   if (value is Vec<T>) {
  //     value = (value as Vec<T>).value;
  //   }

  //   if (!isU8a(value)) {
  //     if (value is List<T>) {
  //       return (value as List<T>).map((entry) {
  //         final index = value.indexOf(entry);
  //         try {
  //           return entry is Constructor<T> ? entry : type(registry, entry);
  //         } catch (error) {
  //           throw "Unable to decode on index $index $error";
  //         }
  //       }).toList();
  //     } else if (value is List<dynamic>) {
  //       return (value).map<T>((entry) {
  //         final index = value.indexOf(entry);
  //         try {
  //           return entry is Constructor<T> ? entry : type(registry, entry);
  //         } catch (error) {
  //           throw "Unable to decode on index $index $error";
  //         }
  //       }).toList();
  //     }
  //   }

  //   var u8a = u8aToU8a(value is Uint8List ? List<int>.from(value) : value);

  //   if (u8a.isEmpty) {
  //     u8a = Uint8List.fromList([0]);
  //   }
  //   final compact = compactFromU8a(u8a);

  //   final offset = compact[0] as int;
  //   final length = compact[1] as BigInt;

  //   assert(length.toInt() <= (MAX_LENGTH), "Vec length ${length.toString()} exceeds $MAX_LENGTH");
  //   return decodeU8a(registry, u8a.sublist(offset), List.filled(length.toInt(), type));
  // }

  static List<T> decodeVec<T extends BaseCodec>(
      Registry registry, Constructor<T> type, dynamic value) {
    var theValue = value;
    if (theValue is List && !isU8a(theValue)) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-return
      return (theValue).map<T>((entry) {
        final index = theValue.indexOf(entry);
        try {
          return entry is Constructor<T> ? entry : type(registry, entry);
        } catch (error) {
          throw "Unable to decode on index $index $error";
        }
      }).toList();
    }

    var u8a = u8aToU8a(theValue is Uint8List ? List<int>.from(theValue) : theValue);

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
