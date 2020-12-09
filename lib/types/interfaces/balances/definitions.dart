final defs = {
  "rpc": {},
  "types": {
    "AccountData": {
      "free": "Balance",
      "reserved": "Balance",
      "miscFrozen": "Balance",
      "feeFrozen": "Balance"
    },
    "BalanceLockTo212": {
      "id": "LockIdentifier",
      "amount": "Balance",
      "until": "BlockNumber",
      "reasons": "WithdrawReasons"
    },
    "BalanceLock": {"id": "LockIdentifier", "amount": "Balance", "reasons": "Reasons"},
    "BalanceStatus": {
      "_enum": ["Free", "Reserved"]
    },
    "Reasons": {
      "_enum": ["Fee", "Misc", "All"]
    },
    "VestingSchedule": {"offset": "Balance", "perBlock": "Balance", "startingBlock": "BlockNumber"},
    "WithdrawReasons": {
      "_set": {"TransactionPayment": 1, "Transfer": 2, "Reserve": 4, "Fee": 8, "Tip": 16}
    }
  }
};
