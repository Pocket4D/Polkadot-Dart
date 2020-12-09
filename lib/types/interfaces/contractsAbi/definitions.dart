final layout = {
  "ContractCryptoHasher": {
    "_enum": ["Blake2x256", "Sha2x256", "Keccak256"]
  },
  "ContractDiscriminant": "u32",
  "ContractLayoutArray": {
    "offset": "ContractLayoutKey",
    "len": "u32",
    "cellsPerElem": "u64",
    "layout": "ContractStorageLayout"
  },
  "ContractLayoutCell": {"key": "ContractLayoutKey", "ty": "SiLookupTypeId"},
  "ContractLayoutEnum": {
    "dispatchKey": "ContractLayoutKey",
    "variants": "BTreeMap<ContractDiscriminant, ContractLayoutStruct>"
  },
  "ContractLayoutHash": {
    "offset": "ContractLayoutKey",
    "strategy": "ContractLayoutHashingStrategy",
    "layout": "ContractStorageLayout"
  },
  "ContractLayoutHashingStrategy": {
    "hasher": "ContractCryptoHasher",
    "postfix": "Vec<u8>",
    "prefix": "Vec<u8>"
  },
  "ContractLayoutKey": "[u8; 32]",
  "ContractLayoutStruct": {"fields": "Vec<ContractLayoutStructField>"},
  "ContractLayoutStructField": {"layout": "ContractStorageLayout", "name": "Text"},
  "ContractStorageLayout": {
    "_enum": {
      "Cell": "ContractLayoutCell",
      "Hash": "ContractLayoutHash",
      "Array": "ContractLayoutArray",
      "Struct": "ContractLayoutStruct",
      "Enum": "ContractLayoutEnum"
    }
  }
};

final spec = {
  "ContractConstructorSpec": {
    "name": "Text",
    "selector": "ContractSelector",
    "args": "Vec<ContractMessageParamSpec>",
    "docs": "Vec<Text>"
  },
  "ContractContractSpec": {
    "constructors": "Vec<ContractConstructorSpec>",
    "messages": "Vec<ContractMessageSpec>",
    "events": "Vec<ContractEventSpec>",
    "docs": "Vec<Text>"
  },
  "ContractDisplayName": "SiPath",
  "ContractEventParamSpec": {
    "name": "Text",
    "indexed": "bool",
    "type": "ContractTypeSpec",
    "docs": "Vec<Text>"
  },
  "ContractEventSpec": {"name": "Text", "args": "Vec<ContractEventParamSpec>", "docs": "Vec<Text>"},
  "ContractMessageParamSpec": {"name": "Text", "type": "ContractTypeSpec"},
  "ContractMessageSpec": {
    "name": "Text",
    "selector": "ContractSelector",
    "mutates": "bool",
    "payable": "bool",
    "args": "Vec<ContractMessageParamSpec>",
    "returnType": "Option<ContractTypeSpec>",
    "docs": "Vec<Text>"
  },
  "ContractSelector": "[u8; 4]",
  "ContractTypeSpec": {"type": "SiLookupTypeId", "displayName": "ContractDisplayName"}
};

final defs = {
  "rpc": {},
  "types": {
    ...layout,
    ...spec,
    "ContractProject": {
      "metadataVersion": "Text",
      "source": "ContractProjectSource",
      "contract": "ContractProjectContract",
      "types": "Vec<SiType>",
      "spec": "ContractContractSpec"
    },
    "ContractProjectContract": {
      "name": "Text",
      "version": "Text",
      "authors": "Vec<Text>",
      "description": "Option<Text>",
      "documentation": "Option<Text>",
      "repository": "Option<Text>",
      "homepage": "Option<Text>",
      "license": "Option<Text>"
    },
    "ContractProjectSource": {
      "hash": "[u8; 32]",
      "language": "Text",
      "compiler": "Text",
      "wasm": "Raw"
    }
  }
};
