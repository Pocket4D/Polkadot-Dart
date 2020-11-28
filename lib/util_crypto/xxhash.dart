import 'dart:typed_data';

import 'package:polkadot_dart/crypto/common.dart';
import 'package:polkadot_dart/utils/is.dart';
import 'package:polkadot_dart/utils/utils.dart';

BigInt xxhash64AsValue(dynamic data, int seed) {
  var toHash;
  if (isU8a(data)) {
    toHash = u8aToString(data);
  } else if (isString(data)) {
    toHash = data;
  }
  var twoXResult = xxhash(toHash, seed);
  return twoXResult.hexAddPrefix().hexToBn();
}

String xxhash64AsRaw(dynamic data, int seed) {
  return xxhash64AsValue(data, seed).toRadixString(16);
}

String xxhash64AsHex(dynamic data, int seed) {
  return xxhash64AsValue(data, seed).toRadixString(16).hexAddPrefix();
}

BigInt xxhash64AsBn(dynamic data, int seed) {
  return BigInt.parse(xxhash64AsRaw(data, seed), radix: 16);
}

Uint8List xxhashAsU8a(dynamic data, {int bitLength = 64}) {
  final iterations = (bitLength / 64).ceil();

  var u8a = Uint8List((bitLength / 8).ceil());
  for (var seed = 0; seed < iterations; seed++) {
    var bn = xxhash64AsBn(data, seed);
    var toSet = encodeBigInt(bn, endian: Endian.little, bitLength: bitLength);
    u8a.setRange(seed * 8, seed * 8 + 8, toSet);
  }
  return u8a;
}

Future<Uint8List> xxhashAsU8aAsync(dynamic data, {int bitLength = 64}) async {
  final iterations = (bitLength / 64).ceil();

  if (isU8a(data)) {
    final twoxResult = await twox(u8aToHex(data, include0x: false), iterations);
    return twoxResult.hexAddPrefix().toU8a();
  } else {
    return xxhashAsU8a(data, bitLength: bitLength);
  }
}

String xxhashAsHex(dynamic data, {int bitLength = 64}) {
  return xxhashAsU8a(data, bitLength: bitLength).toHex();
}

Future<String> xxhashAsHexAsync(dynamic data, {int bitLength = 64}) async {
  final xxhashResult = await xxhashAsU8aAsync(data, bitLength: bitLength);
  return xxhashResult.toHex();
}
