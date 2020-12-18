// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// Account
class Account extends Struct {
  u256 get nonce => super.getCodec("nonce").cast<u256>();

  u256 get balance => super.getCodec("balance").cast<u256>();

  Account(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"nonce": "u256", "balance": "u256"}, value, jsonMap);

  factory Account.from(Struct origin) =>
      Account(origin.registry, origin.originValue, origin.originJsonMap);
}

/// Log
class Log extends Struct {
  H160 get address => super.getCodec("address").cast<H160>();

  Vec<H256> get topics => super.getCodec("topics").cast<Vec<H256>>();

  Bytes get data => super.getCodec("data").cast<Bytes>();

  Log(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"address": "H160", "topics": "Vec<H256>", "data": "Bytes"},
            value,
            jsonMap);

  factory Log.from(Struct origin) =>
      Log(origin.registry, origin.originValue, origin.originJsonMap);
}

/// Vicinity
class Vicinity extends Struct {
  u256 get gasPrice => super.getCodec("gasPrice").cast<u256>();

  H160 get origin => super.getCodec("origin").cast<H160>();

  Vicinity(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"gasPrice": "u256", "origin": "H160"}, value, jsonMap);

  factory Vicinity.from(Struct origin) =>
      Vicinity(origin.registry, origin.originValue, origin.originJsonMap);
}
