final defs = {
  "rpc": {
    "proveFinality": {
      "description": "Prove finality for the range (begin; end] hash.",
      "params": [
        {"name": "begin", "type": "BlockHash"},
        {"name": "end", "type": "BlockHash"},
        {"name": "authoritiesSetId", "type": "u64", "isOptional": true}
      ],
      "type": "Option<EncodedFinalityProofs>"
    },
    "roundState": {
      "description":
          "Returns the state of the current best round state as well as the ongoing background rounds",
      "params": [],
      "type": "ReportedRoundStates"
    },
    "subscribeJustifications": {
      "description": "Subscribes to grandpa justifications",
      "params": [],
      "pubsub": ["justifications", "subscribeJustifications", "unsubscribeJustifications"],
      "type": "JustificationNotification"
    }
  },
  "types": {
    "AuthorityIndex": "u64",
    "AuthorityList": "Vec<NextAuthority>",
    "AuthorityWeight": "u64",
    "EncodedFinalityProofs": "Bytes",
    "GrandpaEquivocation": {
      "_enum": {"Prevote": "GrandpaEquivocationValue", "Precommit": "GrandpaEquivocationValue"}
    },
    "GrandpaEquivocationProof": {"setId": "SetId", "equivocation": "GrandpaEquivocation"},
    "GrandpaEquivocationValue": {
      "roundNumber": "u64",
      "identity": "AuthorityId",
      "first": "(GrandpaPrevote, AuthoritySignature)",
      "second": "(GrandpaPrevote, AuthoritySignature)"
    },
    "GrandpaPrevote": {"targetHash": "Hash", "targetNumber": "BlockNumber"},
    "JustificationNotification": "Bytes",
    "KeyOwnerProof": "MembershipProof",
    "NextAuthority": "(AuthorityId, AuthorityWeight)",
    "PendingPause": {"scheduledAt": "BlockNumber", "delay": "BlockNumber"},
    "PendingResume": {"scheduledAt": "BlockNumber", "delay": "BlockNumber"},
    "Precommits": {"currentWeight": "u32", "missing": "BTreeSet<AuthorityId>"},
    "Prevotes": {"currentWeight": "u32", "missing": "BTreeSet<AuthorityId>"},
    "ReportedRoundStates": {"setId": "u32", "best": "RoundState", "background": "Vec<RoundState>"},
    "RoundState": {
      "round": "u32",
      "totalWeight": "u32",
      "thresholdWeight": "u32",
      "prevotes": "Prevotes",
      "precommits": "Precommits"
    },
    "SetId": "u64",
    "StoredPendingChange": {
      "scheduledAt": "BlockNumber",
      "delay": "BlockNumber",
      "nextAuthorities": "AuthorityList"
    },
    "StoredState": {
      "_enum": {
        "Live": "Null",
        "PendingPause": "PendingPause",
        "Paused": "Null",
        "PendingResume": "PendingResume"
      }
    }
  }
};
