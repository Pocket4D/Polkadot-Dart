const defs = {
  "rpc": {
    "queryInfo": {
      "description": "Retrieves the fee information for an encoded extrinsic",
      "params": [
        {"name": "extrinsic", "type": "Bytes"},
        {"name": "at", "type": "BlockHash", "isHistoric": true, "isOptional": true}
      ],
      "type": "RuntimeDispatchInfo"
    }
  },
  "types": {
    "RuntimeDispatchInfo": {"weight": "Weight", "class": "DispatchClass", "partialFee": "Balance"}
  }
};
