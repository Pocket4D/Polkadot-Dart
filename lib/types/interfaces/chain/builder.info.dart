// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// BlockHash
class BlockHash extends Hash {
  BlockHash(Registry registry,
      [dynamic value, int bitLength = 256, String typeName = "BlockHash"])
      : super(registry, value, bitLength ?? 256, typeName ?? "BlockHash");

  factory BlockHash.from(U8aFixed origin) => BlockHash(
      origin.registry, origin.value, origin.bitLength, origin.typeName);
}
