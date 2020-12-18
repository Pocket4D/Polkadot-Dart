// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AccountStatus
class AccountStatus extends Struct {
  AccountValidity get validity =>
      super.getCodec("validity").cast<AccountValidity>();

  Balance get freeBalance => super.getCodec("freeBalance").cast<Balance>();

  Balance get lockedBalance => super.getCodec("lockedBalance").cast<Balance>();

  Vec<u8> get signature => super.getCodec("signature").cast<Vec<u8>>();

  Permill get vat => super.getCodec("vat").cast<Permill>();

  AccountStatus(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "validity": "AccountValidity",
              "freeBalance": "Balance",
              "lockedBalance": "Balance",
              "signature": "Vec<u8>",
              "vat": "Permill"
            },
            value,
            jsonMap);

  factory AccountStatus.from(Struct origin) =>
      AccountStatus(origin.registry, origin.originValue, origin.originJsonMap);
}

/// AccountValidity
class AccountValidity extends Enum {
  bool get isInvalid => super.isKey("Invalid");

  bool get isInitiated => super.isKey("Initiated");

  bool get isPending => super.isKey("Pending");

  bool get isValidLow => super.isKey("ValidLow");

  bool get isValidHigh => super.isKey("ValidHigh");

  bool get isCompleted => super.isKey("Completed");

  AccountValidity(Registry registry, [dynamic value, int index])
      : super(
            registry,
            [
              "Invalid",
              "Initiated",
              "Pending",
              "ValidLow",
              "ValidHigh",
              "Completed"
            ],
            value,
            index);

  factory AccountValidity.from(Enum origin) =>
      AccountValidity(origin.registry, origin.originValue, origin.originIndex);
}
