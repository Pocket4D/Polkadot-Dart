const typesModules = {
  "babe": {"EquivocationProof": 'BabeEquivocationProof'},
  "balances": {"Status": 'BalanceStatus'},
  "contracts": {"StorageKey": 'ContractStorageKey'},
  "grandpa": {
    "Equivocation": 'GrandpaEquivocation',
    "EquivocationProof": 'GrandpaEquivocationProof'
  },
  "identity": {"Judgement": 'IdentityJudgement'},
  "parachains": {"Id": 'ParaId'},
  "proposeParachain": {"Proposal": 'ParachainProposal'},
  "proxy": {"Announcement": 'ProxyAnnouncement'},
  "society": {"Judgement": 'SocietyJudgement', "Vote": 'SocietyVote'},
  "staking": {"Compact": 'CompactAssignments'},
  "treasury": {"Proposal": 'TreasuryProposal'}
};
