import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

// ignore: non_constant_identifier_names
final _MAX_LENGTH = 10 * 1024 * 1024;

Uint8List _decodeBytesU8a(Uint8List value) {
  if (value.length == 0) {
    return Uint8List(0);
  }

  // handle all other Uint8List inputs, these do have a length prefix
  final compact = compactFromU8a(value);
  final offset = compact[0] as int;
  final length = compact[1] as BigInt;
  final total = offset + length.toInt();

  assert(length.toInt() <= (_MAX_LENGTH), "Bytes length ${length.toString()} exceeds $_MAX_LENGTH");
  assert(total <= value.length,
      "Bytes: required length less than remainder, expected at least $total, found ${value.length}");

  return value.sublist(offset, total);
}

// /** @internal */
dynamic _decodeBytes([dynamic value]) {
  if ((value is List && !isU8a(value)) || isString(value)) {
    return u8aToU8a(value);
  } else if (!(value is Raw) && isU8a(value)) {
    // We are ensuring we are not a Raw instance. In the case of a Raw we already have gotten
    // rid of the length, i.e. new Bytes(new Bytes(...)) will work as expected
    return _decodeBytesU8a(value);
  }
  return value;
}

class Bytes extends Raw {
  Bytes(Registry registry, [dynamic value]) : super(registry, _decodeBytes(value));

  static Bytes constructor(Registry registry, [dynamic value]) => Bytes(registry, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.length + compactToU8a(this.length).length;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Bytes';
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    return (isBare is bool && isBare) ? super.toU8a(isBare) : compactAddLength(this.value);
  }
}
