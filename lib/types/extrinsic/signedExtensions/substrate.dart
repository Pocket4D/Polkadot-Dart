import 'package:polkadot_dart/types/extrinsic/signedExtensions/emptyCheck.dart';

const CheckMortality = {
  "extra": {"blockHash": 'Hash'},
  "types": {"era": 'ExtrinsicEra'}
};

const substrateExtensions = {
  "ChargeTransactionPayment": {
    "extra": {},
    "types": {"tip": "Compact<Balance>"}
  },
  "CheckBlockGasLimit": emptyCheck,
  "CheckEra": CheckMortality,
  "CheckGenesis": {
    "extra": {"genesisHash": "Hash"},
    "types": {}
  },
  "CheckMortality": {
    "extra": {"blockHash": "Hash"},
    "types": {"era": "ExtrinsicEra"}
  },
  "CheckNonce": {
    "extra": {},
    "types": {"nonce": "Compact<Index>"}
  },
  "CheckSpecVersion": {
    "extra": {"specVersion": "u32"},
    "types": {}
  },
  "CheckTxVersion": {
    "extra": {"transactionVersion": "u32"},
    "types": {}
  },
  "CheckVersion": {
    "extra": {"specVersion": "u32"},
    "types": {}
  },
  "CheckWeight": emptyCheck,
  "LockStakingStatus": emptyCheck,
  "ValidateEquivocationReport": emptyCheck
};
