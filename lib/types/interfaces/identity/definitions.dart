final defs = {
  "rpc": {},
  "types": {
    "IdentityFields": {
      "_set": {
        "_bitLength": 64,
        "Display": 1,
        "Legal": 2,
        "Web": 4,
        "Riot": 8,
        "Email": 16,
        "PgpFingerprint": 32,
        "Image": 64,
        "Twitter": 128
      }
    },
    "IdentityInfoAdditional": "(Data, Data)",
    "IdentityInfo": {
      "additional": "Vec<IdentityInfoAdditional>",
      "display": "Data",
      "legal": "Data",
      "web": "Data",
      "riot": "Data",
      "email": "Data",
      "pgpFingerprint": "Option<H160>",
      "image": "Data",
      "twitter": "Data"
    },
    "IdentityJudgement": {
      "_enum": {
        "Unknown": "Null",
        "FeePaid": "Balance",
        "Reasonable": "Null",
        "KnownGood": "Null",
        "OutOfDate": "Null",
        "LowQuality": "Null",
        "Erroneous": "Null"
      }
    },
    "RegistrationJudgement": "(RegistrarIndex, IdentityJudgement)",
    "Registration": {
      "judgements": "Vec<RegistrationJudgement>",
      "deposit": "Balance",
      "info": "IdentityInfo"
    },
    "RegistrarIndex": "u32",
    "RegistrarInfo": {"account": "AccountId", "fee": "Balance", "fields": "IdentityFields"}
  }
};
