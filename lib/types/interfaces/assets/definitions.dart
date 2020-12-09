final defs = {
  "rpc": {},
  "types": {
    "AssetBalance": {"balance": 'TAssetBalance', "isFrozen": 'bool', "isZombie": 'bool'},
    "AssetDetails": {
      "owner": 'AccountId',
      "issuer": 'AccountId',
      "admin": 'AccountId',
      "freezer": 'AccountId',
      "supply": 'TAssetBalance',
      "deposit": 'TAssetDepositBalance',
      "maxZombies": 'u32',
      "minBalance": 'TAssetBalance',
      "zombies": 'u32',
      "accounts": 'u32'
    },
    "TAssetBalance": 'Balance',
    "TAssetDepositBalance": 'BalanceOf'
  }
};
