// type SetValues = Record<string, dynamicber | BN>;

import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

BigInt encodeSet(Map<String, dynamic> setValues, List<String> value) {
  return value.fold(
    BigInt.from(0),
    (result, value) {
      return result | (bnToBn(setValues[value] ?? 0));
    },
  );
}

List<String> decodeSetArray(Map<String, dynamic> setValues, List<String> value) {
  return value.fold([], (result, key) {
    assert((setValues[key] != null),
        "Set: Invalid key '$key' passed to Set, allowed ${(setValues.keys.toList()).join(', ')}");

    result.add(key);

    return result;
  });
}

List<String> decodeSetNumber(Map<String, dynamic> setValues, dynamic _value) {
  final bn = bnToBn(_value);
  final result = (setValues.keys.toList()).fold([], (arr, key) {
    if ((bn & (bnToBn(setValues[key]))) == (bnToBn(setValues[key]))) {
      arr.add(key);
    }
    return arr;
  });

  final computed = encodeSet(setValues, List<String>.from(result));

  assert(bn == (computed),
      "Set: Mismatch decoding '${bn.toString()}', computed as '${computed.toString()}' with ${result.join(', ')}");

  return List<String>.from(result);
}

List<String> decodeSet(Map<String, dynamic> setValues, dynamic value, int bitLength) {
  assert(bitLength % 8 == 0, "Expected valid bitLength, power of 8, found $bitLength");
  if (value == null) {
    value = 0;
  }
  final byteLength = (bitLength / 8).ceil();

  if (isString(value)) {
    return decodeSet(setValues, u8aToU8a(value), byteLength);
  } else if (value is Uint8List) {
    return value.length == 0
        ? []
        : decodeSetNumber(setValues, u8aToBn(value.sublist(0, byteLength), endian: Endian.little));
  } else if (value is Set || (value is List)) {
    final input = (value is List) ? List<String>.from(value) : [...value.values()];

    return decodeSetArray(setValues, input);
  }

  return decodeSetNumber(setValues, value);
}

CodecSet Function(Registry, dynamic) codecSetWith(Map<String, dynamic> setValues,
    [int bitLength = 8]) {
  return (Registry registry, [dynamic value]) =>
      CodecSet(registry, setValues, value, bitLength ?? 8);
}

class CodecSet extends BaseCodec {
  Registry registry;

  Map<String, dynamic> _allowed;

  int _byteLength;

  Set<String> _value;

  Set<String> get value => _value;
  List<String> iskeys = [];
  List<String> askeys = [];
  Map<String, dynamic> originSetValues;
  dynamic originValue;
  int originBitLength;

  CodecSet(Registry registry, Map<String, dynamic> setValues, [dynamic value, int bitLength = 8]) {
    originSetValues = setValues;
    originValue = value;
    originBitLength = bitLength;
    this._value = (decodeSet(setValues, value, bitLength)).toSet();
    this.registry = registry;
    this._allowed = setValues;
    this._byteLength = (bitLength / 8).ceil();
    _genKeys();
  }
  CodecSet.empty();
  static Constructor<CodecSet> withParams(Map<String, dynamic> setValues, [int bitLength]) =>
      codecSetWith(setValues, bitLength);

  static CodecSet constructor(Registry registry,
          [dynamic setValues, dynamic value, int bitLength = 8]) =>
      CodecSet(registry, setValues as Map<String, dynamic>, value, bitLength);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this._byteLength;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description true is the Set contains no values
  bool get isEmpty {
    return this._value.length == 0;
  }

  /// @description The actual set values as a string[]
  List<String> get strings {
    return [...this._value.toList()];
  }

  /// @description The encoded value for the set members
  BigInt get valueEncoded {
    return encodeSet(this._allowed, this.strings);
  }

  /// @description adds a value to the Set (extended to allow for validity checking)
  add(String key) {
    // ^^^ add = () property done to assign this instance's this, otherwise Set.add creates "some" chaos
    // we have the isUndefined(this._setValues) in here as well, add is used internally
    // in the Set constructor (so it is undefined at this point, and should allow)
    assert(
        (this._allowed == null) || (this._allowed[key] != null), "Set: Invalid key '$key' on add");

    this._value.add(key);

    return this;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    if ((other is List)) {
      // we don't actually care about the order, sort the values
      var sorted = this.strings;
      sorted.sort((a, b) => a.length.compareTo(b.length));
      other.sort((a, b) => a.length.compareTo(b.length));
      return compareArray(sorted, other);
      // return compareList(this.strings, other);
    } else if (other is Set) {
      return this.eq([...other]);
    } else if (isNumber(other) || isBn(other)) {
      return this.valueEncoded == (bnToBn(other));
    } else if (other is CodecSet) {
      return this.eq(other.value);
    }

    return false;
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  List<String> toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  List<String> toJSON() {
    return this.strings;
  }

  /// @description The encoded value for the set members
  int toNumber() {
    return this.valueEncoded.toInt();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return jsonEncode({"_set": this._allowed});
  }

  /// @description Returns the string representation of the value
  String toString() {
    return "[${this.strings.join(', ')}]";
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return bnToU8a(this.valueEncoded, bitLength: this._byteLength * 8, endian: Endian.little);
  }

  bool isKey(String name) {
    return iskeys.any((element) => this.strings.contains(element));
  }

  _genKeys() {
    this._allowed.keys.toList().forEach((_key) {
      final name = stringUpperFirst(stringCamelCase(_key));
      final iskey = "is$name";
      iskeys.add(iskey);
    });
  }
}
