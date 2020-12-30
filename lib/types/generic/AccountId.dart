import 'dart:typed_data';

import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

Uint8List _decodeAccountId(dynamic value) {
  if (value == null) {
    return Uint8List.fromList([]);
  } else if (isU8a(value) || value is List<int>) {
    return u8aToU8a(value);
  } else if (isHex(value)) {
    return hexToU8a(value.toString());
  } else if (isString(value)) {
    return decodeAddress((value).toString());
  } else if (value is GenericAccountId || value is Raw) {
    return _decodeAccountId(value.value);
  }

  throw ('Unknown type passed to AccountId constructor');
}

class GenericAccountId extends U8aFixed {
  GenericAccountId(Registry registry, [dynamic value])
      : super(registry, _decodeAccountId(value), 256) {
    final decoded = _decodeAccountId(value);

    assert(decoded.length >= 32 || !decoded.any((b) => b != null && b != 0),
        "Invalid AccountId provided, expected 32 bytes, found ${decoded.length}");
  }

  factory GenericAccountId.from(U8aFixed origin) {
    return GenericAccountId(origin.registry, origin.value);
  }

  static T constructor<T extends GenericAccountId>(Registry registry, [dynamic value]) {
    return GenericAccountId(registry, value) as T;
  }

  static encode(Uint8List value, [int ss58Format]) {
    return encodeAddress(value, ss58Format);
  }

  /// @description Compares the value of the input to see if there is a match
  eq([dynamic other]) {
    return super.eq(_decodeAccountId(other));
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  String toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  String toJSON() {
    return this.toString();
  }

  /// @description Returns the string representation of the value
  String toString() {
    if (this.registry.chainSS58 == null) {
      return GenericAccountId.encode(this.value);
    } else {
      return GenericAccountId.encode(this.value, this.registry.chainSS58);
    }
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'AccountId';
  }
}
