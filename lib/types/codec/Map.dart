import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

Map<K, V> decodeMapFromU8a<K extends BaseCodec, V extends BaseCodec>(
    Registry registry, Constructor<K> keyClass, Constructor<V> valClass, Uint8List u8a) {
  final output = Map<K, V>();
  final cList = compactFromU8a(u8a);
  final types = [];
  var offset = cList[0];
  var length = cList[1];

  for (var i = 0; i < length.toNumber(); i++) {
    types.add(keyClass);
    types.add(valClass);
  }

  final values = decodeU8a(registry, u8a.sublist(offset), types);

  for (var i = 0; i < values.length; i += 2) {
    output[values[i] as K] = (values[i + 1] as V);
  }

  return output;
}

// /** @internal */
Map<K, V> decodeMapFromMap<K extends BaseCodec, V extends BaseCodec>(
    Registry registry, Constructor<K> keyClass, Constructor<V> valClass, Map value) {
  final output = Map<K, V>();

  value.forEach((key, val) {
    try {
      output[key is K ? key : keyClass(registry, key)] = val is V ? val : valClass(registry, val);
    } catch (error) {
      throw "Failed to decode key or value: $error";
    }
  });
  return output;
}

// /**
//  * Decode input to pass into constructor.
//  *
//  * @param KeyClass - Type of the map key
//  * @param ValClass - Type of the map value
//  * @param value - Value to decode, one of:
//  * - null
//  * - undefined
//  * - hex
//  * - Uint8Array
//  * - Map<any, any>, where both key and value types are either
//  *   constructors or decodeable values for their types.
//  * @param jsonMap
//  * @internal
//  */
//  : Constructor<K> | keyof InterfaceTypes
//  : Constructor<K> | keyof InterfaceTypes
Map<K, V> decodeMap<K extends BaseCodec, V extends BaseCodec>(
    Registry registry, dynamic keyType, dynamic valType,
    [dynamic value]) {
  final keyClass = typeToConstructor(registry, (keyType));
  final vClass = typeToConstructor(registry, (valType));

  if (value == null) {
    return new Map<K, V>();
  } else if (isHex(value)) {
    return decodeMap(registry, keyClass, vClass, hexToU8a(value));
  } else if (isU8a(value)) {
    return decodeMapFromU8a<K, V>(registry, keyClass, vClass, u8aToU8a(value));
  } else if (value is Map) {
    return decodeMapFromMap<K, V>(registry, keyClass, vClass, value);
  }
  throw 'Map: cannot decode type';
}

class CodecMap<K extends BaseCodec, V extends BaseCodec> extends BaseCodec {
  //  readonly registry: Registry;

  Registry registry;

  Constructor<K> _keyClass;

  Constructor<V> _valClass;

  String _type;

  // readonly #type: string;
  Map<K, V> get value => _value;

  Map<K, V> _value;

  // : 'BTreeMap' | 'HashMap'

  CodecMap(Registry registry, dynamic keyType, dynamic valType,
      [dynamic rawValue, String type = 'HashMap']) {
    _value = decodeMap(registry, keyType, valType, rawValue);

    this.registry = registry;
    this._keyClass = typeToConstructor(registry, (keyType));
    this._valClass = typeToConstructor(registry, (valType));
    this._type = type;
  }

  static CodecMap constructor(Registry registry,
          [dynamic keyType, dynamic valType, dynamic rawValue, String type = 'HashMap']) =>
      CodecMap(registry, keyType, valType, rawValue, type);
  // /**
  //  * @description The length of the value when encoded as a Uint8Array
  //  */
  int get encodedLength {
    var len = compactToU8a(this._value.length).length;

    this._value.forEach((k, v) {
      len += k.encodedLength + v.encodedLength;
    });

    return len;
  }

  // /**
  //  * @description Returns a hash of the value
  //  */
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  // /**
  //  * @description Checks if the value is an empty value
  //  */
  bool get isEmpty {
    return this._value.length == 0;
  }

  // /**
  //  * @description Compares the value of the input to see if there is a match
  //  */
  bool eq([dynamic other]) {
    return compareMap(this._value, other);
  }

  // /**
  //  * @description Returns a hex string representation of the value. isLe returns a LE (number-only) representation
  //  */
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  // /**
  //  * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  //  */
  Map<String, dynamic> toHuman([bool isExtended]) {
    Map<String, dynamic> json = {};

    this._value.forEach((k, v) {
      json[k.toString()] = v.toHuman(isExtended);
    });

    return json;
  }

  // /**
  //  * @description Converts the Object to JSON, typically used for RPC transfers
  //  */
  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> json = {};

    this._value.forEach((k, v) {
      json[k.toString()] = v.toJSON();
    });

    return json;
  }

  // /**
  //  * @description Returns the base runtime type name for this instance
  //  */
  String toRawType() {
    return "${this._type}<${this.registry.getClassName(this._keyClass) ?? this._keyClass(this.registry).toRawType()},${this.registry.getClassName(this._valClass) ?? this._valClass(this.registry).toRawType()}>";
  }

  // /**
  //  * @description Returns the string representation of the value
  //  */
  String toString() {
    return jsonEncode(this.toJSON());
  }

  // /**
  //  * @description Encodes the value as a Uint8Array as per the SCALE specifications
  //  * @param isBare true when the value has none of the type-specific prefixes (internal)
  //  */
  Uint8List toU8a([dynamic isBare]) {
    final encoded = List<Uint8List>();

    if (!isBare) {
      encoded.add(compactToU8a(this._value.length));
    }

    this._value.forEach((k, v) {
      encoded.add(k.toU8a(isBare));
      encoded.add(v.toU8a(isBare));
    });

    return u8aConcat([...encoded]);
  }
}
