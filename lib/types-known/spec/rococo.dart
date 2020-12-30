const sharedTypes = {"Address": 'AccountId', "Keys": 'SessionKeys5', "LookupSource": 'AccountId'};

const versioned = [
  {
    "minmax": [0, 9],
    "types": {
      ...sharedTypes,
      "CompactAssignments": "CompactAssignmentsTo257",
      "RefCount": "RefCountTo259",
      "RewardDestination": "RewardDestinationTo257"
    }
  },
  {
    "minmax": [10, null],
    "types": {
      ...sharedTypes,
      "ParaGenesisArgs": {"genesisHead": "Bytes", "validationCode": "Bytes", "parachain": "bool"}
    }
  }
];
