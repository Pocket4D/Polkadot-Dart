// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AssetBalance
class AssetBalance extends Struct {
  TAssetBalance get balance => super.getCodec("balance").cast<TAssetBalance>();

  bool get isFrozen => super.getCodec("isFrozen").cast<CodecBool>().value;

  bool get isZombie => super.getCodec("isZombie").cast<CodecBool>().value;

  AssetBalance(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "balance": "TAssetBalance",
              "isFrozen": "bool",
              "isZombie": "bool"
            },
            value,
            jsonMap);

  factory AssetBalance.from(Struct origin) =>
      AssetBalance(origin.registry, origin.originValue, origin.originJsonMap);
}

/// AssetDetails
class AssetDetails extends Struct {
  AccountId get owner => super.getCodec("owner").cast<AccountId>();

  AccountId get issuer => super.getCodec("issuer").cast<AccountId>();

  AccountId get admin => super.getCodec("admin").cast<AccountId>();

  AccountId get freezer => super.getCodec("freezer").cast<AccountId>();

  TAssetBalance get supply => super.getCodec("supply").cast<TAssetBalance>();

  TAssetDepositBalance get deposit =>
      super.getCodec("deposit").cast<TAssetDepositBalance>();

  u32 get maxZombies => super.getCodec("maxZombies").cast<u32>();

  TAssetBalance get minBalance =>
      super.getCodec("minBalance").cast<TAssetBalance>();

  u32 get zombies => super.getCodec("zombies").cast<u32>();

  u32 get accounts => super.getCodec("accounts").cast<u32>();

  AssetDetails(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "owner": "AccountId",
              "issuer": "AccountId",
              "admin": "AccountId",
              "freezer": "AccountId",
              "supply": "TAssetBalance",
              "deposit": "TAssetDepositBalance",
              "maxZombies": "u32",
              "minBalance": "TAssetBalance",
              "zombies": "u32",
              "accounts": "u32"
            },
            value,
            jsonMap);

  factory AssetDetails.from(Struct origin) =>
      AssetDetails(origin.registry, origin.originValue, origin.originJsonMap);
}

/// TAssetBalance
class TAssetBalance extends Balance {
  TAssetBalance(Registry registry, [dynamic value = 0, int bitLength = 128])
      : super(registry, value ?? 0, bitLength ?? 128) {
    this.setRawType("TAssetBalance");
  }

  factory TAssetBalance.from(UInt origin) =>
      TAssetBalance(origin.registry, origin.value, origin.bitLength)
        ..setRawType(origin.typeName);
}

/// TAssetDepositBalance
class TAssetDepositBalance extends BalanceOf {
  TAssetDepositBalance(Registry registry,
      [dynamic value = 0, int bitLength = 128])
      : super(registry, value ?? 0, bitLength ?? 128) {
    this.setRawType("TAssetDepositBalance");
  }

  factory TAssetDepositBalance.from(UInt origin) =>
      TAssetDepositBalance(origin.registry, origin.value, origin.bitLength)
        ..setRawType(origin.typeName);
}
