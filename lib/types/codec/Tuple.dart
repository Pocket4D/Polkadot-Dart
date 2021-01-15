import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

// type AnyTuple = AnyU8a | string |Codec | AnyU8a | AnyNumber | AnyString | undefined | null)[];

// type TupleConstructors = Constructor[] | {
//   [index: string]: Constructor;
// };

// type TupleTypes = (Constructor | keyof InterfaceTypes)[] | {
//   [index: string]: Constructor | keyof InterfaceTypes;
// };

List<BaseCodec> decodeTuple(Registry registry, dynamic _types, [dynamic value]) {
  if (isU8a(value)) {
    return decodeU8a(registry, value, _types);
  } else if (isHex(value)) {
    return decodeTuple(registry, _types, hexToU8a(value));
  }

  final types = (_types is Iterable<Constructor>)
      ? _types.toList()
      : (_types as Map<String, Constructor>).values.toList();

  // ignore: deprecated_member_use
  List<BaseCodec> resultList = List<BaseCodec>(types.length);

  if (types.length >= 1) {
    for (var i = 0; i < types.length; i += 1) {
      var type = types[i];
      try {
        var entry = (value == null || (value is List && value.isEmpty)) ? null : value[i];
        if (entry is BaseCodec) {
          resultList[i] = entry;
        }

        resultList[i] = type(registry, entry);
      } catch (error) {
        throw "Tuple: failed on $i:: $error";
      }
    }
  }
  return resultList;
}

Tuple Function(Registry, [dynamic]) tupleWith(dynamic types) {
  return (Registry registry, [dynamic value]) => Tuple(registry, types, value);
}

class Tuple extends AbstractArray<BaseCodec> {
  dynamic _types;
  Tuple.empty();
  Tuple(Registry registry, dynamic types, dynamic value)
      : super.withReg(
            registry,
            decodeTuple(
                registry,
                (types is List)
                    ? types.map((type) => typeToConstructor(registry, type)).toList()
                    : mapToTypeMap(registry, types),
                value)) {
    this._types = (types is List)
        ? types.map((type) => typeToConstructor(registry, type)).toList()
        : mapToTypeMap(registry, types);
  }

  static Constructor<Tuple> withParams(dynamic types) => tupleWith(types);

  static Tuple constructor(Registry registry, [dynamic types, dynamic value]) =>
      Tuple(registry, types, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.value.fold(0, (length, entry) {
      length += entry.encodedLength;
      return length;
    });
  }

  /// @description The types definition of the tuple
  List<String> get types {
    if (this._types is List<Constructor>) {
      return (this._types as List<Constructor>)
          .map((type) => type(this.registry).toRawType())
          .toList();
    } else {
      return (this._types as Map<String, dynamic>).keys.toList();
    }
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    final types = (this._types is List<Constructor>)
        ? this._types
        : ((this._types as Map<dynamic, Constructor>).values)
            .map((type) => this.registry.getClassName(type) ?? type(this.registry).toRawType());

    return "(${types.join(',')})";
  }

  /// @description Returns the string representation of the value
  String toString() {
    // Overwrite the default toString representation of Array.
    return jsonEncode(this.toJSON());
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixesinternal)
  Uint8List toU8a([dynamic isBare]) {
    return u8aConcat([...this.value.map((entry) => entry.toU8a(isBare))]);
  }

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }
}
