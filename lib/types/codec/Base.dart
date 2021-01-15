import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

abstract class Base<T extends BaseCodec> extends BaseCodec {
  Registry registry;

  T _raw;

  T get raw => this._raw;
  Base.empty();
  Base(Registry registry, T value) {
    this.registry = registry;
    this._raw = value;
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

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return this._raw.eq(other);
  }

  /// @description Returns a hex string representation of the value. isLe returns a LE(number-only) representation
  String toHex([bool isLe]) {
    return this._raw.toHex(isLe);
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._raw.toHuman(isExtended);
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    return this._raw.toJSON();
  }

  /// @description Returns the string representation of the value
  String toString() {
    return this._raw.toString();
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    return this._raw.toU8a(isBare);
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Base';
  }
}
