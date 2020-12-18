// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// RawAuraPreDigest
class RawAuraPreDigest extends Struct {
  u64 get slotNumber => super.getCodec("slotNumber").cast<u64>();

  RawAuraPreDigest(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"slotNumber": "u64"}, value, jsonMap);

  factory RawAuraPreDigest.from(Struct origin) => RawAuraPreDigest(
      origin.registry, origin.originValue, origin.originJsonMap);
}
