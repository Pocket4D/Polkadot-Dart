import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/types.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/interfaces.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

Compact<T> Function(Registry, [dynamic]) _compactWith<T extends CompactEncodable>(dynamic type) {
  return (Registry registry, [dynamic value]) => Compact<T>(registry, type, value);
}

class Compact<T extends CompactEncodable> extends BaseCodec implements ICompact<T> {
  Registry registry;

  Constructor<T> _type;

  T _raw;

  T get value => _raw;

  dynamic originType;
  dynamic originValue;

  Compact(Registry registry, dynamic type, dynamic thisValue) {
    this.registry = registry;
    this.originType = type;
    this.originValue = thisValue;
    this._type = typeToConstructor(registry, type);
    this._raw = Compact.decodeCompact<T>(registry, this._type, thisValue) as T;
  }

  Compact.empty();

  Compact.from(T child, [Registry registry, String dataType]) {
    this.registry = registry;
    this.originType = dataType;
    this.originValue = child;
    // this._type = typeToConstructor(registry, dataType);
    this._raw = originValue as T;
  }

  static Compact constructor(Registry registry, [dynamic type, dynamic value]) =>
      Compact(registry, type, value);

  static Constructor<Compact<T>> withParams<T extends CompactEncodable>(dynamic type) =>
      _compactWith(type);

  // /** @internal */
  // value : Compact<T> | AnyNumber
  static CompactEncodable decodeCompact<T extends CompactEncodable>(
      Registry registry, Constructor<T> type, dynamic value) {
    if (value is Compact) {
      return type(registry, value._raw);
    } else if (isString(value) || isNumber(value) || isBn(value) || isBigInt(value)) {
      return type(registry, value);
    }

    final result = compactFromU8a(value, bitLength: type(registry, 0).bitLength);

    return type(registry, result[1]);
  }

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
    return this._raw.isEmpty;
  }

  /// @description Returns the number of bits in the value
  int get bitLength {
    return this._raw.bitLength;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return this._raw.eq(other is Compact ? other._raw : other);
  }

  /// @description Returns a BigInt representation of the number
  BigInt toBigInt() {
    return BigInt.parse(this.toString());
  }

  /// @description Returns the BN representation of the number
  BigInt toBn() {
    return this._raw.toBn();
  }

  /// @description Returns a hex string representation of the value. isLe returns a LE(number-only) representation
  String toHex([bool isLe]) {
    return this._raw.toHex(isLe is bool ? isLe : false);
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._raw.toHuman(isExtended);
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    return this._raw.toJSON();
  }

  /// @description Returns the number representation for the value
  int toInt() {
    return this._raw.toInt();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "Compact<${this.registry.getClassName(this._type) ?? this._raw.toRawType()}>";
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this._raw.toString();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return compactToU8a(this._raw.toBn());
  }

  /// @description Returns the embedded [[UInt]] or [[Moment]] value
  T unwrap() {
    return this._raw;
  }

  int toNumber() {
    return this._raw.toNumber();
  }
}
