import 'dart:typed_data';

import 'package:polkadot_dart/utils/bn.dart';
import 'package:polkadot_dart/utils/u8a.dart';

final BigInt maxU8 = BigInt.from(2).pow(8 - 2) - (BigInt.one);
final BigInt maxU16 = BigInt.from(2).pow(16 - 2) - (BigInt.one);
final BigInt maxU32 = BigInt.from(2).pow(32 - 2) - (BigInt.one);

Uint8List compactToU8a(dynamic _value) {
  var value = bnToBn(_value);

  var ls2 = value << 2;

  var b01 = BigInt.from(1);
  var b10 = BigInt.from(2);

  if (value <= (maxU8)) {
    return Uint8List.fromList([value.toInt() << 2]);
  } else if (value <= (maxU16)) {
    return bnToU8a(ls2 + b01, bitLength: 16, endian: Endian.little);
  } else if (value <= (maxU32)) {
    return bnToU8a(ls2 + b10, bitLength: 32, endian: Endian.little);
  }

  var u8a = bnToU8a(value);
  var length = u8a.length;
  // adjust to the minimum number of bytes
  while (u8a[length - 1] == 0) {
    length--;
  }

  assert(length >= 4, 'Previous tests match anyting less than 2^30; qed');

  return u8aConcat([
    Uint8List.fromList([
      // substract 4 as minimum (also catered for in decoding)
      ((length - 4) << 2) + 3
    ]),
    u8a.sublist(0, length)
  ]);
}

Uint8List compactAddLength(Uint8List input) {
  return u8aConcat([compactToU8a(input.length), input]);
}

/// result : [int, BN]
List<dynamic> compactFromU8a(dynamic _input, {int bitLength = 32}) {
  var input = u8aToU8a(_input);
  if (input.isEmpty) {
    input = Uint8List.fromList([0]);
  }
  var flag = input[0] & 3;
  if (flag == 0) {
    return [1, BigInt.from(input[0]) >> (2)];
  } else if (flag == 1) {
    return [
      2,
      u8aToBn(input.sublist(0, 2 > input.length ? input.length : 2), endian: Endian.little) >> (2)
    ];
  } else if (flag == 2) {
    return [
      4,
      u8aToBn(input.sublist(0, 4 > input.length ? input.length : 4), endian: Endian.little) >> (2)
    ];
  }

  var length = ((BigInt.from(input[0]) >> (2)) // clear flag
          +
          BigInt.from(4))
      .toInt();
  var offset = 1 + length;

  return [
    offset,
    u8aToBn(input.sublist(1, offset > input.length ? input.length : offset), endian: Endian.little)
  ];
}

List<dynamic> compactStripLength(Uint8List input, {int bitLength = 32}) {
  var result = compactFromU8a(input, bitLength: bitLength);
  var offset = result[0] as int;
  var length = result[1] as BigInt;
  var total = offset + length.toInt();

  return [total, input.sublist(offset, total)];
}
