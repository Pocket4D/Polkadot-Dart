import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Struct.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

typedef EnumConstructor<T extends BaseCodec> = T Function(Registry registry,
    [dynamic value, int index]);

// type TypesDef = Record<string, Constructor>;

class DecodedEnum {
  int index;
  BaseCodec value;
  DecodedEnum({this.index, this.value});
  toMap() => {"index": this.index, "value": this.value};
}

class EnumDef {
  Map<String, Constructor> def;
  bool isBasic;
  EnumDef({this.def, this.isBasic});
  toMap() => {"def": this.def, "isBasic": this.isBasic};
}

// Record<string, keyof InterfaceTypes | Constructor> | string[]
// { def: TypesDef; isBasic: boolean }

EnumDef extractDef(Registry registry, dynamic _def) {
  if (!(_def is List) && _def is Map) {
    /// force new key as string, CodecText cannot extends String directly
    Map<String, dynamic> newDef = {};
    _def.forEach((key, value) {
      newDef.putIfAbsent(key.toString(), () => value);
    });

    final def = mapToTypeMap(registry, Map<String, dynamic>.from(newDef));

    final isBasic = !(def).values.any((type) {
      return !(type.runtimeType.toString().contains("CodecNull"));
    });

    return EnumDef(def: def, isBasic: isBasic);
  } else {
    final Map<String, Constructor> def = (_def as List).fold({}, (def, key) {
      def[key] = CodecNull.constructor;
      return def;
    });
    final isBasic = true;
    return EnumDef(def: def, isBasic: isBasic);
  }
}

DecodedEnum createFromValue(Registry registry, Map<String, Constructor> def,
    [int index = 0, dynamic value]) {
  final clazz = (def.values).toList()[index];
  assert(clazz != null, "Unable to create Enum via index $index, in ${(def.keys).join(', ')}");
  return DecodedEnum(index: index, value: value is Constructor ? value : clazz(registry, value));
}

DecodedEnum decodeFromJSON(Registry registry, Map<String, Constructor> def, String key,
    [dynamic value]) {
  // JSON comes in the form of { "<type (lowercased)>": "<value for type>" }, here we
  // additionally force to lower to ensure forward compat
  final keys = (def.keys.toList()).map((k) => k.toLowerCase());

  final keyLower = key.toLowerCase();
  final index = keys.toList().indexOf(keyLower);

  assert(index != -1, "Cannot map Enum JSON, unable to find '$key' in ${keys.join(', ')}");

  try {
    return createFromValue(registry, def, index, value);
  } catch (error) {
    throw "Enum($key):: $error";
  }
}

DecodedEnum decodeFromString(Registry registry, Map<String, Constructor> def, String value) {
  return isHex(value)
      // eslint-disable-next-line @typescript-eslint/no-use-before-define
      ? decodeFromValue(registry, def, hexToU8a(value))
      : decodeFromJSON(registry, def, value);
}

DecodedEnum decodeFromValue(Registry registry, Map<String, Constructor> def, [dynamic value]) {
  if (value is Uint8List) {
    return createFromValue(registry, def, value[0], value.sublist(1));
  } else if (isNumber(value)) {
    return createFromValue(registry, def, value);
  } else if (isString(value)) {
    return decodeFromString(registry, def, value.toString());
  } else if ((value is Map)) {
    final key = (value.keys.toList())[0];
    return decodeFromJSON(registry, def, key, value[key]);
  }
  // Worst-case scenario, return the first with default
  return createFromValue(registry, def, 0);
}

DecodedEnum decodeEnum(Registry registry, Map<String, Constructor> def,
    [dynamic value, int index]) {
  // NOTE We check the index path first, before looking at values - this allows treating
  // the optional indexes before anything else, more-specific > less-specific
  if (isNumber(index)) {
    return createFromValue(registry, def, index, value);
    // eslint-disable-next-line @typescript-eslint/no-use-before-define
  } else if (value is Enum) {
    return createFromValue(registry, def, value.index, value.value);
  }

  // Or else, we just look at `value`
  return decodeFromValue(registry, def, value);
}

Enum<T> Function(Registry, [dynamic, int]) enumWith<T extends BaseCodec>(dynamic types) {
  return (Registry registry, [dynamic value, int index]) {
    var result = Enum<T>(registry, types, value, index);
    result.genKeys();
    return result;
  };
}

