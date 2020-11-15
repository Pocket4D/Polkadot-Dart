import 'package:p4d_rust_binding/rpc/types.dart';

class JsonChain {
  static final JsonRpcMethodOpt getHeader = JsonRpcMethodOpt(
      description: "Retrieves the header for a specific block",
      params: List.from([JsonRpcParam("hash", "Hash", true)]),
      type: "Header");

  static final JsonRpcMethodOpt getBlock = JsonRpcMethodOpt(
      description: "Get header and body of a relay chain block",
      params: List.from([JsonRpcParam("hash", "Hash", true)]),
      type: "SignedBlock");

  static final JsonRpcMethodOpt getBlockHash = JsonRpcMethodOpt(
      description: "Get the block hash for a specific block",
      params: List.from([JsonRpcParam("blockNumber", "BlockNumber", true)]),
      type: "Hash");

  static final JsonRpcMethodOpt getFinalizedHead = JsonRpcMethodOpt(
      description: "Get hash of the last finalised block in the canon chain",
      params: List<JsonRpcParam>(),
      type: "Hash");

  static final JsonRpcMethodOpt getRuntimeVersion = JsonRpcMethodOpt(
      description: "Get the runtime version (alias of state_getRuntimeVersion)",
      params: List.from([JsonRpcParam("hash", "Hash", true)]),
      type: "RuntimeVersion");

  static final JsonRpcMethodOpt subscribeNewHead = JsonRpcMethodOpt(
      description: "Retrieves the best header via subscription",
      params: List<JsonRpcParam>(),
      pubsub: ["newHead", "subscribeNewHead", "unsubscribeNewHead"],
      type: "Header");

  static final JsonRpcMethodOpt subscribeFinalizedHeads = JsonRpcMethodOpt(
      description: "Retrieves the best finalized header via subscription",
      params: List<JsonRpcParam>(),
      pubsub: ["finalizedHead", "subscribeFinalisedHeads", "unsubscribeFinalisedHeads"],
      type: "Header");

  static final JsonRpcMethodOpt subscribeRuntimeVersion = JsonRpcMethodOpt(
      description: "Retrieves the runtime version via subscription",
      params: List<JsonRpcParam>(),
      pubsub: ["runtimeVersion", "subscribeRuntimeVersion", "unsubscribeRuntimeVersion"],
      type: "RuntimeVersion");

  static final String section = "chain";

  static final Map<String, JsonRpcMethod> methods = Map.fromEntries([
    MapEntry("getHeader", JsonRpcMethod(getHeader, section, "getHeader")),
    MapEntry("getBlock", JsonRpcMethod(getBlock, section, "getBlock")),
    MapEntry("getBlockHash", JsonRpcMethod(getBlockHash, section, "getBlockHash")),
    MapEntry("getFinalizedHead", JsonRpcMethod(getFinalizedHead, section, "getFinalizedHead")),
    MapEntry("getRuntimeVersion", JsonRpcMethod(getRuntimeVersion, section, "getRuntimeVersion")),
    MapEntry("subscribeNewHead", JsonRpcMethod(subscribeNewHead, section, "subscribeNewHead")),
    MapEntry("subscribeFinalizedHeads",
        JsonRpcMethod(subscribeFinalizedHeads, section, "subscribeFinalizedHeads")),
    MapEntry("subscribeRuntimeVersion",
        JsonRpcMethod(subscribeRuntimeVersion, section, "subscribeRuntimeVersion"))
  ]);

  static final JsonRpcSection chain =
      JsonRpcSection(false, false, "Retrieval of chain data", section, methods);
}
