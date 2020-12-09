final defs = {
  "rpc": {},
  "types": {
    "Bid": {"who": "AccountId", "kind": "BidKind", "value": "Balance"},
    "BidKind": {
      "_enum": {"Deposit": "Balance", "Vouch": "(AccountId, Balance)"}
    },
    "SocietyJudgement": {
      "_enum": ["Rebid", "Reject", "Approve"]
    },
    "SocietyVote": {
      "_enum": ["Skeptic", "Reject", "Approve"]
    },
    "StrikeCount": "u32",
    "VouchingStatus": {
      "_enum": ["Vouching", "Banned"]
    }
  }
};
