// ignore: non_constant_identifier_names
import 'dart:typed_data';

import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

// ignore: non_constant_identifier_names
final ENUMSET_SIZE = BigInt.from(64);

const PREFIX_1BYTE = 0xef;
const PREFIX_2BYTE = 0xfc;
const PREFIX_4BYTE = 0xfd;
const PREFIX_8BYTE = 0xfe;
// ignore: non_constant_identifier_names
final MAX_1BYTE = BigInt.from(PREFIX_1BYTE);
// ignore: non_constant_identifier_names
final MAX_2BYTE = BigInt.from(1) << (16);
// ignore: non_constant_identifier_names
final MAX_4BYTE = BigInt.from(1) << (32);

dynamic decodeAccountIndex(dynamic value) {
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  if (value is GenericAccountIndex) {
    // `value.toBn()` on AccountIndex returns a pure BN(i.e. not an
    // AccountIndex), which has the initial `toString()` implementation.
    return value.toBn();
  } else if (isBn(value) || isNumber(value) || isHex(value) || isU8a(value) || isBigInt(value)) {
    return value;
  }

  return decodeAccountIndex(decodeAddress(value));
}

class GenericAccountIndex extends u32 {
  GenericAccountIndex.empty() : super.empty();
  GenericAccountIndex(Registry registry, [dynamic value])
      : super(registry, decodeAccountIndex(value ?? BigInt.from(0)));

  factory GenericAccountIndex.from(u32 origin) {
    return GenericAccountIndex(origin.registry, origin.value);
  }
  static T constructor<T extends GenericAccountIndex>(Registry registry, [dynamic value]) {
    return GenericAccountIndex(registry, value) as T;
  }

  static int calcLength(dynamic _value) {
    final value = bnToBn(_value);

    if (value <= (MAX_1BYTE)) {
      return 1;
    } else if (value < (MAX_2BYTE)) {
      return 2;
    } else if (value < (MAX_4BYTE)) {
      return 4;
    }

    return 8;
  }

  static List<int> readLength(Uint8List input) {
    if (input.isEmpty) {
      input = Uint8List.fromList([0]);
    }
    final first = input[0];

    if (first == PREFIX_2BYTE) {
      return [1, 2];
    } else if (first == PREFIX_4BYTE) {
      return [1, 4];
    } else if (first == PREFIX_8BYTE) {
      return [1, 8];
    }

    return [0, 1];
  }

  static Uint8List writeLength(Uint8List input) {
    switch (input.length) {
      case 2:
        return Uint8List.fromList([PREFIX_2BYTE]);
      case 4:
        return Uint8List.fromList([PREFIX_4BYTE]);
      case 8:
        return Uint8List.fromList([PREFIX_8BYTE]);
      default:
        return Uint8List.fromList([]);
    }
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq(dynamic other) {
    // shortcut for BN or Number, don't create an object
    if (isBn(other) || isNumber(other)) {
      return super.eq(other);
    }
    // convert and compare
    return super.eq(this.registry.createType('AccountIndex', other));
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  String toHuman([dynamic isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  String toJSON() {
    return this.toString();
  }

  /// @description Returns the string representation of the value
  String toString([int base = 10]) {
    final length = GenericAccountIndex.calcLength(this.value);

    return encodeAddress(this.toU8a().sublist(0, length), this.registry.chainSS58);
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'AccountIndex';
  }
}
