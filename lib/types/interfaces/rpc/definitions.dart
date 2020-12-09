final defs = {
  "rpc": {
    "methods": {
      "description": "Retrieves the list of RPC methods that are exposed by the node",
      "params": [],
      "type": "RpcMethods"
    }
  },
  "types": {
    "RpcMethods": {"version": "u32", "methods": "Vec<Text>"}
  }
};
