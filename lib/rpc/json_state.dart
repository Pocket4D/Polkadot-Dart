import 'package:p4d_rust_binding/rpc/types.dart';

class JsonState {
  static final JsonRpcMethodOpt call = JsonRpcMethodOpt(
      description: "Perform a call to a builtin on the chain",
      params: List.from([
        JsonRpcParam("method", "Text"),
        JsonRpcParam("data", "Bytes"),
        JsonRpcParam("block", "Hash", true)
      ]),
      type: "Bytes");

  static final JsonRpcMethodOpt getStorage = JsonRpcMethodOpt(
      description: "Retrieves the storage for a key",
      params: List.from([JsonRpcParam("key", "StorageKey"), JsonRpcParam("block", "Hash", true)]),
      type: "StorageData");

  static final JsonRpcMethodOpt getStorageHash = JsonRpcMethodOpt(
      description: "Retrieves the storage hash",
      params: List.from([JsonRpcParam("key", "StorageKey"), JsonRpcParam("block", "Hash", true)]),
      type: "Hash");

  static final JsonRpcMethodOpt getStorageSize = JsonRpcMethodOpt(
      description: "Retrieves the storage size",
      params: List.from([JsonRpcParam("key", "StorageKey"), JsonRpcParam("block", "Hash", true)]),
      type: "u64");

  static final JsonRpcMethodOpt getMetadata = JsonRpcMethodOpt(
      description: "Returns the runtime metadata",
      params: List.from([JsonRpcParam("block", "Hash", true)]),
      type: "Metadata");

  static final JsonRpcMethodOpt getRuntimeVersion = JsonRpcMethodOpt(
      description: "Get the runtime version",
      params: List.from([JsonRpcParam("block", "Hash", true)]),
      type: "RuntimeVersion");

  static final JsonRpcMethodOpt queryStorage = JsonRpcMethodOpt(
      description: "Query historical storage entries (by key) starting from a start block",
      params: List.from([
        // @ts-ignore The Vec<> wrap is fine
        JsonRpcParam("keys", "Vec<StorageKey>"),
        JsonRpcParam("startBlock", "Hash"),
        JsonRpcParam("block", "Hash", true)
      ]),
      // @ts-ignore The Vec<> wrap is fine
      type: "Vec<StorageChangeSet>");

  static final JsonRpcMethodOpt subscribeStorage = JsonRpcMethodOpt(
      description: "Subscribes to storage changes for the provided keys",
      params: List.from([
        // @ts-ignore The Vec<> wrap is fine
        JsonRpcParam("keys", "Vec<StorageKey>")
      ]),
      pubsub: ["storage", "subscribeStorage", "unsubscribeStorage"],
      type: "StorageChangeSet");

  static final String section = "state";

  static final Map<String, JsonRpcMethod> methods = Map.fromEntries([
    MapEntry("call", JsonRpcMethod(call, section, "call")),
    MapEntry("getStorage", JsonRpcMethod(getStorage, section, "getStorage")),
    MapEntry("getStorageHash", JsonRpcMethod(getStorageHash, section, "getStorageHash")),
    MapEntry("getStorageSize", JsonRpcMethod(getStorageSize, section, "getStorageSize")),
    MapEntry("getMetadata", JsonRpcMethod(getMetadata, section, "getMetadata")),
    MapEntry("getRuntimeVersion", JsonRpcMethod(getRuntimeVersion, section, "getRuntimeVersion")),
    MapEntry("queryStorage", JsonRpcMethod(queryStorage, section, "queryStorage")),
    MapEntry("subscribeStorage", JsonRpcMethod(subscribeStorage, section, "subscribeStorage")),
  ]);

  static final JsonRpcSection state =
      JsonRpcSection(false, false, "Query of state", section, methods);
}