class Enum<T extends BaseCodec> extends BaseCodec {
  Registry registry;

  Map<String, Constructor> def;

  int _index;

  List<int> _indexes;

  bool _isBasic;

  T _raw;

  List<String> iskeys = [];
  List<String> askeys = [];

  dynamic originDef;
  dynamic originValue;
  dynamic originIndex;
  Enum(Registry registry, dynamic def, [dynamic value, int index]) {
    originDef = def;
    originValue = value;
    originIndex = index;
    final defInfo = extractDef(registry, def);
    final decoded = decodeEnum(registry, defInfo.def, value, index);
    final defList = defInfo.def.keys.toList();
    this.registry = registry;
    this.def = defInfo.def;
    this._isBasic = defInfo.isBasic;
    this._indexes = defList.map((def) => defList.indexOf(def)).toList();
    this._index = this._indexes.indexOf(decoded.index) ?? 0;
    this._raw = decoded.value;
    this.genKeys();
  }

  static Enum constructor(Registry registry, [dynamic def, dynamic value, int index]) =>
      Enum(registry, def, value, index);

  static Constructor<Enum<T>> withParams<T extends BaseCodec>(dynamic types) {
    return (Registry registry, [dynamic value, int index]) {
      var result = Enum<T>(registry, types, value, index);
      result.genKeys();
      return result;
    };
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return 1 + this._raw.encodedLength;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description The index of the metadata value
  int get index {
    return this._index;
  }

  /// @description true if this is a basic enum (no values)
  bool get isBasic {
    return this._isBasic;
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return this._raw.isEmpty;
  }

  /// @description Checks if the Enum points to a [[Null]] type
  bool get isNone {
    return this.isNull;
  }

  /// @description Checks if the Enum points to a [[Null]] type (deprecated, use isNone)
  bool get isNull {
    return this._raw is CodecNull;
  }

  /// @description The available keys for this enum
  List<String> get defEntries {
    return this.def.keys.toList();
  }

  /// @description The available keys for this enum
  List<String> get defKeys {
    return this.def.keys.toList();
  }

  /// @description The name of the type this enum value represents
  String get type {
    return this.defKeys[this._index];
  }

  /// @description The value of the enum
  BaseCodec get value {
    return this._raw;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    // cater for the case where we only pass the enum index
    if (isNumber(other)) {
      return this.toNumber() == other;
    } else if (this._isBasic && isString(other)) {
      return this.type == other;
    } else if (isU8a(other)) {
      var u8a = this.toU8a();
      return !u8a.any((entry) => entry != other[u8a.indexOf(entry)]);
    } else if (isHex(other)) {
      return this.toHex() == other;
    } else if (other is Enum) {
      return this.index == other.index && this.value.eq(other.value);
    } else if (isObject(other)) {
      return this.value.eq(other[this.type]);
    }

    // compare the actual wrapper value
    return this.value.eq(other);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._isBasic ? this.type : {this.type: this._raw.toHuman(isExtended)};
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    return this._isBasic ? this.type : {this.type: this._raw.toJSON()};
  }

  /// @description Returns the number representation for the value
  int toNumber() {
    return this._index;
  }

  /// @description Returns a raw struct representation of the enum types
  dynamic _toRawStruct() {
    return this._isBasic ? this.defKeys : Struct.typesToMap(this.registry, this.def);
  }

  dynamic toRawStruct() {
    return this._toRawStruct();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return jsonEncode({"_enum": this._toRawStruct()});
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this.isNull ? this.type : jsonEncode(this.toJSON());
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes (internal)
  Uint8List toU8a([dynamic isBare]) {
    return u8aConcat([
      Uint8List.fromList(isBare is bool && isBare ? [] : [this._indexes[this._index]]),
      this._raw.toU8a(isBare)
    ]);
  }

  bool isKey(String name) {
    var found = iskeys.singleWhere((element) => element == "is${this.type}", orElse: () => null);
    return found != null && found == "is$name";
  }

  T askey(String typeName) {
    assert(isKey(typeName), "Cannot convert '${this.type}' via as$typeName");
    return this.value;
  }

  genKeys() {
    this.def.keys.toList().forEach((_key) {
      final name = stringUpperFirst(stringCamelCase(_key.replaceAll(' ', '_')));
      final iskey = "is$name";
      final askey = "as$name";
      iskeys.add(iskey);
      askeys.add(askey);
    });
  }
}
