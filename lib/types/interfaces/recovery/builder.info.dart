// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// ActiveRecovery
class ActiveRecovery extends Struct {
  BlockNumber get created => super.getCodec("created").cast<BlockNumber>();

  Balance get deposit => super.getCodec("deposit").cast<Balance>();

  Vec<AccountId> get friends =>
      super.getCodec("friends").cast<Vec<AccountId>>();

  ActiveRecovery(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "created": "BlockNumber",
              "deposit": "Balance",
              "friends": "Vec<AccountId>"
            },
            value,
            jsonMap);

  factory ActiveRecovery.from(Struct origin) =>
      ActiveRecovery(origin.registry, origin.originValue, origin.originJsonMap);
}

/// RecoveryConfig
class RecoveryConfig extends Struct {
  BlockNumber get delayPeriod =>
      super.getCodec("delayPeriod").cast<BlockNumber>();

  Balance get deposit => super.getCodec("deposit").cast<Balance>();

  Vec<AccountId> get friends =>
      super.getCodec("friends").cast<Vec<AccountId>>();

  u16 get threshold => super.getCodec("threshold").cast<u16>();

  RecoveryConfig(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "delayPeriod": "BlockNumber",
              "deposit": "Balance",
              "friends": "Vec<AccountId>",
              "threshold": "u16"
            },
            value,
            jsonMap);

  factory RecoveryConfig.from(Struct origin) =>
      RecoveryConfig(origin.registry, origin.originValue, origin.originJsonMap);
}
