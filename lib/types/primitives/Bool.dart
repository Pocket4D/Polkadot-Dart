import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

bool _decodeBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (isU8a(value)) {
    return value.length > 0 ? value[0] == 1 : false;
  } else if (value is CodecBool) {
    return value.value;
  } else if (value is num) {
    return value.toInt() == 1;
  }
  return false;
}

class CodecBool extends BaseCodec {
  Registry registry;
  bool _value;
  bool get value => _value;
  // eslint-disable-next-line @typescript-eslint/ban-types
  CodecBool.empty();
  CodecBool(Registry registry, [dynamic value = false]) {
    _value = _decodeBool(value);
    this.registry = registry;
  }

  static CodecBool constructor(Registry registry, [dynamic value = false]) =>
      CodecBool(registry, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return 1;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value(true when it wraps false/default)
  bool get isEmpty {
    return this.isFalse || this._value == null;
  }

  /// @description Checks if the value is an empty value(always false)
  bool get isFalse {
    return this._value == false;
  }

  /// @description Checks if the value is an empty value(always false)
  bool get isTrue {
    return this._value == true;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return other is CodecBool ? this._value == other.value : this._value == other;
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  bool toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  bool toJSON() {
    return this._value;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'bool';
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this.toJSON().toString();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return Uint8List.fromList([this._value ? 1 : 0]);
  }
}
