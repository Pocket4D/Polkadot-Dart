import 'dart:typed_data';
import 'dart:math';

import 'package:polkadot_dart/types/codec/Enum.dart';
import 'package:polkadot_dart/types/codec/Raw.dart';
// import 'package:polkadot_dart/types/interfaces/runtime/typesbak.dart';
import 'package:polkadot_dart/types/primitives/Bytes.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

/// @internal */
List<dynamic> _decodeDataU8a(Registry registry, Uint8List value) {
  if (value.isEmpty) value = Uint8List.fromList([0]);

  final indicator = value[0];

  if (indicator == 0) {
    return [null, null];
  } else if (indicator >= 1 && indicator <= 33) {
    final length = indicator - 1;
    final data = value.sublist(1, length + 1);

    // in this case, we are passing a Raw back (since we have no length)
    return [registry.createType<Raw>('Raw', data), 1];
  } else if (indicator >= 34 && indicator <= 37) {
    return [value.sublist(1, 32 + 1), indicator - 32]; // 34 becomes 2
  }

  throw "Unable to decode Data, invalid indicator byte $indicator";
}

/// @internal */
List<dynamic> _decodeData(Registry registry, [dynamic value]) {
  if (value == null) {
    return [null, null];
  } else if (isU8a(value) || isString(value)) {
    return _decodeDataU8a(registry, u8aToU8a(value));
  }

  // assume we have an Enum or an  object input, handle this via the normal Enum decoding
  return [value, null];
}

class Data extends Enum {
  Data(Registry registry, [dynamic value])
      : super(
            registry,
            {
              "None": 'Null', // 0
              "Raw": 'Bytes', // 1
              // eslint-disable-next-line sort-keys
              "BlakeTwo256": 'H256', // 2
              "Sha256": 'H256', // 3
              // eslint-disable-next-line sort-keys
              "Keccak256": 'H256', // 4
              "ShaThree256": 'H256' // 5
            },
            _decodeData(registry, value)[0],
            _decodeData(registry, value)[1]);

  static Data constructor(Registry registry, [dynamic value]) => Data(registry, value);

  Bytes get asRaw {
    return this.value as Bytes;
  }

  // H256 get asSha256 {
  //   return this.value as H256;
  // }

  bool get isRaw {
    return this.index == 1;
  }

  bool get isSha256 {
    return this.index == 3;
  }

  /// @description The encoded length
  int get encodedLength {
    return this.toU8a().length;
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  Uint8List toU8a([dynamic isBare]) {
    if (this.index == 0) {
      return Uint8List(1);
    } else if (this.index == 1) {
      // don't add the length, just the data
      final data = this.value.toU8a(true);

      final length = min(data.length, 32);
      final u8a = Uint8List(length + 1);

      u8a.setAll(0, [data.length + 1]);
      u8a.setAll(1, data.sublist(0, length));

      return u8a;
    }

    // otherwise we simply have a hash
    final u8a = Uint8List(33);

    u8a.setAll(0, [this.index + 32]);
    u8a.setAll(1, this.value.toU8a());

    return u8a;
  }
}
