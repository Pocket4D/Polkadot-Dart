// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// ProxyDefinition
class ProxyDefinition extends Struct {
  AccountId get delegate => super.getCodec("delegate").cast<AccountId>();

  ProxyType get proxyType => super.getCodec("proxyType").cast<ProxyType>();

  BlockNumber get delay => super.getCodec("delay").cast<BlockNumber>();

  ProxyDefinition(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "delegate": "AccountId",
              "proxyType": "ProxyType",
              "delay": "BlockNumber"
            },
            value,
            jsonMap);

  factory ProxyDefinition.from(Struct origin) => ProxyDefinition(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// ProxyType
class ProxyType extends Enum {
  bool get isAny => super.isKey("Any");

  bool get isNonTransfer => super.isKey("NonTransfer");

  bool get isGovernance => super.isKey("Governance");

  bool get isStaking => super.isKey("Staking");

  ProxyType(Registry registry, [dynamic value, int index])
      : super(registry, ["Any", "NonTransfer", "Governance", "Staking"], value,
            index);

  factory ProxyType.from(Enum origin) =>
      ProxyType(origin.registry, origin.originValue, origin.originIndex);
}

/// ProxyAnnouncement
class ProxyAnnouncement extends Struct {
  AccountId get real => super.getCodec("real").cast<AccountId>();

  Hash get callHash => super.getCodec("callHash").cast<Hash>();

  BlockNumber get height => super.getCodec("height").cast<BlockNumber>();

  ProxyAnnouncement(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"real": "AccountId", "callHash": "Hash", "height": "BlockNumber"},
            value,
            jsonMap);

  factory ProxyAnnouncement.from(Struct origin) => ProxyAnnouncement(
      origin.registry, origin.originValue, origin.originJsonMap);
}
