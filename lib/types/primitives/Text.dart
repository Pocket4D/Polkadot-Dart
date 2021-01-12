import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const _MAX_LENGTH = 128 * 1024;

String decodeText([dynamic value]) {
  if (isHex(value)) {
    return u8aToString(hexToU8a(value.toString()), useDartEncode: true);
  } else if (value is Uint8List) {
    if (value.length == 0) {
      return '';
    }

    // for Raw, the internal buffer does not have an internal length
    // (the same applies in e.g. Bytes, where length is added at encoding-time)
    if (value is Raw) {
      return u8aToString(value, useDartEncode: true);
    }

    final compact = compactFromU8a(value);
    final offset = compact[0] as int;
    final length = compact[1] as BigInt;
    final total = offset + length.toInt();

    assert(
        length.toInt() <= (_MAX_LENGTH), "Text length ${length.toString()} exceeds $_MAX_LENGTH");
    assert(total <= value.length,
        "Text: required length less than remainder, expected at least $total, found ${value.length}");
    final result = u8aToString(value.sublist(offset, total), useDartEncode: true);
    return result;
  }

  return value != null ? value.toString() : '';
}

CodecText Function(Registry, [dynamic]) textWith(Registry registry, [dynamic value]) {
  return (Registry registry, [dynamic value]) => CodecText(registry, value);
}

class CodecText extends BaseCodec {
  Registry registry;

  String _override;
  String get value => _value;
  String _value;
  CodecText(Registry registry, [dynamic value]) {
    _value = (decodeText(value));

    this.registry = registry;
  }

  static CodecText constructor(Registry registry, [dynamic value]) => CodecText(registry, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.toU8a().length;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return this._value.length == 0;
  }

  /// @description The length of the value
  int get length {
    // only included here since we ignore inherited docs
    return this._value.length;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    var compare = other;
    if (other is CodecText) {
      compare = other.value;
    }
    return isString(compare) ? this._value.toString() == compare.toString() : false;
  }

  /// @description Set an override value for this
  void setOverride(String override) {
    this._override = override;
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    // like  with Vec<u8>, when we are encoding to hex, we don't actually add
    // the length prefix (it is already implied by the actual string length)
    return u8aToHex(this.toU8a(true));
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  String toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  String toJSON() {
    return this.toString();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Text';
  }

  /// @description Returns the string representation of the value
  @override
  String toString() {
    return this._override ?? this._value.toString();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes (internal)
  Uint8List toU8a([dynamic isBare]) {
    // NOTE Here we use the super toString (we are not taking overrides into account,
    // rather encoding the original value the string was constructed with)
    final encoded = stringToU8a(this._value.toString());
    return isBare is bool && isBare ? encoded : compactAddLength(encoded);
  }

  bool operator ==(Object other) {
    return eq(other);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => this.value.hashCode;
}
