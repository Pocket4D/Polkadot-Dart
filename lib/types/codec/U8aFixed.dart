import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

Uint8List decodeU8aFixed(dynamic value, int bitLength) {
  if ((!(value is Uint8List) && value is List) || isString(value)) {
    return decodeU8aFixed(u8aToU8a(value), bitLength);
  }

  if (value is U8aFixed) {
    return decodeU8aFixed(value.value, bitLength);
  }

  // ensure that we have an actual u8a with the full length as specified by
  // the bitLength input (padded with zeros as required)
  final byteLength = (bitLength / 8).ceil();
  final sub = value.sublist(0, byteLength > value.length ? value.length : byteLength);

  if (sub.length == byteLength) {
    return sub;
  }
  final u8a = Uint8List(byteLength);
  u8a.setAll(0, sub);
  return u8a;
}

U8aFixed Function(Registry, [dynamic]) u8aFixedWith(int bitLength, String typeName) {
  return (Registry registry, [dynamic value]) => U8aFixed(registry, value, bitLength, typeName);
}

class U8aFixed extends Raw {
  String typeName;
  dynamic originValue;
  U8aFixed.empty() : super.empty();
  U8aFixed(Registry registry, [dynamic thisValue, int bitLength = 256, String typeName])
      : super(registry, decodeU8aFixed(thisValue ?? Uint8List.fromList([]), bitLength)) {
    this.typeName = typeName;
    this.originValue = thisValue;
  }
  static Constructor<U8aFixed> withParams(int bitLength, [String typeName]) =>
      u8aFixedWith(bitLength, typeName);

  static U8aFixed constructor(Registry registry,
          [dynamic value, int bitLength = 256, String typeName]) =>
      U8aFixed(registry, value as Uint8List, bitLength, typeName);

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return this.typeName ?? "[u8;${this.length}]";
  }
}
