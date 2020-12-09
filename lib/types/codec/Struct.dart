import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

// type TypesDef<T = Codec> = Record<string, keyof InterfaceTypes | Constructor<T>>;
// type ConstructorDef<T = Codec> = Record<string, Constructor<T>>;

T decodeStructFromObject<T extends Map<dynamic, BaseCodec>>(Registry registry,
    Map<String, Constructor> types, dynamic value, Map<dynamic, String> jsonMap) {
  Map<String, dynamic> jsonObj;
  final keys = types.keys.toList();
  return (keys).fold(Map<dynamic, BaseCodec>.from({}) as T, (raw, key) {
    // The key in the JSON can be snake_case (or other cases), but in our
    // Types, result or any other maps, it's camelCase
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    final index = keys.indexOf(key);

    final jsonKey = (jsonMap[key] != null && value[key] == null) ? jsonMap[key] : key;

    try {
      if ((value is List)) {
        // TS2322: Type 'Codec' is not assignable to type 'T[keyof S]'.
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment,@typescript-eslint/no-unsafe-member-access
        (raw as dynamic)[key] =
            value[index] is T ? value[index] : types[key](registry, value[index]);
      }
      // else if (value is Map) {
      //   // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      //   final mapped = value[jsonKey];
      //   // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      //   (raw as dynamic)[key] = mapped is T ? mapped : types[key](registry, mapped);
      // }
      else if (value is Struct) {
        final mapped = value.value[jsonKey];
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        (raw as dynamic)[key] = mapped is T ? mapped : types[key](registry, mapped);
      } else if (value is Map) {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        var assign = value[jsonKey];

        if ((assign == null)) {
          if ((jsonObj == null)) {
            jsonObj = value.entries.fold({}, (all, entry) {
              // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
              all[stringCamelCase(entry.key)] = entry.value;

              return all;
            });
          }

          // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
          assign = jsonObj[jsonKey];
        }

        (raw)[key] = assign.runtimeType == types[key](registry, assign)
            ? assign
            : types[key](registry, assign);
      } else {
        throw "Cannot decode value ${jsonEncode(value)}";
      }
    } catch (error) {
      var type = types[key](registry).toRawType();

      throw "Struct: failed on $jsonKey: $type:: $error";
    }

    return raw;
  });
}

/// Decode input to pass into constructor.
///
/// @param Types - Types definition.
/// @param value - Value to decode, one of:
/// - null
/// - undefined
/// - hex
/// - Uint8Array
/// - object with `{ key1: value1, key2: value2 }`, assuming `key1` and `key2`
/// are also keys in `Types`
/// - array with `[value1, value2]` assuming the array has the same length as
/// `Object.keys(Types)`
/// @param jsonMap
/// @internal
T decodeStruct<T extends Map<dynamic, BaseCodec>>(Registry registry, Map<String, Constructor> types,
    dynamic value, Map<dynamic, String> jsonMap) {
  if (isHex(value)) {
    return decodeStruct(registry, types, hexToU8a(value as String), jsonMap);
  } else if (isU8a(value)) {
    final values = decodeU8a(registry, value, types.values.toList());
    final keys = types.keys.toList();
    // Transform array of values to {key: value} mapping
    return keys.fold(
      Map<dynamic, BaseCodec>.from({}) as T,
      (raw, key) {
        // TS2322: Type 'Codec' is not assignable to type 'T[keyof S]'.
        // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
        final index = keys.indexOf(key);
        (raw as dynamic)[key] = values[index];
        return raw;
      },
    );
  } else if (value == null) {
    return Map<dynamic, BaseCodec>.from({}) as T;
  }

  // We assume from here that value is a JS object (Array, Map, Object)
  return decodeStructFromObject(registry, types, value, jsonMap);
}

