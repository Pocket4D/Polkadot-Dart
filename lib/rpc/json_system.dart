import 'package:p4d_rust_binding/rpc/types.dart';

class JsonSystem {
  static final JsonRpcMethodOpt name =
      new JsonRpcMethodOpt(description: "Retrieves the node name", type: "Text");

  static final JsonRpcMethodOpt version =
      new JsonRpcMethodOpt(description: "Retrieves the version of the node", type: "Text");

  static final JsonRpcMethodOpt chain =
      new JsonRpcMethodOpt(description: "Retrieves the chain", type: "Text");

  static final JsonRpcMethodOpt properties = new JsonRpcMethodOpt(
      description: "Get a custom set of properties as a JSON object, defined in the chain spec",
      type: "ChainProperties");

  static final JsonRpcMethodOpt health =
      new JsonRpcMethodOpt(description: "Return health status of the node", type: "Health");

  static final JsonRpcMethodOpt peers = new JsonRpcMethodOpt(
      description: "Returns the currently connected peers", type: "Vec<PeerInfo>");

  static final JsonRpcMethodOpt networkState = new JsonRpcMethodOpt(
      description: "Returns current state of the network", type: "NetworkState");

  static final String section = "system";

  static final Map<String, JsonRpcMethod> methods = Map.fromEntries([
    MapEntry("name", new JsonRpcMethod(name, section, "name")),
    MapEntry("version", new JsonRpcMethod(version, section, "version")),
    MapEntry("chain", new JsonRpcMethod(chain, section, "chain")),
    MapEntry("properties", new JsonRpcMethod(properties, section, "properties")),
    MapEntry("health", new JsonRpcMethod(health, section, "health")),
    MapEntry("peers", new JsonRpcMethod(peers, section, "peers")),
    MapEntry("networkState", new JsonRpcMethod(networkState, section, "networkState")),
  ]);

  static final JsonRpcSection system =
      new JsonRpcSection(false, false, "Methods to retrieve system info", section, methods);
}
