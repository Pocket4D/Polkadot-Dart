// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// Multisig
class Multisig extends Struct {
  Timepoint get when => super.getCodec("when").cast<Timepoint>();

  Balance get deposit => super.getCodec("deposit").cast<Balance>();

  AccountId get depositor => super.getCodec("depositor").cast<AccountId>();

  Vec<AccountId> get approvals =>
      super.getCodec("approvals").cast<Vec<AccountId>>();

  Multisig(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "when": "Timepoint",
              "deposit": "Balance",
              "depositor": "AccountId",
              "approvals": "Vec<AccountId>"
            },
            value,
            jsonMap);

  factory Multisig.from(Struct origin) =>
      Multisig(origin.registry, origin.originValue, origin.originJsonMap);
}

/// Timepoint
class Timepoint extends Struct {
  BlockNumber get height => super.getCodec("height").cast<BlockNumber>();

  u32 get index => super.getCodec("index").cast<u32>();

  Timepoint(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"height": "BlockNumber", "index": "u32"}, value,
            jsonMap);

  factory Timepoint.from(Struct origin) =>
      Timepoint(origin.registry, origin.originValue, origin.originJsonMap);
}
