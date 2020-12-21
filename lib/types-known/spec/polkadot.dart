const sharedTypes = {
  "Address": "AccountId",
  "Keys": "SessionKeys5",
  "LookupSource": "AccountId",
  "ProxyType": {
    "_enum": ["Any", "NonTransfer", "Governance", "Staking", "Unused", "IdentityJudgement"]
  }
};

const versioned = [
  {
    "minmax": [0, 12],
    "types": {
      ...sharedTypes,
      "CompactAssignments": "CompactAssignmentsTo257",
      "OpenTip": "OpenTipTo225",
      "RefCount": "RefCountTo259",
      "RewardDestination": "RewardDestinationTo257"
    }
  },
  {
    "minmax": [13, 22],
    "types": {
      ...sharedTypes,
      "CompactAssignments": "CompactAssignmentsTo257",
      "RefCount": "RefCountTo259",
      "RewardDestination": "RewardDestinationTo257"
    }
  },
  {
    "minmax": [23, 24],
    "types": {...sharedTypes, "RefCount": "RefCountTo259"}
  },
  {
    "minmax": [25, null],
    "types": {...sharedTypes}
  }
];
