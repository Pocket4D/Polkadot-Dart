import 'dart:typed_data';

import 'package:polkadot_dart/types/generic/generic.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

// ignore: non_constant_identifier_names
final ACCOUNT_ID_PREFIX = Uint8List.fromList([0xff]);

// GenericAccountId | GenericAccountIndex
dynamic _decodeString(Registry registry, String value) {
  final decoded = decodeAddress(value);

  return decoded.length == 32
      ? registry.createType('AccountId', decoded).cast<GenericAccountId>()
      : registry
          .createType('AccountIndex', u8aToBn(decoded, endian: Endian.little))
          .cast<GenericAccountIndex>();
}

// GenericAccountId | GenericAccountIndex
dynamic _decodeU8a(Registry registry, Uint8List value) {
  // This allows us to instantiate an address with a raw publicKey. Do this first before
  // we checking the first byte, otherwise we may split an already-existent valid address

  if (value.length == 32) {
    return registry.createType('AccountId', value).cast<GenericAccountId>();
  } else if (value.length > 0 && value[0] == 0xff) {
    return registry.createType('AccountId', value.sublist(1)).cast<GenericAccountId>();
  }

  final list = GenericAccountIndex.readLength(value);

  final offset = list[0];
  final length = list[1];
  return registry
      .createType(
          'AccountIndex', u8aToBn(value.sublist(offset, offset + length), endian: Endian.little))
      .cast<GenericAccountIndex>();
}

/// @name LookupSource
/// @description
/// A wrapper around an AccountId and/or AccountIndex that is encoded with a prefix.
/// Since we are dealing with underlying publicKeys(or shorter encoded addresses),
/// we extend from Base with an AccountId/AccountIndex wrapper. Basically the Address
/// is encoded as `[ <prefix-byte>, ...publicKey/...bytes ]` as per spec
class GenericLookupSource extends Base {
  GenericLookupSource(Registry registry, [dynamic value])
      : super(registry,
            GenericLookupSource._decodeAddress(registry, value ?? Uint8List.fromList([0])));

  static GenericLookupSource constructor(Registry registry, [dynamic value]) =>
      GenericLookupSource(registry, value);

  // : GenericAccountId | GenericAccountIndex
  static _decodeAddress(Registry registry, dynamic value) {
    return value is GenericLookupSource
        ? value.raw
        : value is GenericAccountId || value is GenericAccountIndex
            ? value
            : isBn(value) || isNumber(value) || isBigInt(value)
                ? registry.createType('AccountIndex', value)
                : (value is List) || isHex(value) || isU8a(value)
                    ? _decodeU8a(registry, u8aToU8a(value))
                    : _decodeString(registry, value);
  }

  // /**
  //  * @description The length of the value when encoded as a Uint8Array
  //  */
  int get encodedLength {
    final rawLength = this._rawLength;

    return rawLength +
        (
            // for 1 byte AccountIndexes, we are not adding a specific prefix
            rawLength > 1 ? 1 : 0);
  }

  /// @description The length of the raw value, either AccountIndex or AccountId
  int get _rawLength {
    return this.raw is GenericAccountIndex
        ? GenericAccountIndex.calcLength(this.raw)
        : this.raw.encodedLength;
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Address';
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    final encoded = this.raw.toU8a().sublist(0, this._rawLength);

    return isBare is bool && isBare == true
        ? encoded
        : u8aConcat([
            this.raw is GenericAccountIndex
                ? GenericAccountIndex.writeLength(encoded)
                : ACCOUNT_ID_PREFIX,
            encoded
          ]);
  }

  @override
  get value => this.raw;
}
