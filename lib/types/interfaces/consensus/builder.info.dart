// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AuthorityId
class AuthorityId extends AccountId {
  AuthorityId(Registry registry, [dynamic value]) : super(registry, value);

  factory AuthorityId.from(AccountId origin) =>
      AuthorityId(origin.registry, origin.originValue);
}

/// RawVRFOutput
class RawVRFOutput extends U8aFixed {
  RawVRFOutput(Registry registry,
      [dynamic value, int bitLength = 256, String typeName = "RawVRFOutput"])
      : super(registry, value, bitLength ?? 256, typeName ?? "RawVRFOutput");

  factory RawVRFOutput.from(U8aFixed origin) => RawVRFOutput(
      origin.registry, origin.value, origin.bitLength, origin.typeName);
}
