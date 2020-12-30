import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/interfaces.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart' as utils;

Uint8List _decodeU8a([dynamic value]) {
  if (utils.isU8a(value)) {
    return value;
  } else if (value is Raw) {
    return value.value;
  }

  return utils.u8aToU8a(value);
}

class Raw extends BaseCodec implements IU8a {
  Registry registry;
  Uint8List _value;
  Uint8List get value => _value;
  dynamic originValue;

  Raw(Registry registry, [dynamic value]) {
    originValue = value;
    _value = _decodeU8a(value);
    this.registry = registry;
  }

  static Raw constructor(Registry registry, [dynamic value]) => Raw(registry, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this._value.length;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Returns true if the wrapped value contains only ASCII printable characters
  get isAscii {
    return utils.isAscii(this._value);
  }

  /// @description Returns true if the type wraps an empty/default all-0 value
  get isEmpty {
    return this._value.length == 0 ||
        this._value.isEmpty ||
        this._value.every((element) => element == 0);
  }

  /// @description Returns true if the wrapped value contains only utf8 characters
  get isUtf8 {
    return utils.isUtf8(this._value);
  }

  /// @description The length of the value
  get length {
    // only included here since we ignore inherited docs
    return this._value.length;
  }

  /// @description Returns the number of bits in the value
  get bitLength {
    return this._value.length * 8;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq([dynamic other]) {
    if (other is Uint8List) {
      return utils.u8aEq(this._value, other);
    }
    return this.eq(_decodeU8a(other));
  }

  /// @description Create a new slice from the actual buffer. (compat)
  /// @param start The position to start at
  /// @param end The position to end at
  Uint8List slice([int start, int end]) {
    // Like subarray below, we have to follow this approach since we are extending the TypeArray.
    // This happens especially when it comes to further extensions, the length may be an override
    return Uint8List.fromList(this._value).sublist(start, end);
  }

  /// @description Create a new subarray from the actual buffer. (compat)
  /// @param begin The position to start at
  /// @param end The position to end at
  Uint8List subarray([int begin, int end]) {
    return this.slice(begin, end);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return utils.u8aToHex(this._value);
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this.isAscii ? this.toUtf8() : this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  String toJSON() {
    return this.toHex();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Raw';
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this.toHex();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes (internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return Uint8List.fromList(this._value);
  }

  /// @description Returns the wrapped data as a UTF-8 string
  String toUtf8() {
    assert(this.isUtf8, 'The character sequence is not a valid Utf8 string');
    return utils.u8aToString(this._value, useDartEncode: true);
  }
}
