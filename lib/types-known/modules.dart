const typesModules = {
  // "assets": {"Balance": "TAssetBalance"},
  "babe": {"EquivocationProof": "BabeEquivocationProof"},
  "balances": {"Status": "BalanceStatus"},
  "contracts": {"StorageKey": "ContractStorageKey"},
  "ethereum": {
    "Block": "EthBlock",
    "Header": "EthHeader",
    "Receipt": "EthReceipt",
    "Transaction": "EthTransaction",
    "TransactionStatus": "EthTransactionStatus"
  },
  "evm": {"Account": "EvmAccount", "Log": "EvmLog", "Vicinity": "EvmVicinity"},
  "grandpa": {
    "Equivocation": "GrandpaEquivocation",
    "EquivocationProof": "GrandpaEquivocationProof"
  },
  "identity": {"Judgement": "IdentityJudgement"},
  "parachains": {"Id": "ParaId"},
  "proposeParachain": {"Proposal": "ParachainProposal"},
  "proxy": {"Announcement": "ProxyAnnouncement"},
  "society": {"Judgement": "SocietyJudgement", "Vote": "SocietyVote"},
  "staking": {"Compact": "CompactAssignments"},
  "treasury": {"Proposal": "TreasuryProposal"}
};
