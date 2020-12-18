// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AuthIndex
class AuthIndex extends u32 {
  AuthIndex(Registry registry, [dynamic value]) : super(registry, value);

  factory AuthIndex.from(u32 origin) =>
      AuthIndex(origin.registry, origin.originValue);
}

/// AuthoritySignature
class AuthoritySignature extends Signature {
  AuthoritySignature(Registry registry,
      [dynamic value,
      int bitLength = 512,
      String typeName = "AuthoritySignature"])
      : super(registry, value, bitLength ?? 512,
            typeName ?? "AuthoritySignature");

  factory AuthoritySignature.from(U8aFixed origin) => AuthoritySignature(
      origin.registry, origin.value, origin.bitLength, origin.typeName);
}

/// Heartbeat
class Heartbeat extends Struct {
  BlockNumber get blockNumber =>
      super.getCodec("blockNumber").cast<BlockNumber>();

  OpaqueNetworkState get networkState =>
      super.getCodec("networkState").cast<OpaqueNetworkState>();

  SessionIndex get sessionIndex =>
      super.getCodec("sessionIndex").cast<SessionIndex>();

  AuthIndex get authorityIndex =>
      super.getCodec("authorityIndex").cast<AuthIndex>();

  u32 get validatorsLen => super.getCodec("validatorsLen").cast<u32>();

  Heartbeat(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "blockNumber": "BlockNumber",
              "networkState": "OpaqueNetworkState",
              "sessionIndex": "SessionIndex",
              "authorityIndex": "AuthIndex",
              "validatorsLen": "u32"
            },
            value,
            jsonMap);

  factory Heartbeat.from(Struct origin) =>
      Heartbeat(origin.registry, origin.originValue, origin.originJsonMap);
}

/// HeartbeatTo244
class HeartbeatTo244 extends Struct {
  BlockNumber get blockNumber =>
      super.getCodec("blockNumber").cast<BlockNumber>();

  OpaqueNetworkState get networkState =>
      super.getCodec("networkState").cast<OpaqueNetworkState>();

  SessionIndex get sessionIndex =>
      super.getCodec("sessionIndex").cast<SessionIndex>();

  AuthIndex get authorityIndex =>
      super.getCodec("authorityIndex").cast<AuthIndex>();

  HeartbeatTo244(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "blockNumber": "BlockNumber",
              "networkState": "OpaqueNetworkState",
              "sessionIndex": "SessionIndex",
              "authorityIndex": "AuthIndex"
            },
            value,
            jsonMap);

  factory HeartbeatTo244.from(Struct origin) =>
      HeartbeatTo244(origin.registry, origin.originValue, origin.originJsonMap);
}

/// OpaqueMultiaddr
class OpaqueMultiaddr extends Bytes {
  OpaqueMultiaddr(Registry registry, [dynamic value]) : super(registry, value);

  factory OpaqueMultiaddr.from(Bytes origin) =>
      OpaqueMultiaddr(origin.registry, origin.originValue);
}

/// OpaquePeerId
class OpaquePeerId extends Bytes {
  OpaquePeerId(Registry registry, [dynamic value]) : super(registry, value);

  factory OpaquePeerId.from(Bytes origin) =>
      OpaquePeerId(origin.registry, origin.originValue);
}

/// OpaqueNetworkState
class OpaqueNetworkState extends Struct {
  OpaquePeerId get peerId => super.getCodec("peerId").cast<OpaquePeerId>();

  Vec<OpaqueMultiaddr> get externalAddresses =>
      super.getCodec("externalAddresses").cast<Vec<OpaqueMultiaddr>>();

  OpaqueNetworkState(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "peerId": "OpaquePeerId",
              "externalAddresses": "Vec<OpaqueMultiaddr>"
            },
            value,
            jsonMap);

  factory OpaqueNetworkState.from(Struct origin) => OpaqueNetworkState(
      origin.registry, origin.originValue, origin.originJsonMap);
}
