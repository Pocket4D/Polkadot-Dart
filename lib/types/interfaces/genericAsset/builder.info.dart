// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AssetOptions
class AssetOptions extends Struct {
  Compact<Balance> get initalIssuance =>
      super.getCodec("initalIssuance").cast<Compact<Balance>>();

  PermissionLatest get permissions =>
      super.getCodec("permissions").cast<PermissionLatest>();

  AssetOptions(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "initalIssuance": "Compact<Balance>",
              "permissions": "PermissionLatest"
            },
            value,
            jsonMap);

  factory AssetOptions.from(Struct origin) =>
      AssetOptions(origin.registry, origin.originValue, origin.originJsonMap);
}

/// Owner
class Owner extends Enum {
  bool get isNone => super.isKey("None");

  bool get isAddress => super.isKey("Address");

  AccountId get asAddress => super.askey("Address").cast<AccountId>();

  Owner(Registry registry, [dynamic value, int index])
      : super(registry, {"None": "Null", "Address": "AccountId"}, value, index);

  factory Owner.from(Enum origin) =>
      Owner(origin.registry, origin.originValue, origin.originIndex);
}

/// PermissionsV1
class PermissionsV1 extends Struct {
  Owner get update => super.getCodec("update").cast<Owner>();

  Owner get mint => super.getCodec("mint").cast<Owner>();

  Owner get burn => super.getCodec("burn").cast<Owner>();

  PermissionsV1(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"update": "Owner", "mint": "Owner", "burn": "Owner"},
            value, jsonMap);

  factory PermissionsV1.from(Struct origin) =>
      PermissionsV1(origin.registry, origin.originValue, origin.originJsonMap);
}

/// PermissionVersions
class PermissionVersions extends Enum {
  bool get isV1 => super.isKey("V1");

  PermissionsV1 get asV1 => super.askey("V1").cast<PermissionsV1>();

  PermissionVersions(Registry registry, [dynamic value, int index])
      : super(registry, {"V1": "PermissionsV1"}, value, index);

  factory PermissionVersions.from(Enum origin) => PermissionVersions(
      origin.registry, origin.originValue, origin.originIndex);
}

/// PermissionLatest
class PermissionLatest extends PermissionsV1 {
  PermissionLatest(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, value, jsonMap);

  factory PermissionLatest.from(Struct origin) => PermissionLatest(
      origin.registry, origin.originValue, origin.originJsonMap);
}
