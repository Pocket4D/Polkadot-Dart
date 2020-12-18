// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// BlockAttestations
class BlockAttestations extends Struct {
  CandidateReceipt get receipt =>
      super.getCodec("receipt").cast<CandidateReceipt>();

  Vec<AccountId> get valid => super.getCodec("valid").cast<Vec<AccountId>>();

  Vec<AccountId> get invalid =>
      super.getCodec("invalid").cast<Vec<AccountId>>();

  BlockAttestations(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "receipt": "CandidateReceipt",
              "valid": "Vec<AccountId>",
              "invalid": "Vec<AccountId>"
            },
            value,
            jsonMap);

  factory BlockAttestations.from(Struct origin) => BlockAttestations(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// IncludedBlocks
class IncludedBlocks extends Struct {
  BlockNumber get actualNumber =>
      super.getCodec("actualNumber").cast<BlockNumber>();

  SessionIndex get session => super.getCodec("session").cast<SessionIndex>();

  H256 get randomSeed => super.getCodec("randomSeed").cast<H256>();

  Vec<ParaId> get activeParachains =>
      super.getCodec("activeParachains").cast<Vec<ParaId>>();

  Vec<Hash> get paraBlocks => super.getCodec("paraBlocks").cast<Vec<Hash>>();

  IncludedBlocks(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "actualNumber": "BlockNumber",
              "session": "SessionIndex",
              "randomSeed": "H256",
              "activeParachains": "Vec<ParaId>",
              "paraBlocks": "Vec<Hash>"
            },
            value,
            jsonMap);

  factory IncludedBlocks.from(Struct origin) =>
      IncludedBlocks(origin.registry, origin.originValue, origin.originJsonMap);
}

/// MoreAttestations
class MoreAttestations extends Struct {
  MoreAttestations(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, null, value, jsonMap);

  factory MoreAttestations.from(Struct origin) => MoreAttestations(
      origin.registry, origin.originValue, origin.originJsonMap);
}
