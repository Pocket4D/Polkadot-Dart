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

  final types = (_types is List)
      ? _types as List<Constructor>
      : (_types as Map<String, Constructor>).values.toList();

  return types.map((type) {
    var index = types.indexOf(type);
    try {
      var entry = value != null ? value[index] : null;

      if (entry is Constructor) {
        return entry;
      }

      return type(registry, entry);
    } catch (error) {
      throw "Tuple: failed on $index:: $error";
    }
  });
}

Tuple Function(Registry, dynamic) tupleWith(dynamic types) {
  return (Registry registry, dynamic value) => Tuple(registry, types, value);
}

class Tuple extends AbstractArray<BaseCodec> {
  dynamic _types;

  Tuple(Registry registry, dynamic types, dynamic value)
      : super(
            registry,
            decodeTuple(
                registry,
                (types is List)
                    ? types.map((type) => typeToConstructor(registry, type as BaseCodec))
                    : mapToTypeMap(registry, types),
                value)) {
    this._types = (types is List)
        ? types.map((type) => typeToConstructor(registry, type as BaseCodec))
        : mapToTypeMap(registry, types);
  }

  static Constructor<Tuple> withParams(dynamic types) => tupleWith(types);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.values.fold(0, (length, entry) {
      length += entry.encodedLength;
      return length;
    });
  }

  /// @description The types definition of the tuple
  List<String> get types {
    return (this._types is List<Constructor>)
        ? this._types.map((type) => type(this.registry).toRawType())
        : (this._types as Map).keys;
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
    return u8aConcat([...this.values.map((entry) => entry.toU8a(isBare))]);
  }
}
