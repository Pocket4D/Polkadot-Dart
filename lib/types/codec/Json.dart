import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

Iterable<MapEntry<String, dynamic>> decodeJson([Map<String, dynamic> value]) {
  return value.entries;
}

class Json extends BaseCodec {
  Registry registry;
  Map<String, dynamic> _value;

  Map<String, dynamic> get value => _value;
  Json(Registry registry, [Map<String, dynamic> value]) {
    _value = Map.fromEntries(decodeJson(value));
    this.registry = registry;
  }

  static Json constructor(Registry registry, [dynamic value]) =>
      Json(registry, value as Map<String, dynamic>);

  /// @description Always 0, never encodes as a Uint8Array
  int get encodedLength {
    return 0;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return [...this._value.keys].length == 0;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    return compareMap(this._value, other);
  }

  /// @description Unimplemented, will throw
  String toHex([bool isLe]) {
    throw UnimplementedError();
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  Map<String, dynamic> toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  Map<String, dynamic> toJSON() {
    return [...this._value.entries].fold({}, (json, entry) {
      json[entry.key] = entry.value;
      return json;
    });
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Json';
  }

  /// @description Returns the string representation of the value
  String toString() {
    return jsonEncode(this.toJSON());
  }

  /// @description Unimplemented, will throw
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    throw UnimplementedError();
  }
}