class Struct<S extends Map<String, dynamic>, V extends Map, E extends Map<dynamic, String>>
    extends BaseCodec {
  Registry registry;
  Map<dynamic, BaseCodec> _value;
  Map<dynamic, BaseCodec> get value => _value;
  Map<dynamic, String> _jsonMap;
  Map<String, Constructor<BaseCodec>> _types;
  // List<String> _keys;
  Struct(Registry registry, S types, [dynamic value = const {}, Map<dynamic, String> jsonMap]) {
    if (jsonMap == null) {
      jsonMap = Map<dynamic, String>();
    }

    final decoded = decodeStruct(registry, mapToTypeMap(registry, types), value, jsonMap);

    _value = Map<dynamic, BaseCodec>.fromEntries(decoded.entries);
    this.registry = registry;
    this._jsonMap = jsonMap ?? Map<dynamic, String>();
    this._types = mapToTypeMap(registry, types);
  }
  static Map<String, String> typesToMap(Registry registry, Map<String, Constructor> types) {
    return (types.entries).fold({}, (result, entry) {
      result[entry.key] = registry.getClassName(entry.value) ?? (entry.value)(registry).toRawType();
      return result;
    });
  }

  static Constructor<Struct> withParams<S extends Map<String, dynamic>>(S types,
      [Map<dynamic, String> jsonMap]) {
    return (Registry registry, [dynamic value]) {
      return Struct(registry, types, value, jsonMap);
    };
  }

  static Struct
      constructor<S extends Map<String, dynamic>, V extends Map, E extends Map<dynamic, String>>(
              Registry registry,
              [dynamic types,
              dynamic value,
              Map<dynamic, String> jsonMap]) =>
          Struct(registry, types as S, value, jsonMap);

  /// @description The available keys for this enum
  List<String> get defKeys {
    return this._types.keys;
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty => this._value.isEmpty;

  // ignore: non_constant_identifier_names
  E get Type {
    return (this._types.entries).fold(Map<dynamic, String>.from({}) as E, (result, entry) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
      (result as dynamic)[entry.key] = (entry.value)(this.registry).toRawType();
      return result;
    });
  }

  int get encodedLength {
    return this.toArray().fold(0, (length, entry) {
      length += entry.encodedLength;
      return length;
    });
  }

  List<BaseCodec> toArray() {
    return this._value.values.toList();
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq([dynamic other]) {
    return compareMap(this.toJSON(), other is Struct ? other.toJSON() : other);
  }

  /// @description Returns a specific names entry in the structure
  /// @param name The name of the entry to retrieve
  BaseCodec getCodec(String name) {
    return this._value[name];
  }

  /// @description Returns the values of a member at a specific index (Rather use get(name) for performance)
  BaseCodec getAtIndex(int index) {
    return this.toArray()[index];
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  Map<String, dynamic> toHuman([bool isExtended]) {
    return [...this._value.keys].fold({}, (json, key) {
      final value = this._value[key];
      json[key] = value != null && value.toHuman(isExtended);
      return json;
    });
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  Map<String, dynamic> toJSON() {
    return [...this._value.keys].fold({}, (json, key) {
      final jsonKey = this._jsonMap[key] ?? key;
      final value = this._value[key];
      json[jsonKey] = value?.toJSON();
      return json;
    });
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return jsonEncode(Struct.typesToMap(this.registry, this._types));
  }

  /// @description Returns the string representation of the value
  String toString() {
    return jsonEncode(this.toJSON());
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes (internal)
  Uint8List toU8a([dynamic isBare]) {
    // we have keyof S here, cast to string to make it compatible with isBare
    final entries = [...this._value.entries];

    return u8aConcat([
      ...entries
          // eslint-disable-next-line @typescript-eslint/unbound-method
          .takeWhile((entry) => isFunction(entry.value?.toU8a))
          .map((entry) =>
              entry.value.toU8a(((isBare is bool) || isBare == null) ? isBare : isBare[entry.key]))
    ]);
  }

  void put(dynamic key, BaseCodec value) {
    this._value[key] = value;
  }
}
