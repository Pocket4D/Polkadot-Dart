import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const DEFAULT_UINT_BITS = 64;

// ignore: non_constant_identifier_names
final MUL_P = BigInt.from(10000);

// ignore: non_constant_identifier_names
final FORMATTERS = [
  ['Perquintill', BigInt.from(1000000000000)],
  ['Perbill', BigInt.from(1000000000)],
  ['Permill', BigInt.from(1000000)],
  ['Percent', BigInt.from(100)]
];

String toPercentage(BigInt value, BigInt divisor) {
  final result = (((value * MUL_P) ~/ (divisor)).toInt() / 100).toStringAsFixed(2);
  return "$result%";
}

BigInt decodeAbstracIntU8a(Uint8List value, int bitLength, bool isNegative) {
  if (value.length == 0) {
    return BigInt.from(0);
  }

  final subLength = value.length <= (bitLength / 8).ceil() ? value.length : (bitLength / 8).ceil();
  try {
    // NOTE When passing u8a in(typically from decoded data), it is always Little Endian
    return u8aToBn(value.sublist(0, subLength), endian: Endian.little, isNegative: isNegative);
  } catch (error) {
    throw "AbstractInt: failed on ${jsonEncode(value)}:: $error";
  }
}

BigInt decodeAbstractInt(dynamic value, int bitLength, bool isNegative) {
  // This function returns a string, which will be passed in the BN
  // constructor. It would be ideal to actually return a BN, but there's a
  // bug: https://github.com/indutny/bn.js/issues/206.
  if (isHex(value, -1, true)) {
    return hexToBn(value, endian: Endian.big, isNegative: isNegative);
  } else if (isU8a(value)) {
    return decodeAbstracIntU8a((value), bitLength, isNegative);
  } else if (isString(value)) {
    return BigInt.parse(value.toString(), radix: 10);
  }

  return bnToBn(value is BaseCodec ? value.value : value);
}

abstract class AbstractInt implements BaseCodec, CompactEncodable {
  Registry registry;
  BigInt _value;

  int _bitLength;

  bool _isSigned;

  BigInt get value => _value;

  dynamic originValue;
  AbstractInt();
  AbstractInt.withReg(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, bool isSigned = false]) {
    originValue = value;
    this._value = (decodeAbstractInt(value, bitLength, isSigned));
    this.registry = registry;
    this._bitLength = bitLength;
    this._isSigned = isSigned;
    assert(isSigned || this._value >= (BigInt.zero),
        "${this.toRawType()}: Negative number passed to unsigned type");
    assert(this._value.bitLength <= bitLength,
        "${this.toRawType()}: Input too large. Found input with ${this._value.bitLength} bits, expected $bitLength");
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return (this._bitLength / 8).ceil();
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is a zero value (align elsewhere)
  bool get isEmpty {
    return this._value == BigInt.zero;
  }

  /// @description Checks if the value is an unsigned type
  bool get isUnsigned {
    return !this._isSigned;
  }

  /// @description Returns the number of bits in the value
  int get bitLength {
    return this._bitLength;
  }

  /// @description Compares the value of the input to see if there is a match
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  bool eq(dynamic other) {
    // Here we are actually overriding the built-in .eq to take care of both
    // number and BN inputs (no `.eqn` needed) - numbers will be converted
    var otherBn = isHex(other)
        ? hexToBn(other.toString(), endian: Endian.big, isNegative: this._isSigned)
        : other is AbstractInt
            ? other.value
            : bnToBn(other);
    return this._value == otherBn;
  }

  /// @description True if this value is the max of the type
  bool isMax() {
    final u8a = this._value.toU8a().takeWhile((byte) => byte == 0xff);

    return u8a.length == (this._bitLength / 8);
  }

  /// @description Returns a BigInt representation of the number
  BigInt toBigInt() {
    return BigInt.parse(this.toString());
  }

  /// @description Returns the BN representation of the number.(Compatibility)
  BigInt toBn() {
    return this._value;
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe = false]) {
    // For display/JSON, this is BE, for compare, use isLe

    return bnToHex(this._value,
        bitLength: this.bitLength,
        endian: isLe ? Endian.little : Endian.big,
        isNegative: !this.isUnsigned);
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  dynamic toHuman([bool isExpanded]) {
    final rawType = this.toRawType();
    if (rawType == 'Balance') {
      return this.isMax()
          ? 'everything'
          : BalanceFormatter.instance.formatBalance(
              this._value,
              BalanceFormatterOptions(
                  decimals: this.registry.chainDecimals,
                  withSi: true,
                  withUnit: this.registry.chainToken));
    }

    final formats =
        FORMATTERS.firstWhere((value) => (value[0] as String) == rawType, orElse: () => []);
    return formats.length > 1 && formats[1] != null
        ? toPercentage(this._value, formats[1] as BigInt)
        : formatNumber(this._value);
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  toJSON() {
    // FIXME this return type should by string | number, but BN's return type
    // is string.
    // Maximum allowed integer for JS is 2^53 - 1, set limit at 52
    return this._value.bitLength > 52 ? this.toHex() : this._value.toInt();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    // NOTE In the case of balances, which have a special meaning on the UI
    // and can be interpreted differently, return a specific value for it so
    // underlying it always matches(no matter which length it actually is)
    // this is Balance ? "Balance" :
    return "${this.isUnsigned ? 'u' : 'i'}${this.bitLength}";
  }

  /// @description Returns the string representation of the value
  /// @param base The base to use for the conversion
  String toString([int base = 10]) {
    // only included here since we do not inherit docs
    return this._value.toRadixString(base);
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return bnToU8a(this._value,
        bitLength: this.bitLength, endian: Endian.little, isNegative: !this.isUnsigned);
  }

  @override
  int toInt() {
    // TODO: implement toInt
    return this._value.toInt();
  }

  @override
  int toNumber() {
    // TODO: implement toNumber
    return this.toInt();
  }
}
