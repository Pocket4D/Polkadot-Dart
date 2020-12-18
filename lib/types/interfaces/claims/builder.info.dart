// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// EthereumAddress
class EthereumAddress extends H160 {
  EthereumAddress(Registry registry,
      [dynamic value, int bitLength = 160, String typeName = "EthereumAddress"])
      : super(registry, value, bitLength ?? 160, typeName ?? "EthereumAddress");

  factory EthereumAddress.from(U8aFixed origin) => EthereumAddress(
      origin.registry, origin.value, origin.bitLength, origin.typeName);
}

/// StatementKind
class StatementKind extends Enum {
  bool get isRegular => super.isKey("Regular");

  bool get isSaft => super.isKey("Saft");

  StatementKind(Registry registry, [dynamic value, int index])
      : super(registry, ["Regular", "Saft"], value, index);

  factory StatementKind.from(Enum origin) =>
      StatementKind(origin.registry, origin.originValue, origin.originIndex);
}
