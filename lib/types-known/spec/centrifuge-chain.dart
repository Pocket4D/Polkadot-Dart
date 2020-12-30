const sharedTypes = {
  "Address": "LookupSource",
  "LookupSource": "IndicesLookupSource",
  "AnchorData": {"anchoredBlock": "u64", "docRoot": "H256", "id": "H256"},
  "ChainId": "u8",
  "DepositNonce": "u64",
  "Fee": {"key": "Hash", "price": "Balance"},
  "MultiAccountData": {
    "deposit": "Balance",
    "depositor": "AccountId",
    "signatories": "Vec<AccountId>",
    "threshold": "u16"
  },
  "Multiplier": "Fixed64",
  "PreCommitData": {"expirationBlock": "u64", "identity": "H256", "signingRoot": "H256"},
  "Proof": {"leafHash": "H256", "sortedHashes": "H256"},
  "ResourceId": "[u8; 32]",
  "chainbridge::ChainId": "u8"
};

const versioned = [
  {
    "minmax": [229, 234],
    "types": {
      ...sharedTypes,
      "RefCount": "RefCountTo259",
      "ReferendumInfo": "ReferendumInfoTo239",
      "StakingLedger": "StakingLedgerTo240",
      "Weight": "u32"
    }
  },
  {
    "minmax": [235, null],
    "types": {...sharedTypes, "RefCount": "RefCountTo259"}
  }
];
