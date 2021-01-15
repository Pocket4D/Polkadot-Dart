import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const BITLENGTH = 64;

class CodecDate extends BaseCodec implements CompactEncodable {
  Registry registry;
  DateTime _value;
  DateTime get value => _value;
  CodecDate.empty();
  CodecDate(Registry registry, dynamic value) {
    this._value = CodecDate.decodeDate(value);
    this.registry = registry;
  }
  static CodecDate constructor(Registry registry, [dynamic value]) => CodecDate(registry, value);

  static DateTime decodeDate(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (isU8a(value)) {
      value = u8aToBn(value.subarray(0, BITLENGTH / 8), endian: Endian.little);
    } else if (isString(value)) {
      value = value.toString().toU8a().toBn();
    } else if (value is CodecDate) {
      return value.value;
    } else if (value is BaseCodec) {
      value = value.value;
    }

    return DateTime.fromMillisecondsSinceEpoch(bnToBn(value).toInt() * 1000);
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return (BITLENGTH / 8).ceil();
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return this._value.microsecond == 0;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return CodecDate.decodeDate(other).millisecondsSinceEpoch == this._value.millisecondsSinceEpoch;
  }

  /// @description Returns the number of bits in the value
  int get bitLength {
    return BITLENGTH;
  }

  int getTime() {
    return this._value.millisecondsSinceEpoch;
  }

  int get secondsSinceEpoch {
    return (this._value.millisecondsSinceEpoch / 1000).ceil();
  }

  /// @description Returns a BigInt representation of the number
  BigInt toBigInt() {
    return BigInt.from(this.secondsSinceEpoch);
  }

  /// @description Returns the BN representation of the timestamp
  BigInt toBn() {
    return BigInt.from(this.secondsSinceEpoch);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe = false]) {
    return bnToHex(this.toBn(),
        bitLength: BITLENGTH, endian: isLe ? Endian.little : Endian.big, isNegative: false);
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._value.toIso8601String();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    // FIXME Return type should be number, but conflicts with Date.toJSON()
    // which returns string
    return this.secondsSinceEpoch;
  }

  /// @description Returns the number representation for the timestamp
  int toNumber() {
    return this.secondsSinceEpoch;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Moment'; // DateTime
  }

  /// @description Returns the string representation of the value
  String toString() {
    // only included here since we do not inherit docs
    return this._value.toString();
  }

  String toISOString() {
    return this._value.toUtc().toIso8601String();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return bnToU8a(BigInt.from(this.toNumber()), bitLength: BITLENGTH, endian: Endian.little);
  }

  @override
  int toInt() {
    // TODO: implement toInt
    return this.toNumber();
  }
}
