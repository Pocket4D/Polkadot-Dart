// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AccountData
class AccountData extends Struct {
  Balance get free => super.getCodec("free").cast<Balance>();

  Balance get reserved => super.getCodec("reserved").cast<Balance>();

  Balance get miscFrozen => super.getCodec("miscFrozen").cast<Balance>();

  Balance get feeFrozen => super.getCodec("feeFrozen").cast<Balance>();

  AccountData(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "free": "Balance",
              "reserved": "Balance",
              "miscFrozen": "Balance",
              "feeFrozen": "Balance"
            },
            value,
            jsonMap);

  factory AccountData.from(Struct origin) =>
      AccountData(origin.registry, origin.originValue, origin.originJsonMap);
}

/// BalanceLockTo212
class BalanceLockTo212 extends Struct {
  LockIdentifier get id => super.getCodec("id").cast<LockIdentifier>();

  Balance get amount => super.getCodec("amount").cast<Balance>();

  BlockNumber get until => super.getCodec("until").cast<BlockNumber>();

  WithdrawReasons get reasons =>
      super.getCodec("reasons").cast<WithdrawReasons>();

  BalanceLockTo212(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "id": "LockIdentifier",
              "amount": "Balance",
              "until": "BlockNumber",
              "reasons": "WithdrawReasons"
            },
            value,
            jsonMap);

  factory BalanceLockTo212.from(Struct origin) => BalanceLockTo212(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// BalanceLock
class BalanceLock extends Struct {
  LockIdentifier get id => super.getCodec("id").cast<LockIdentifier>();

  Balance get amount => super.getCodec("amount").cast<Balance>();

  Reasons get reasons => super.getCodec("reasons").cast<Reasons>();

  BalanceLock(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"id": "LockIdentifier", "amount": "Balance", "reasons": "Reasons"},
            value,
            jsonMap);

  factory BalanceLock.from(Struct origin) =>
      BalanceLock(origin.registry, origin.originValue, origin.originJsonMap);
}

/// BalanceStatus
class BalanceStatus extends Enum {
  bool get isFree => super.isKey("Free");

  bool get isReserved => super.isKey("Reserved");

  BalanceStatus(Registry registry, [dynamic value, int index])
      : super(registry, ["Free", "Reserved"], value, index);

  factory BalanceStatus.from(Enum origin) =>
      BalanceStatus(origin.registry, origin.originValue, origin.originIndex);
}

/// Reasons
class Reasons extends Enum {
  bool get isFee => super.isKey("Fee");

  bool get isMisc => super.isKey("Misc");

  bool get isAll => super.isKey("All");

  Reasons(Registry registry, [dynamic value, int index])
      : super(registry, ["Fee", "Misc", "All"], value, index);

  factory Reasons.from(Enum origin) =>
      Reasons(origin.registry, origin.originValue, origin.originIndex);
}

/// VestingSchedule
class VestingSchedule extends Struct {
  Balance get offset => super.getCodec("offset").cast<Balance>();

  Balance get perBlock => super.getCodec("perBlock").cast<Balance>();

  BlockNumber get startingBlock =>
      super.getCodec("startingBlock").cast<BlockNumber>();

  VestingSchedule(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "offset": "Balance",
              "perBlock": "Balance",
              "startingBlock": "BlockNumber"
            },
            value,
            jsonMap);

  factory VestingSchedule.from(Struct origin) => VestingSchedule(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// WithdrawReasons
class WithdrawReasons extends CodecSet {
  bool get isTransactionPayment => super.isKey("TransactionPayment");

  bool get isTransfer => super.isKey("Transfer");

  bool get isReserve => super.isKey("Reserve");

  bool get isFee => super.isKey("Fee");

  bool get isTip => super.isKey("Tip");

  WithdrawReasons(Registry registry, [dynamic value, int bitLength = 8])
      : super(
            registry,
            {
              "TransactionPayment": "Null",
              "Transfer": "Null",
              "Reserve": "Null",
              "Fee": "Null",
              "Tip": "Null"
            },
            value,
            bitLength);

  factory WithdrawReasons.from(CodecSet origin) => WithdrawReasons(
      origin.registry, origin.originValue, origin.originBitLength);
}
