import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

BaseCodec decodeOptionU8a(Registry registry, Constructor type, Uint8List value) {
  return value.length == 0 || value[0] == 0
      ? CodecNull(registry)
      : type(registry, value.sublist(1));
}

T decodeOption<T extends BaseCodec>(Registry registry, dynamic typeName, [dynamic value]) {
  if (isNull(value) || (value == null) || value is CodecNull) {
    return CodecNull(registry) as T;
  }

  final type = typeToConstructor(registry, typeName);

  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  if (value is Option) {
    return decodeOption(registry, type, value.value);
  } else if (value is T) {
    // don't re-create, use as it (which also caters for derived types)
    return value;
  } else if (isU8a(value)) {
    // the isU8a check happens last in the if-tree - since the wrapped value
    // may be an instance of it, so Type and Option checks go in first
    return decodeOptionU8a(registry, type, value);
  }
  return type(registry, value);
}

Option<T> Function(Registry, Uint8List) optionWith<T extends BaseCodec>(dynamic typeName) {
  return (Registry registry, [dynamic value]) => Option<T>(registry, typeName, value);
}

class Option<T extends BaseCodec> extends BaseCodec {
  Registry registry;

  Constructor<T> _type;

  T _raw;

  dynamic originTypeName;
  dynamic originValue;

  Option(Registry registry, dynamic typeName, [dynamic value]) {
    this.registry = registry;
    this.originTypeName = typeName;
    this.originValue = value;
    this._type = typeToConstructor(registry, typeName);
    this._raw = decodeOption(registry, typeName, value) as T;
  }

  Option.from(T val, [Registry registry, dynamic typeName]) {
    this._raw = val;
    this.registry = registry;
    this.originTypeName = typeName;
    this.originValue = val;
    // this._type = typeToConstructor(registry, typeName);
  }

  static Constructor<Option<O>> withParams<O extends BaseCodec>(dynamic type) => optionWith(type);
  static Option<T> constructor<T extends BaseCodec>(Registry registry,
          [dynamic typeName, dynamic value]) =>
      Option<T>(registry, typeName, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    // boolean byte(has value, doesn't have) along with wrapped length
    return 1 + this._raw.encodedLength;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the Option has no value
  bool get isEmpty {
    return this.isNone;
  }

  /// @description Checks if the Option has no value
  bool get isNone {
    return this._raw is CodecNull || this._raw == null;
  }

  /// @description Checks if the Option has a value
  bool get isSome {
    return !this.isNone;
  }

  /// @description The actual value for the Option
  BaseCodec get value {
    return this._raw;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    if (other is Option) {
      return (this.isSome == other.isSome) && this.value.eq(other.value);
    }

    return this.value.eq(other);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    // This attempts to align with the JSON encoding - actually in this case
    // the isSome value is correct, however the `isNone` may be problematic
    return this.isNone ? '0x' : u8aToHex(this.toU8a().sublist(1));
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._raw.toHuman(isExtended);
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    return this._raw.toJSON();
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType([dynamic isBare]) {
    final wrapped = this.registry.getClassName(this._type) ?? this._type(this.registry).toRawType();

    return isBare ? wrapped : "Option<$wrapped>";
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this._raw.toString();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    if (isBare is bool && isBare == true) {
      return this._raw.toU8a(true);
    }

    final u8a = Uint8List(this.encodedLength);

    if (this.isSome) {
      u8a.setAll(0, [1]);
      u8a.setAll(1, this._raw.toU8a());
    }

    return u8a;
  }

  /// @description Returns the value that the Option represents(if available), throws if null
  T unwrap() {
    assert(this.isSome, 'Option: unwrapping a None value');
    return this._raw;
  }

  /// @description Returns the value that the Option represents(if available) or defaultValue if none
  /// @param defaultValue The value to return if the option isNone
  dynamic unwrapOr<O>(O defaultValue) {
    return this.isSome ? this.unwrap() : defaultValue;
  }

  /// @description Returns the value that the Option represents(if available) or defaultValue if none
  /// @param defaultValue The value to return if the option isNone
  T unwrapOrDefault() {
    return this.isSome ? this.unwrap() : this._type(this.registry);
  }
}
