// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// AccountInfo
class AccountInfo extends Struct {
  Index get nonce => super.getCodec("nonce").cast<Index>();

  RefCount get refcount => super.getCodec("refcount").cast<RefCount>();

  AccountData get data => super.getCodec("data").cast<AccountData>();

  AccountInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"nonce": "Index", "refcount": "RefCount", "data": "AccountData"},
            value,
            jsonMap);

  factory AccountInfo.from(Struct origin) =>
      AccountInfo(origin.registry, origin.originValue, origin.originJsonMap);
}

/// ApplyExtrinsicResult
class ApplyExtrinsicResult
    extends Result<DispatchOutcome, TransactionValidityError> {
  ApplyExtrinsicResult(Registry registry, dynamic ok, dynamic error,
      [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
}

/// BlockWeights
class BlockWeights extends Struct {
  Weight get baseBlock => super.getCodec("baseBlock").cast<Weight>();

  Weight get maxBlock => super.getCodec("maxBlock").cast<Weight>();

  PerDispatchClass get perClass =>
      super.getCodec("perClass").cast<PerDispatchClass>();

  BlockWeights(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "baseBlock": "Weight",
              "maxBlock": "Weight",
              "perClass": "PerDispatchClass"
            },
            value,
            jsonMap);

  factory BlockWeights.from(Struct origin) =>
      BlockWeights(origin.registry, origin.originValue, origin.originJsonMap);
}

/// ChainProperties
class ChainProperties extends Struct {
  Option<u8> get ss58Format => super.getCodec("ss58Format").cast<Option<u8>>();

  Option<u32> get tokenDecimals =>
      super.getCodec("tokenDecimals").cast<Option<u32>>();

  Option<CodecText> get tokenSymbol =>
      super.getCodec("tokenSymbol").cast<Option<CodecText>>();

  ChainProperties(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "ss58Format": "Option<u8>",
              "tokenDecimals": "Option<u32>",
              "tokenSymbol": "Option<Text>"
            },
            value,
            jsonMap);

  factory ChainProperties.from(Struct origin) => ChainProperties(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// ChainType
class ChainType extends Enum {
  bool get isDevelopment => super.isKey("Development");

  bool get isLocal => super.isKey("Local");

  bool get isLive => super.isKey("Live");

  bool get isCustom => super.isKey("Custom");

  CodecText get asCustom => super.askey("Custom").cast<CodecText>();

  ChainType(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Development": "Null",
              "Local": "Null",
              "Live": "Null",
              "Custom": "Text"
            },
            value,
            index);

  factory ChainType.from(Enum origin) =>
      ChainType(origin.registry, origin.originValue, origin.originIndex);
}

/// ConsumedWeight
class ConsumedWeight extends PerDispatchClass {
  ConsumedWeight(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, value, jsonMap);

  factory ConsumedWeight.from(Struct origin) =>
      ConsumedWeight(origin.registry, origin.originValue, origin.originJsonMap);
}

/// DigestOf
class DigestOf extends Digest {
  DigestOf(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, value, jsonMap);

  factory DigestOf.from(Struct origin) =>
      DigestOf(origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchClass
class DispatchClass extends Enum {
  bool get isNormal => super.isKey("Normal");

  bool get isOperational => super.isKey("Operational");

  bool get isMandatory => super.isKey("Mandatory");

  DispatchClass(Registry registry, [dynamic value, int index])
      : super(registry, ["Normal", "Operational", "Mandatory"], value, index);

  factory DispatchClass.from(Enum origin) =>
      DispatchClass(origin.registry, origin.originValue, origin.originIndex);
}

/// DispatchError
class DispatchError extends Enum {
  bool get isOther => super.isKey("Other");

  bool get isCannotLookup => super.isKey("CannotLookup");

  bool get isBadOrigin => super.isKey("BadOrigin");

  bool get isModule => super.isKey("Module");

  DispatchErrorModule get asModule =>
      super.askey("Module").cast<DispatchErrorModule>();

  DispatchError(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Other": "Null",
              "CannotLookup": "Null",
              "BadOrigin": "Null",
              "Module": "DispatchErrorModule"
            },
            value,
            index);

  factory DispatchError.from(Enum origin) =>
      DispatchError(origin.registry, origin.originValue, origin.originIndex);
}

/// DispatchErrorModule
class DispatchErrorModule extends Struct {
  u8 get index => super.getCodec("index").cast<u8>();

  u8 get error => super.getCodec("error").cast<u8>();

  DispatchErrorModule(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"index": "u8", "error": "u8"}, value, jsonMap);

  factory DispatchErrorModule.from(Struct origin) => DispatchErrorModule(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchErrorTo198
class DispatchErrorTo198 extends Struct {
  Option<u8> get module => super.getCodec("module").cast<Option<u8>>();

  u8 get error => super.getCodec("error").cast<u8>();

  DispatchErrorTo198(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry, {"module": "Option<u8>", "error": "u8"}, value, jsonMap);

  factory DispatchErrorTo198.from(Struct origin) => DispatchErrorTo198(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchInfo
class DispatchInfo extends Struct {
  Weight get weight => super.getCodec("weight").cast<Weight>();

  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();

  Pays get paysFee => super.getCodec("paysFee").cast<Pays>();

  DispatchInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"weight": "Weight", "class": "DispatchClass", "paysFee": "Pays"},
            value,
            jsonMap);

  factory DispatchInfo.from(Struct origin) =>
      DispatchInfo(origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchInfoTo190
class DispatchInfoTo190 extends Struct {
  Weight get weight => super.getCodec("weight").cast<Weight>();

  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();

  DispatchInfoTo190(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"weight": "Weight", "class": "DispatchClass"}, value,
            jsonMap);

  factory DispatchInfoTo190.from(Struct origin) => DispatchInfoTo190(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchInfoTo244
class DispatchInfoTo244 extends Struct {
  Weight get weight => super.getCodec("weight").cast<Weight>();

  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();

  bool get paysFee => super.getCodec("paysFee").cast<CodecBool>().value;

  DispatchInfoTo244(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"weight": "Weight", "class": "DispatchClass", "paysFee": "bool"},
            value,
            jsonMap);

  factory DispatchInfoTo244.from(Struct origin) => DispatchInfoTo244(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// DispatchOutcome
class DispatchOutcome extends Result<ITuple, DispatchError> {
  DispatchOutcome(Registry registry, dynamic ok, dynamic error, [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
}

/// DispatchResult
class DispatchResult extends Result<ITuple, DispatchError> {
  DispatchResult(Registry registry, dynamic ok, dynamic error, [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
}

/// DispatchResultOf
class DispatchResultOf extends DispatchResult {
  DispatchResultOf(Registry registry, dynamic ok, dynamic error,
      [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
}

/// DispatchResultTo198
class DispatchResultTo198 extends Result<ITuple, CodecText> {
  DispatchResultTo198(Registry registry, dynamic ok, dynamic error,
      [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
}

/// Event
class Event extends GenericEvent {
  Event(Registry registry, [dynamic value]) : super(registry, value);

  factory Event.from(GenericEvent origin) =>
      Event(origin.registry, origin.originValue);
}

/// EventId
class EventId extends U8aFixed {
  EventId(Registry registry,
      [dynamic value, int bitLength = 16, String typeName = "EventId"])
      : super(registry, value, bitLength ?? 16, typeName ?? "EventId");

  factory EventId.from(U8aFixed origin) =>
      EventId(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

/// EventIndex
class EventIndex extends u32 {
  EventIndex(Registry registry, [dynamic value]) : super(registry, value);

  factory EventIndex.from(u32 origin) =>
      EventIndex(origin.registry, origin.originValue);
}

/// EventRecord
class EventRecord extends Struct {
  Phase get phase => super.getCodec("phase").cast<Phase>();

  Event get event => super.getCodec("event").cast<Event>();

  Vec<Hash> get topics => super.getCodec("topics").cast<Vec<Hash>>();

  EventRecord(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"phase": "Phase", "event": "Event", "topics": "Vec<Hash>"},
            value,
            jsonMap);

  factory EventRecord.from(Struct origin) =>
      EventRecord(origin.registry, origin.originValue, origin.originJsonMap);
}

/// Health
class Health extends Struct {
  u64 get peers => super.getCodec("peers").cast<u64>();

  bool get isSyncing => super.getCodec("isSyncing").cast<CodecBool>().value;

  bool get shouldHavePeers =>
      super.getCodec("shouldHavePeers").cast<CodecBool>().value;

  Health(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"peers": "u64", "isSyncing": "bool", "shouldHavePeers": "bool"},
            value,
            jsonMap);

  factory Health.from(Struct origin) =>
      Health(origin.registry, origin.originValue, origin.originJsonMap);
}

/// InvalidTransaction
class InvalidTransaction extends Enum {
  bool get isCall => super.isKey("Call");

  bool get isPayment => super.isKey("Payment");

  bool get isFuture => super.isKey("Future");

  bool get isStale => super.isKey("Stale");

  bool get isBadProof => super.isKey("BadProof");

  bool get isAncientBirthBlock => super.isKey("AncientBirthBlock");

  bool get isExhaustsResources => super.isKey("ExhaustsResources");

  bool get isCustom => super.isKey("Custom");

  u8 get asCustom => super.askey("Custom").cast<u8>();

  bool get isBadMandatory => super.isKey("BadMandatory");

  bool get isMandatoryDispatch => super.isKey("MandatoryDispatch");

  InvalidTransaction(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Call": "Null",
              "Payment": "Null",
              "Future": "Null",
              "Stale": "Null",
              "BadProof": "Null",
              "AncientBirthBlock": "Null",
              "ExhaustsResources": "Null",
              "Custom": "u8",
              "BadMandatory": "Null",
              "MandatoryDispatch": "Null"
            },
            value,
            index);

  factory InvalidTransaction.from(Enum origin) => InvalidTransaction(
      origin.registry, origin.originValue, origin.originIndex);
}

/// Key
class Key extends Bytes {
  Key(Registry registry, [dynamic value]) : super(registry, value);

  factory Key.from(Bytes origin) => Key(origin.registry, origin.originValue);
}

/// LastRuntimeUpgradeInfo
class LastRuntimeUpgradeInfo extends Struct {
  Compact<u32> get specVersion =>
      super.getCodec("specVersion").cast<Compact<u32>>();

  CodecText get specName => super.getCodec("specName").cast<CodecText>();

  LastRuntimeUpgradeInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"specVersion": "Compact<u32>", "specName": "Text"},
            value, jsonMap);

  factory LastRuntimeUpgradeInfo.from(Struct origin) => LastRuntimeUpgradeInfo(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// NetworkState
class NetworkState extends Struct {
  CodecText get peerId => super.getCodec("peerId").cast<CodecText>();

  Vec<CodecText> get listenedAddresses =>
      super.getCodec("listenedAddresses").cast<Vec<CodecText>>();

  Vec<CodecText> get externalAddresses =>
      super.getCodec("externalAddresses").cast<Vec<CodecText>>();

  HashMap<CodecText, Peer> get connectedPeers =>
      super.getCodec("connectedPeers").cast<HashMap<CodecText, Peer>>();

  HashMap<CodecText, NotConnectedPeer> get notConnectedPeers => super
      .getCodec("notConnectedPeers")
      .cast<HashMap<CodecText, NotConnectedPeer>>();

  u64 get averageDownloadPerSec =>
      super.getCodec("averageDownloadPerSec").cast<u64>();

  u64 get averageUploadPerSec =>
      super.getCodec("averageUploadPerSec").cast<u64>();

  NetworkStatePeerset get peerset =>
      super.getCodec("peerset").cast<NetworkStatePeerset>();

  NetworkState(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "peerId": "Text",
              "listenedAddresses": "Vec<Text>",
              "externalAddresses": "Vec<Text>",
              "connectedPeers": "HashMap<Text, Peer>",
              "notConnectedPeers": "HashMap<Text, NotConnectedPeer>",
              "averageDownloadPerSec": "u64",
              "averageUploadPerSec": "u64",
              "peerset": "NetworkStatePeerset"
            },
            value,
            jsonMap);

  factory NetworkState.from(Struct origin) =>
      NetworkState(origin.registry, origin.originValue, origin.originJsonMap);
}

/// NetworkStatePeerset
class NetworkStatePeerset extends Struct {
  u64 get messageQueue => super.getCodec("messageQueue").cast<u64>();

  HashMap<CodecText, NetworkStatePeersetInfo> get nodes => super
      .getCodec("nodes")
      .cast<HashMap<CodecText, NetworkStatePeersetInfo>>();

  NetworkStatePeerset(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "messageQueue": "u64",
              "nodes": "HashMap<Text, NetworkStatePeersetInfo>"
            },
            value,
            jsonMap);

  factory NetworkStatePeerset.from(Struct origin) => NetworkStatePeerset(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// NetworkStatePeersetInfo
class NetworkStatePeersetInfo extends Struct {
  bool get connected => super.getCodec("connected").cast<CodecBool>().value;

  i32 get reputation => super.getCodec("reputation").cast<i32>();

  NetworkStatePeersetInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"connected": "bool", "reputation": "i32"}, value,
            jsonMap);

  factory NetworkStatePeersetInfo.from(Struct origin) =>
      NetworkStatePeersetInfo(
          origin.registry, origin.originValue, origin.originJsonMap);
}

/// NodeRole
class NodeRole extends Enum {
  bool get isFull => super.isKey("Full");

  bool get isLightClient => super.isKey("LightClient");

  bool get isAuthority => super.isKey("Authority");

  bool get isUnknownRole => super.isKey("UnknownRole");

  u8 get asUnknownRole => super.askey("UnknownRole").cast<u8>();

  NodeRole(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Full": "Null",
              "LightClient": "Null",
              "Authority": "Null",
              "UnknownRole": "u8"
            },
            value,
            index);

  factory NodeRole.from(Enum origin) =>
      NodeRole(origin.registry, origin.originValue, origin.originIndex);
}

/// NotConnectedPeer
class NotConnectedPeer extends Struct {
  Vec<CodecText> get knownAddresses =>
      super.getCodec("knownAddresses").cast<Vec<CodecText>>();

  Option<PeerPing> get latestPingTime =>
      super.getCodec("latestPingTime").cast<Option<PeerPing>>();

  Option<CodecText> get versionString =>
      super.getCodec("versionString").cast<Option<CodecText>>();

  NotConnectedPeer(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "knownAddresses": "Vec<Text>",
              "latestPingTime": "Option<PeerPing>",
              "versionString": "Option<Text>"
            },
            value,
            jsonMap);

  factory NotConnectedPeer.from(Struct origin) => NotConnectedPeer(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// Peer
class Peer extends Struct {
  bool get enabled => super.getCodec("enabled").cast<CodecBool>().value;

  PeerEndpoint get endpoint => super.getCodec("endpoint").cast<PeerEndpoint>();

  Vec<CodecText> get knownAddresses =>
      super.getCodec("knownAddresses").cast<Vec<CodecText>>();

  PeerPing get latestPingTime =>
      super.getCodec("latestPingTime").cast<PeerPing>();

  bool get open => super.getCodec("open").cast<CodecBool>().value;

  CodecText get versionString =>
      super.getCodec("versionString").cast<CodecText>();

  Peer(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "enabled": "bool",
              "endpoint": "PeerEndpoint",
              "knownAddresses": "Vec<Text>",
              "latestPingTime": "PeerPing",
              "open": "bool",
              "versionString": "Text"
            },
            value,
            jsonMap);

  factory Peer.from(Struct origin) =>
      Peer(origin.registry, origin.originValue, origin.originJsonMap);
}

/// PeerEndpoint
class PeerEndpoint extends Struct {
  PeerEndpointAddr get listening =>
      super.getCodec("listening").cast<PeerEndpointAddr>();

  PeerEndpoint(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"listening": "PeerEndpointAddr"}, value, jsonMap);

  factory PeerEndpoint.from(Struct origin) =>
      PeerEndpoint(origin.registry, origin.originValue, origin.originJsonMap);
}

/// PeerEndpointAddr
class PeerEndpointAddr extends Struct {
  CodecNull get alias => super.getCodec("_alias").cast<CodecNull>();

  CodecText get localAddr => super.getCodec("localAddr").cast<CodecText>();

  CodecText get sendBackAddr =>
      super.getCodec("sendBackAddr").cast<CodecText>();

  PeerEndpointAddr(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {"_alias": null, "localAddr": "Text", "sendBackAddr": "Text"},
            value,
            jsonMap);

  factory PeerEndpointAddr.from(Struct origin) => PeerEndpointAddr(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// PeerPing
class PeerPing extends Struct {
  u64 get nanos => super.getCodec("nanos").cast<u64>();

  u64 get secs => super.getCodec("secs").cast<u64>();

  PeerPing(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"nanos": "u64", "secs": "u64"}, value, jsonMap);

  factory PeerPing.from(Struct origin) =>
      PeerPing(origin.registry, origin.originValue, origin.originJsonMap);
}

/// PeerInfo
class PeerInfo extends Struct {
  CodecText get peerId => super.getCodec("peerId").cast<CodecText>();

  CodecText get roles => super.getCodec("roles").cast<CodecText>();

  u32 get protocolVersion => super.getCodec("protocolVersion").cast<u32>();

  Hash get bestHash => super.getCodec("bestHash").cast<Hash>();

  BlockNumber get bestNumber =>
      super.getCodec("bestNumber").cast<BlockNumber>();

  PeerInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "peerId": "Text",
              "roles": "Text",
              "protocolVersion": "u32",
              "bestHash": "Hash",
              "bestNumber": "BlockNumber"
            },
            value,
            jsonMap);

  factory PeerInfo.from(Struct origin) =>
      PeerInfo(origin.registry, origin.originValue, origin.originJsonMap);
}

/// PerDispatchClass
class PerDispatchClass extends Struct {
  WeightPerClass get normal => super.getCodec("normal").cast<WeightPerClass>();

  WeightPerClass get operational =>
      super.getCodec("operational").cast<WeightPerClass>();

  WeightPerClass get mandatory =>
      super.getCodec("mandatory").cast<WeightPerClass>();

  PerDispatchClass(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "normal": "WeightPerClass",
              "operational": "WeightPerClass",
              "mandatory": "WeightPerClass"
            },
            value,
            jsonMap);

  factory PerDispatchClass.from(Struct origin) => PerDispatchClass(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// Phase
class Phase extends Enum {
  bool get isApplyExtrinsic => super.isKey("ApplyExtrinsic");

  u32 get asApplyExtrinsic => super.askey("ApplyExtrinsic").cast<u32>();

  bool get isFinalization => super.isKey("Finalization");

  bool get isInitialization => super.isKey("Initialization");

  Phase(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "ApplyExtrinsic": "u32",
              "Finalization": "Null",
              "Initialization": "Null"
            },
            value,
            index);

  factory Phase.from(Enum origin) =>
      Phase(origin.registry, origin.originValue, origin.originIndex);
}

/// RawOrigin
class RawOrigin extends Enum {
  bool get isRoot => super.isKey("Root");

  bool get isSigned => super.isKey("Signed");

  AccountId get asSigned => super.askey("Signed").cast<AccountId>();

  bool get isNone => super.isKey("None");

  RawOrigin(Registry registry, [dynamic value, int index])
      : super(registry, {"Root": "Null", "Signed": "AccountId", "None": "Null"},
            value, index);

  factory RawOrigin.from(Enum origin) =>
      RawOrigin(origin.registry, origin.originValue, origin.originIndex);
}

/// RefCount
class RefCount extends u32 {
  RefCount(Registry registry, [dynamic value]) : super(registry, value);

  factory RefCount.from(u32 origin) =>
      RefCount(origin.registry, origin.originValue);
}

/// RefCountTo259
class RefCountTo259 extends u8 {
  RefCountTo259(Registry registry, [dynamic value]) : super(registry, value);

  factory RefCountTo259.from(u8 origin) =>
      RefCountTo259(origin.registry, origin.originValue);
}

/// SyncState
class SyncState extends Struct {
  BlockNumber get startingBlock =>
      super.getCodec("startingBlock").cast<BlockNumber>();

  BlockNumber get currentBlock =>
      super.getCodec("currentBlock").cast<BlockNumber>();

  Option<BlockNumber> get highestBlock =>
      super.getCodec("highestBlock").cast<Option<BlockNumber>>();

  SyncState(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "startingBlock": "BlockNumber",
              "currentBlock": "BlockNumber",
              "highestBlock": "Option<BlockNumber>"
            },
            value,
            jsonMap);

  factory SyncState.from(Struct origin) =>
      SyncState(origin.registry, origin.originValue, origin.originJsonMap);
}

/// SystemOrigin
class SystemOrigin extends RawOrigin {
  SystemOrigin(Registry registry, [dynamic value, int index])
      : super(registry, value, index);

  factory SystemOrigin.from(Enum origin) =>
      SystemOrigin(origin.registry, origin.originValue, origin.originIndex);
}

/// TransactionValidityError
class TransactionValidityError extends Enum {
  bool get isInvalid => super.isKey("Invalid");

  InvalidTransaction get asInvalid =>
      super.askey("Invalid").cast<InvalidTransaction>();

  bool get isUnknown => super.isKey("Unknown");

  UnknownTransaction get asUnknown =>
      super.askey("Unknown").cast<UnknownTransaction>();

  TransactionValidityError(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {"Invalid": "InvalidTransaction", "Unknown": "UnknownTransaction"},
            value,
            index);

  factory TransactionValidityError.from(Enum origin) =>
      TransactionValidityError(
          origin.registry, origin.originValue, origin.originIndex);
}

/// UnknownTransaction
class UnknownTransaction extends Enum {
  bool get isCannotLookup => super.isKey("CannotLookup");

  bool get isNoUnsignedValidator => super.isKey("NoUnsignedValidator");

  bool get isCustom => super.isKey("Custom");

  u8 get asCustom => super.askey("Custom").cast<u8>();

  UnknownTransaction(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "CannotLookup": "Null",
              "NoUnsignedValidator": "Null",
              "Custom": "u8"
            },
            value,
            index);

  factory UnknownTransaction.from(Enum origin) => UnknownTransaction(
      origin.registry, origin.originValue, origin.originIndex);
}

/// WeightPerClass
class WeightPerClass extends Struct {
  Weight get baseExtrinsic => super.getCodec("baseExtrinsic").cast<Weight>();

  Weight get maxExtrinsic => super.getCodec("maxExtrinsic").cast<Weight>();

  Option<Weight> get maxTotal =>
      super.getCodec("maxTotal").cast<Option<Weight>>();

  Option<Weight> get reserved =>
      super.getCodec("reserved").cast<Option<Weight>>();

  WeightPerClass(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "baseExtrinsic": "Weight",
              "maxExtrinsic": "Weight",
              "maxTotal": "Option<Weight>",
              "reserved": "Option<Weight>"
            },
            value,
            jsonMap);

  factory WeightPerClass.from(Struct origin) =>
      WeightPerClass(origin.registry, origin.originValue, origin.originJsonMap);
}
