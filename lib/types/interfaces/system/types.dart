import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

/** @name AccountInfo */
// class AccountInfo extends Struct {
//   get nonce: Index;
//   get refcount: RefCount;
//   get data: AccountData;
// }

// /** @name ApplyExtrinsicResult */
// class ApplyExtrinsicResult extends Result<DispatchOutcome, TransactionValidityError> {
//   get isError: boolean;
//   get asError: TransactionValidityError;
//   get isOk: boolean;
//   get asOk: DispatchOutcome;
// }

class BlockWeights<S extends Map<String, dynamic>> extends Struct {
  BlockWeights(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory BlockWeights.from(Struct origin) =>
      BlockWeights(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Weight get baseBlock => super.getCodec("baseBlock").cast<Weight>();
  Weight get maxBlock => super.getCodec("maxBlock").cast<Weight>();
  PerDispatchClass get perClass => super.getCodec("perClass").cast<PerDispatchClass>();
}

class ChainProperties<S extends Map<String, dynamic>> extends Struct {
  ChainProperties(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ChainProperties.from(Struct origin) => ChainProperties(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Option<u8> get ss58Format => super.getCodec("ss58Format").cast<Option<u8>>();
  Option<u32> get tokenDecimals => super.getCodec("tokenDecimals").cast<Option<u32>>();
  Option<CodecText> get tokenSymbol => super.getCodec("tokenSymbol").cast<Option<CodecText>>();
}

// /** @name ChainType */
class ChainType extends Enum {
  ChainType(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory ChainType.from(Enum origin) =>
      ChainType(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isDevelopment => super.isKey("Development");
  bool get isLocal => super.isKey("Local");
  bool get isLive => super.isKey("Live");
  bool get isCustom => super.isKey("Custom");
  CodecText get asCustom => super.askey("Custom").cast<CodecText>();
}

// /** @name ConsumedWeight */
class ConsumedWeight<S extends Map<String, dynamic>> extends PerDispatchClass {
  ConsumedWeight(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ConsumedWeight.from(Struct origin) =>
      ConsumedWeight(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// /** @name DigestOf */
// class DigestOf extends Digest {}

// /** @name DispatchClass */

class DispatchClass extends Enum {
  DispatchClass(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory DispatchClass.from(Enum origin) =>
      DispatchClass(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isNormal => super.isKey("Normal");
  bool get isOperational => super.isKey("Operational");
  bool get isMandatory => super.isKey("Mandatory");
}

class DispatchError extends Enum {
  DispatchError(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory DispatchError.from(Enum origin) =>
      DispatchError(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isOther => super.isKey("Other");
  bool get isCannotLookup => super.isKey("CannotLookup");
  bool get isBadOrigin => super.isKey("BadOrigin");
  bool get isModule => super.isKey("Module");
  DispatchErrorModule get asModule => super.askey("Module").cast<DispatchErrorModule>();
}

class DispatchErrorModule<S extends Map<String, dynamic>> extends Struct {
  DispatchErrorModule(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DispatchErrorModule.from(Struct origin) => DispatchErrorModule(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  u8 get index => super.getCodec("index").cast<u8>();
  u8 get error => super.getCodec("error").cast<u8>();
}

class DispatchErrorTo198<S extends Map<String, dynamic>> extends Struct {
  DispatchErrorTo198(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DispatchErrorTo198.from(Struct origin) => DispatchErrorTo198(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Option<u8> get module => super.getCodec("module").cast<Option<u8>>();
  u8 get error => super.getCodec("error").cast<u8>();
}

class DispatchInfo<S extends Map<String, dynamic>> extends Struct {
  DispatchInfo(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DispatchInfo.from(Struct origin) =>
      DispatchInfo(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Weight get weight => super.getCodec("weight").cast<Weight>();
  // class is reserved word in dart
  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();
  Pays get paysFee => super.getCodec("paysFee").cast<Pays>();
}

class DispatchInfoTo190<S extends Map<String, dynamic>> extends Struct {
  DispatchInfoTo190(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DispatchInfoTo190.from(Struct origin) => DispatchInfoTo190(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Weight get weight => super.getCodec("weight").cast<Weight>();
  // class is reserved word in dart
  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();
}

// /** @name DispatchInfoTo244 */
// class DispatchInfoTo244 extends Struct {
//   get weight: Weight;
//   get class: DispatchClass;
//   get paysFee: bool;
// }

class DispatchInfoTo244<S extends Map<String, dynamic>> extends Struct {
  DispatchInfoTo244(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DispatchInfoTo244.from(Struct origin) => DispatchInfoTo244(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Weight get weight => super.getCodec("weight").cast<Weight>();
  // class is reserved word in dart
  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();
  bool get paysFee => (super.getCodec("paysFee").cast<CodecBool>()).value;
}

// /** @name DispatchOutcome */
// class DispatchOutcome extends Result<ITuple<[]>, DispatchError> {
//   get isError: boolean;
//   get asError: DispatchError;
//   get isOk: boolean;
//   get asOk: ITuple<[]>;
// }

// /** @name DispatchResult */
// class DispatchResult extends Result<ITuple<[]>, DispatchError> {
//   get isError: boolean;
//   get asError: DispatchError;
//   get isOk: boolean;
//   get asOk: ITuple<[]>;
// }

// /** @name DispatchResultOf */
// class DispatchResultOf extends DispatchResult {}

// /** @name DispatchResultTo198 */
// class DispatchResultTo198 extends Result<ITuple<[]>, Text> {
//   get isError: boolean;
//   get asError: Text;
//   get isOk: boolean;
//   get asOk: ITuple<[]>;
// }

// /** @name Event */
// class Event extends GenericEvent {}

class EventId extends U8aFixed {
  EventId(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory EventId.from(U8aFixed origin) {
    return EventId(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

class EventIndex extends u32 {
  EventIndex(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory EventIndex.from(u32 origin) {
    return EventIndex(origin.registry, origin.value);
  }
}

// /** @name EventRecord */
// class EventRecord extends Struct {
//   get phase: Phase;
//   get event: Event;
//   get topics: Vec<Hash>;
// }

class Health<S extends Map<String, dynamic>> extends Struct {
  Health(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory Health.from(Struct origin) =>
      Health(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  u64 get peers => super.getCodec("peers").cast<u64>();
  bool get isSyncing => (super.getCodec("isSyncing").cast<CodecBool>()).value;
  bool get shouldHavePeers => (super.getCodec("shouldHavePeers").cast<CodecBool>()).value;
}

// /** @name InvalidTransaction */
class InvalidTransaction extends Enum {
  InvalidTransaction(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory InvalidTransaction.from(Enum origin) =>
      InvalidTransaction(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
}

class Key extends Bytes {
  Key(Registry registry, [dynamic value]) : super(registry, value);
  factory Key.from(Bytes origin) => Key(origin.registry, origin.value);
}

class LastRuntimeUpgradeInfo<S extends Map<String, dynamic>> extends Struct {
  LastRuntimeUpgradeInfo(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory LastRuntimeUpgradeInfo.from(Struct origin) => LastRuntimeUpgradeInfo(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Compact<u32> get specVersion => super.getCodec("specVersion").cast<Compact<u32>>();
  CodecText get specName => super.getCodec("specName").cast<CodecText>();
}

class NetworkState<S extends Map<String, dynamic>> extends Struct {
  NetworkState(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory NetworkState.from(Struct origin) =>
      NetworkState(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  CodecText get peerId => super.getCodec("peerId").cast<CodecText>();
  Vec<CodecText> get listenedAddresses =>
      super.getCodec("listenedAddresses").cast<Vec<CodecText>>();
  Vec<CodecText> get externalAddresses =>
      super.getCodec("externalAddresses").cast<Vec<CodecText>>();
  HashMap<CodecText, Peer> get connectedPeers =>
      super.getCodec("connectedPeers").cast<HashMap<CodecText, Peer>>();
  HashMap<CodecText, NotConnectedPeer> get notConnectedPeers =>
      super.getCodec("notConnectedPeers").cast<HashMap<CodecText, NotConnectedPeer>>();
  u64 get averageDownloadPerSec => super.getCodec("averageDownloadPerSec").cast<u64>();
  NetworkStatePeerset get peerset => super.getCodec("peerset").cast<NetworkStatePeerset>();
}

class NetworkStatePeerset<S extends Map<String, dynamic>> extends Struct {
  NetworkStatePeerset(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory NetworkStatePeerset.from(Struct origin) => NetworkStatePeerset(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  u64 get messageQueue => super.getCodec("messageQueue").cast<u64>();
  HashMap<CodecText, NetworkStatePeersetInfo> get nodes =>
      super.getCodec("nodes").cast<HashMap<CodecText, NetworkStatePeersetInfo>>();
}

class NetworkStatePeersetInfo<S extends Map<String, dynamic>> extends Struct {
  NetworkStatePeersetInfo(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory NetworkStatePeersetInfo.from(Struct origin) => NetworkStatePeersetInfo(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  bool get connected => (super.getCodec("connected").cast<CodecBool>()).value;
  i32 get reputation => super.getCodec("reputation").cast<i32>();
}

class NodeRole extends Enum {
  NodeRole(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory NodeRole.from(Enum origin) =>
      NodeRole(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isFull => super.isKey("Full");
  bool get isLightClient => super.isKey("LightClient");
  bool get isAuthority => super.isKey("Authority");
  bool get isUnknownRole => super.isKey("UnknownRole");
  u8 get asUnknownRole => super.askey("UnknownRole").cast<u8>();
}

class NotConnectedPeer<S extends Map<String, dynamic>> extends Struct {
  NotConnectedPeer(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory NotConnectedPeer.from(Struct origin) => NotConnectedPeer(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  Vec<CodecText> get knownAddresses => super.getCodec("knownAddresses").cast<Vec<CodecText>>();
  PeerPing get latestPingTime => super.getCodec("latestPingTime").cast<PeerPing>();
  CodecText get versionString => super.getCodec("versionString").cast<CodecText>();
}

class Peer<S extends Map<String, dynamic>> extends Struct {
  Peer(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory Peer.from(Struct origin) =>
      Peer(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  bool get enabled => (super.getCodec("enabled").cast<CodecBool>()).value;
  PeerEndpoint get endpoint => super.getCodec("endpoint").cast<PeerEndpoint>();
  Vec<CodecText> get knownAddresses => super.getCodec("knownAddresses").cast<Vec<CodecText>>();
  PeerPing get latestPingTime => super.getCodec("latestPingTime").cast<PeerPing>();
  bool get open => (super.getCodec("open").cast<CodecBool>()).value;
  CodecText get versionString => super.getCodec("versionString").cast<CodecText>();
}

class PeerEndpoint<S extends Map<String, dynamic>> extends Struct {
  PeerEndpoint(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PeerEndpoint.from(Struct origin) =>
      PeerEndpoint(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
  PeerEndpointAddr get listening => super.getCodec("listening").cast<PeerEndpointAddr>();
}

class PeerEndpointAddr<S extends Map<String, dynamic>> extends Struct {
  PeerEndpointAddr(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PeerEndpointAddr.from(Struct origin) => PeerEndpointAddr(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  CodecText get localAddr => super.getCodec("localAddr").cast<CodecText>();
  CodecText get sendBackAddr => super.getCodec("sendBackAddr").cast<CodecText>();
}

class PeerInfo<S extends Map<String, dynamic>> extends Struct {
  PeerInfo(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PeerInfo.from(Struct origin) =>
      PeerInfo(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  CodecText get peerId => super.getCodec("peerId").cast<CodecText>();
  CodecText get roles => super.getCodec("roles").cast<CodecText>();
  u32 get protocolVersion => super.getCodec("protocolVersion").cast<u32>();
  Hash get bestHash => super.getCodec("bestHash").cast<Hash>();
  BlockNumber get bestNumber => super.getCodec("bestNumber").cast<BlockNumber>();
}

class PeerPing<S extends Map<String, dynamic>> extends Struct {
  PeerPing(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PeerPing.from(Struct origin) =>
      PeerPing(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  u64 get nanos => super.getCodec("nanos").cast<u64>();
  u64 get secs => super.getCodec("secs").cast<u64>();
}

class PerDispatchClass<S extends Map<String, dynamic>> extends Struct {
  PerDispatchClass(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PerDispatchClass.from(Struct origin) => PerDispatchClass(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  WeightPerClass get normal => super.getCodec("normal").cast<WeightPerClass>();
  WeightPerClass get operational => super.getCodec("operational").cast<WeightPerClass>();
  WeightPerClass get mandatory => super.getCodec("mandatory").cast<WeightPerClass>();
}

class Phase extends Enum {
  Phase(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory Phase.from(Enum origin) =>
      Phase(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isApplyExtrinsic => super.isKey("ApplyExtrinsic");
  u32 get asApplyExtrinsic => super.askey("ApplyExtrinsic").cast<u32>();
  bool get isFinalization => super.isKey("Finalization");
  bool get isInitialization => super.isKey("Initialization");
}

class RawOrigin extends Enum {
  RawOrigin(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory RawOrigin.from(Enum origin) =>
      RawOrigin(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isSigned => super.isKey("Signed");
  AccountId get asSigned => super.askey("asSigned").cast<AccountId>();
  bool get isRoot => super.isKey("Root");
  bool get isNone => super.isKey("None");
}

class RefCount extends u32 {
  RefCount(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory RefCount.from(u32 origin) {
    return RefCount(origin.registry, origin.value);
  }
}

class RefCountTo256 extends u8 {
  RefCountTo256(Registry registry, [dynamic value = 0]) : super(registry, value);
  factory RefCountTo256.from(u8 origin) {
    return RefCountTo256(origin.registry, origin.value);
  }
}

class SyncState<S extends Map<String, dynamic>> extends Struct {
  SyncState(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory SyncState.from(Struct origin) =>
      SyncState(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  BlockNumber get startingBlock => super.getCodec("startingBlock").cast<BlockNumber>();
  BlockNumber get currentBlock => super.getCodec("currentBlock").cast<BlockNumber>();
  Option<BlockNumber> get highestBlock =>
      super.getCodec("highestBlock").cast<Option<BlockNumber>>();
}

// /** @name SystemOrigin */
class SystemOrigin extends RawOrigin {
  SystemOrigin(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory SystemOrigin.from(Enum origin) =>
      SystemOrigin(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

// /** @name TransactionValidityError */
class TransactionValidityError extends Enum {
  bool get isInvalid => super.isKey("Invalid");
  InvalidTransaction get asInvalid => super.askey("Invalid");
  bool get isUnknown => super.isKey("Unknown");
  UnknownTransaction get asUnknown => super.askey("Unknown");

  TransactionValidityError(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory TransactionValidityError.from(Enum origin) =>
      TransactionValidityError(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

class UnknownTransaction extends Enum {
  UnknownTransaction(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory UnknownTransaction.from(Enum origin) =>
      UnknownTransaction(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isCannotLookup => super.isKey("CannotLookup");
  bool get isNoUnsignedValidator => super.isKey("NoUnsignedValidator");
  bool get isCustom => super.isKey("Custom");
  u8 get asCustom => super.askey("Custom").cast<u8>();
}

class WeightPerClass<S extends Map<String, dynamic>> extends Struct {
  WeightPerClass(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory WeightPerClass.from(Struct origin) =>
      WeightPerClass(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);

  Weight get baseExtrinsic => super.getCodec("baseExtrinsic").cast<Weight>();
  Weight get maxExtrinsic => super.getCodec("maxExtrinsic").cast<Weight>();
  Option<Weight> get maxTotal => super.getCodec("maxTotal").cast<Option<Weight>>();
  Option<Weight> get reserved => super.getCodec("reserved").cast<Option<Weight>>();
}

const PHANTOM_SYSTEM = 'system';
