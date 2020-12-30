import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

final DEFAULT_FN = (dynamic data) => xxhashAsU8a(data, bitLength: 128);

typedef HasherFunction = Uint8List Function(dynamic data);

final HASHERS = {
  "Blake2_128": (dynamic data) => // eslint-disable-line camelcase
      blake2AsU8a(data, bitLength: 128),
  "Blake2_128Concat": (dynamic data) => // eslint-disable-line camelcase
      u8aConcat([blake2AsU8a(data, bitLength: 128), u8aToU8a(data)]),
  "Blake2_256": (dynamic data) => // eslint-disable-line camelcase
      blake2AsU8a(data, bitLength: 256),
  "Identity": (dynamic data) => u8aToU8a(data),
  "Twox128": (dynamic data) => xxhashAsU8a(data, bitLength: 128),
  "Twox256": (dynamic data) => xxhashAsU8a(data, bitLength: 256),
  "Twox64Concat": (dynamic data) => u8aConcat([xxhashAsU8a(data, bitLength: 64), u8aToU8a(data)])
};

HasherFunction getHasher([StorageHasher hasher]) {
  return HASHERS[hasher?.type ?? 'Identity'] ?? DEFAULT_FN;
}
