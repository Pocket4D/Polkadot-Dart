import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

Uint8List decodeBitVecU8a([Uint8List value]) {
  if (value == null || value.length == 0) {
    return Uint8List(0);
  }

  // handle all other Uint8List inputs, these do have a length prefix which is the number of bits encoded
  final compact = compactFromU8a(value);
  final offset = compact[0] as int;
  final length = compact[1] as BigInt;
  final total = offset + (length.toInt() / 8).ceil();

  assert(total <= value.length,
      "BitVec: required length less than remainder, expected at least $total, found ${value.length}");

  return value.sublist(offset, total);
}

/// @internal */
Uint8List decodeBitVec([dynamic value]) {
  if ((value is List) || isString(value)) {
    return u8aToU8a(value);
  }

  return decodeBitVecU8a(value);
}

class BitVec extends Raw {
  BitVec.empty() : super.empty();
  BitVec(Registry registry, [dynamic value]) : super(registry, decodeBitVec(value));

  static BitVec constructor(Registry registry, [dynamic value]) => BitVec(registry, value);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.length + compactToU8a(this.bitLength).length;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'BitVec';
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    final bitVec = super.toU8a();

    return isBare is bool && isBare ? bitVec : u8aConcat([compactToU8a(this.bitLength), bitVec]);
  }
}
