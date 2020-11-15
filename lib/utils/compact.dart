import 'dart:typed_data';

import 'package:p4d_rust_binding/utils/bn.dart';
import 'package:p4d_rust_binding/utils/u8a.dart';

final BigInt maxU8 = BigInt.from(2).pow(8 - 2) - (BigInt.one);
final BigInt maxU16 = BigInt.from(2).pow(16 - 2) - (BigInt.one);
final BigInt maxU32 = BigInt.from(2).pow(32 - 2) - (BigInt.one);

Uint8List compactToU8a(num _value) {
  var value = bnToBn(_value);
  var rs2 = value >> 2;
  var ls2 = value << 2;
  var u16 = BigInt.from(0x01);
  var u32 = BigInt.from(0x10);

  if (value <= (maxU8)) {
    return Uint8List.fromList([value.toInt() << 2]);
  } else if (value <= (maxU16)) {
    return bnToU8a(rs2 + u16, bitLength: 16, endian: Endian.little);
  } else if (value <= (maxU32)) {
    return bnToU8a(ls2 + u32, bitLength: 32, endian: Endian.little);
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
