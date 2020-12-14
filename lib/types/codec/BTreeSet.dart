import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

Set<V> _decodeSetFromU8a<V extends BaseCodec>(
    Registry registry, Constructor<V> valClass, Uint8List u8a) {
  final output = Set<V>();
  final result = compactFromU8a(u8a);
  final offset = result[0] as int;
  final length = result[1] as BigInt;
  final types = [];

  for (var i = 0; i < length.toInt(); i++) {
    types.add(valClass);
  }

  final values = decodeU8a(registry, u8a.sublist(offset), types);

  for (var i = 0; i < values.length; i++) {
    output.add(values[i] as V);
  }

  return output;
}

Set<V> _decodeSetFromSet<V extends BaseCodec>(
    Registry registry, Constructor<V> valClass, dynamic value) {
  final output = Set<V>();

  (value as Iterable).forEach((val) {
    try {
      output.add((val is V) ? val : valClass(registry, val));
    } catch (error) {
      throw "Failed to decode key or value: $error";
    }
  });

  return output;
}

/// Decode input to pass into constructor.
///
/// @param valClass - Type of the map value
/// @param value - Value to decode, one of:
/// - null
/// - undefined
/// - hex
/// - Uint8Array
/// - Set<any>, where both key and value types are either
///   constructors or decodeable values for their types.
/// @param jsonSet
/// @internal
Set<V> _decodeSet<V extends BaseCodec>(Registry registry, dynamic valType, dynamic value) {
  if (value == null) {
    return Set<V>();
  }

  final valClass = typeToConstructor(registry, (valType));

  if (isHex(value)) {
    return _decodeSet(registry, valClass, hexToU8a(value));
  } else if (isU8a(value)) {
    return _decodeSetFromU8a<V>(registry, valClass, u8aToU8a(value));
  } else if ((value is List) || value is Set) {
    // print(value);
    return _decodeSetFromSet<V>(registry, valClass, value);
  }

  throw 'BTreeSet: cannot decode type';
}

BTreeSet<V> Function(Registry, [dynamic]) _bTreeSetWith<V extends BaseCodec>(dynamic valType) {
  return (Registry registry, [dynamic value]) => BTreeSet<V>(registry, valType, value);
}

class BTreeSet<V extends BaseCodec> extends BaseCodec {
  Registry registry;

  Constructor<V> _valClass;
  Set<V> _value;

  Set<V> get value => _value;

  BTreeSet(Registry registry, dynamic valType, [dynamic rawValue]) {
    _value = (_decodeSet(registry, valType, rawValue));

    this.registry = registry;
    this._valClass = typeToConstructor(registry, valType);
  }

  static Constructor<BTreeSet<V>> withParams<V extends BaseCodec>(dynamic valType) =>
      _bTreeSetWith(valType);

  static BTreeSet constructor(Registry registry, [dynamic valType, dynamic rawValue]) =>
      BTreeSet(registry, valType, rawValue);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    var len = compactToU8a(this._value.length).length;

    this._value.forEach((v) => {len += v.encodedLength});

    return len;
  }

  /// @description Returns a hash of the value
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return this._value.length == 0;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return compareSet(this._value, other);
  }

  /// @description Returns a hex string representation of the value. isLe returns a LE (number-only) representation
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    var json = [];

    this._value.forEach((v) {
      json.add(v.toHuman(isExtended));
    });

    return json;
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    var json = [];

    this._value.forEach((v) {
      json.add(v.toJSON());
    });

    return json;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "BTreeSet<${this.registry.getClassName(this._valClass) ?? this._valClass(this.registry).toRawType()}>";
  }

  /// @description Returns the string representation of the value
  String toString() {
    return jsonEncode(this.toJSON());
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes (internal)
  Uint8List toU8a([dynamic isBare]) {
    var encoded = List<Uint8List>();

    if ((isBare is bool && !isBare) || isBare == null) {
      encoded.add(compactToU8a(this._value.length));
    }

    this._value.forEach((v) {
      encoded.add(v.toU8a(isBare));
    });

    return u8aConcat([...encoded]);
  }
}
