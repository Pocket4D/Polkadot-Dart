import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

/// @name AssetBalance */
class AssetBalance<S extends Map<String, dynamic>> extends Struct {
  TAssetBalance get balance => super.getCodec("balance").cast<TAssetBalance>();
  bool get isFrozen => super.getCodec("isFrozen").cast<CodecBool>().value;
  bool get isZombie => super.getCodec("isZombie").cast<CodecBool>().value;
  AssetBalance(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory AssetBalance.from(Struct origin) =>
      AssetBalance(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name AssetDetails */
class AssetDetails<S extends Map<String, dynamic>> extends Struct {
  AccountId get owner => super.getCodec("owner").cast<AccountId>();
  AccountId get issuer => super.getCodec("issuer").cast<AccountId>();
  AccountId get admin => super.getCodec("admin").cast<AccountId>();
  AccountId get freezer => super.getCodec("freezer").cast<AccountId>();
  TAssetBalance get supply => super.getCodec("supply").cast<TAssetBalance>();
  TAssetDepositBalance get deposit => super.getCodec("deposit").cast<TAssetDepositBalance>();
  u32 get maxZombies => super.getCodec("maxZombies").cast<u32>();
  TAssetBalance get minBalance => super.getCodec("minBalance").cast<TAssetBalance>();
  u32 get zombies => super.getCodec("zombies").cast<u32>();
  u32 get accounts => super.getCodec("accounts").cast<u32>();
  AssetDetails(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory AssetDetails.from(Struct origin) =>
      AssetDetails(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name TAssetBalance */
class TAssetBalance extends Balance {
  TAssetBalance(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value, bitLength);
  factory TAssetBalance.from(Balance origin) =>
      TAssetBalance(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
}

/// @name TAssetDepositBalance */
class TAssetDepositBalance extends BalanceOf {
  TAssetDepositBalance(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value, bitLength);
  factory TAssetDepositBalance.from(BalanceOf origin) =>
      TAssetDepositBalance(origin.registry, origin.value, origin.bitLength)
        ..setRawType(origin.typeName);
}

const PHANTOM_ASSETS = 'assets';
