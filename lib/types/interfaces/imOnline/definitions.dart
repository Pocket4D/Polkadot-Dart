final defs = {
  "rpc": {},
  "types": {
    "AuthIndex": "u32",
    "AuthoritySignature": "Signature",
    "Heartbeat": {
      "blockNumber": "BlockNumber",
      "networkState": "OpaqueNetworkState",
      "sessionIndex": "SessionIndex",
      "authorityIndex": "AuthIndex",
      "validatorsLen": "u32"
    },
    "HeartbeatTo244": {
      "blockNumber": "BlockNumber",
      "networkState": "OpaqueNetworkState",
      "sessionIndex": "SessionIndex",
      "authorityIndex": "AuthIndex"
    },
    "OpaqueMultiaddr": "Bytes",
    "OpaquePeerId": "Bytes",
    "OpaqueNetworkState": {"peerId": "OpaquePeerId", "externalAddresses": "Vec<OpaqueMultiaddr>"}
  }
};
