import 'package:p4d_rust_binding/rpc/types.dart';

class JsonAuthor {
  static final JsonRpcMethodOpt pendingExtrinsics = new JsonRpcMethodOpt(
      description: "Returns all pending extrinsics, potentially grouped by sender",
      type: "PendingExtrinsics");
  static final JsonRpcMethodOpt submitExtrinsic = new JsonRpcMethodOpt(
      description: "Submit a fully formatted extrinsic for block inclusion",
      params: List.from([JsonRpcParam("extrinsic", "Extrinsic")]),
      type: "Hash",
      isSigned: true);
  static final JsonRpcMethodOpt submitAndWatchExtrinsic = JsonRpcMethodOpt(
      description: "Subscribe and watch an extrinsic until unsubscribed",
      params: List.from([JsonRpcParam("extrinsic", "Extrinsic")]),
      pubsub: List<String>.from(["extrinsicUpdate", "submitAndWatchExtrinsic", "unwatchExtrinsic"]),
      type: "ExtrinsicStatus",
      isSigned: true);
  static final String section = "author";
  static final Map<String, JsonRpcMethod> methods = Map.fromEntries([
    MapEntry("pendingExtrinsics", JsonRpcMethod(pendingExtrinsics, section, "pendingExtrinsics")),
    MapEntry("submitExtrinsic", JsonRpcMethod(submitExtrinsic, section, "submitExtrinsic")),
    MapEntry("submitAndWatchExtrinsic",
        JsonRpcMethod(submitAndWatchExtrinsic, section, "submitAndWatchExtrinsic"))
  ]);
  static final JsonRpcSection author =
      JsonRpcSection(false, false, "Authoring of network items", section, methods);
}
