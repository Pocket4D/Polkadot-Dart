import 'package:polkadot_dart/networks/types.dart';

const UNSORTED = [0, 2, 42];

Map<String, dynamic> createReserved(int prefix, [String displayName = 'This prefix is reserved.']) {
  final reservedMap = {
    "decimals": null,
    "displayName": displayName,
    "network": "reserved$prefix",
    "prefix": prefix,
    "standardAccount": null,
    "symbols": null,
    "website": null
  };
  return NetworkFromSubstrate.fromMap(reservedMap).toMap();
}

final all = [
  {
    "decimals": [10],
    "displayName": 'Polkadot Relay Chain',
    "genesisHash": ['0x91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3'],
    "icon": 'polkadot',
    "network": 'polkadot',
    "prefix": 0,
    "standardAccount": '*25519',
    "symbols": ['DOT'],
    "website": 'https://polkadot.network'
  },
  createReserved(1),
  {
    "decimals": [12],
    "displayName": 'Kusama Relay Chain',
    "genesisHash": [
      '0xb0a8d493285c2df73290dfb7e61f870f17b41801197a149ca93654499ea3dafe', // Kusama CC3,
      '0xe3777fa922cafbff200cadeaea1a76bd7898ad5b89f7848999058b50e715f636', // Kusama CC2
      '0x3fd7b9eb6a00376e5be61f01abb429ffb0b104be05eaff4d458da48fcd425baf' // Kusama CC1
    ],
    "icon": 'polkadot',
    "network": 'kusama',
    "prefix": 2,
    "standardAccount": '*25519',
    "symbols": ['KSM'],
    "website": 'https://kusama.network'
  },
  createReserved(3),
  {
    "decimals": null,
    "displayName": 'Katal Chain',
    "network": 'katalchain',
    "prefix": 4,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": null,
    "displayName": 'Plasm Network',
    "genesisHash": ['0x3e86364d4b4894021cb2a0390bcf2feb5517d5292f2de2bb9404227e908b0b8b'],
    "network": 'plasm',
    "prefix": 5,
    "standardAccount": '*25519',
    "symbols": ['PLM'],
    "website": null
  },
  {
    "decimals": [12],
    "displayName": 'Bifrost',
    "network": 'bifrost',
    "prefix": 6,
    "standardAccount": '*25519',
    "symbols": ['BNC'],
    "website": 'https://bifrost.finance/'
  },
  {
    "decimals": [18],
    "displayName": 'Edgeware',
    "genesisHash": ['0x742a2ca70c2fda6cee4f8df98d64c4c670a052d9568058982dad9d5a7a135c5b'],
    "network": 'edgeware',
    "prefix": 7,
    "standardAccount": '*25519',
    "symbols": ['EDG'],
    "website": 'https://edgewa.re'
  },
  {
    "decimals": [18],
    "displayName": 'Acala Karura Canary',
    "network": 'karura',
    "prefix": 8,
    "standardAccount": '*25519',
    "symbols": ['KAR'],
    "website": 'https://acala.network/'
  },
  {
    "decimals": [18],
    "displayName": 'Laminar Reynolds Canary',
    "network": 'reynolds',
    "prefix": 9,
    "standardAccount": '*25519',
    "symbols": ['REY'],
    "website": 'http://laminar.network/'
  },
  {
    "decimals": [18],
    "displayName": 'Acala',
    "network": 'acala',
    "prefix": 10,
    "standardAccount": '*25519',
    "symbols": ['ACA'],
    "website": 'https://acala.network/'
  },
  {
    "decimals": [18],
    "displayName": 'Laminar',
    "network": 'laminar',
    "prefix": 11,
    "standardAccount": '*25519',
    "symbols": ['LAMI'],
    "website": 'http://laminar.network/'
  },
  {
    "decimals": null,
    "displayName": 'Polymath',
    "network": 'polymath',
    "prefix": 12,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": null,
    "displayName": 'SubstraTEE',
    "network": 'substratee',
    "prefix": 13,
    "standardAccount": '*25519',
    "symbols": null,
    "website": 'https://www.substratee.com'
  },
  {
    "decimals": [0],
    "displayName": 'Totem',
    "network": 'totem',
    "prefix": 14,
    "standardAccount": '*25519',
    "symbols": ['XTX'],
    "website": 'https://totemaccounting.com'
  },
  {
    "decimals": [12],
    "displayName": 'Synesthesia',
    "network": 'synesthesia',
    "prefix": 15,
    "standardAccount": '*25519',
    "symbols": ['SYN'],
    "website": 'https://synesthesia.network/'
  },
  {
    "decimals": [12],
    "displayName": 'Kulupu',
    "genesisHash": ['0xf7a99d3cb92853d00d5275c971c132c074636256583fee53b3bbe60d7b8769ba'],
    "network": 'kulupu',
    "prefix": 16,
    "standardAccount": '*25519',
    "symbols": ['KLP'],
    "website": 'https://kulupu.network/'
  },
  {
    "decimals": null,
    "displayName": 'Dark Mainnet',
    "network": 'dark',
    "prefix": 17,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": [9, 9],
    "displayName": 'Darwinia Network',
    "network": 'darwinia',
    "prefix": 18,
    "standardAccount": '*25519',
    "symbols": ['RING', 'KTON'],
    "website": 'https://darwinia.network/'
  },
  {
    "decimals": [12],
    "displayName": 'GeekCash',
    "network": 'geek',
    "prefix": 19,
    "standardAccount": '*25519',
    "symbols": ['GEEK'],
    "website": 'https://geekcash.org'
  },
  {
    "decimals": [12],
    "displayName": 'Stafi',
    "genesisHash": ['0x290a4149f09ea0e402c74c1c7e96ae4239588577fe78932f94f5404c68243d80'],
    "network": 'stafi',
    "prefix": 20,
    "standardAccount": '*25519',
    "symbols": ['FIS'],
    "website": 'https://stafi.io'
  },
  {
    "decimals": [6],
    "displayName": 'Dock Testnet',
    "genesisHash": ['0x3f0608444cf5d7eec977430483ffef31ff86dfa6bfc6d7114023ee80cc03ea3f'],
    "network": 'dock-testnet',
    "prefix": 21,
    "standardAccount": '*25519',
    "symbols": ['DCK'],
    "website": 'https://dock.io'
  },
  {
    "decimals": [6],
    "displayName": 'Dock Mainnet',
    "genesisHash": ['0xf73467c6544aa68df2ee546b135f955c46b90fa627e9b5d7935f41061bb8a5a9'],
    "network": 'dock-mainnet',
    "prefix": 22,
    "standardAccount": '*25519',
    "symbols": ['DCK'],
    "website": 'https://dock.io'
  },
  {
    "decimals": null,
    "displayName": 'ShiftNrg',
    "network": 'shift',
    "prefix": 23,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": [18],
    "displayName": 'ZERO',
    "network": 'zero',
    "prefix": 24,
    "standardAccount": '*25519',
    "symbols": ['PLAY'],
    "website": 'https://zero.io'
  },
  {
    "decimals": [18],
    "displayName": 'ZERO Alphaville',
    "network": 'zero-alphaville',
    "prefix": 25,
    "standardAccount": '*25519',
    "symbols": ['PLAY'],
    "website": 'https://zero.io'
  },
  {
    "decimals": null,
    "displayName": 'Subsocial',
    "genesisHash": ['0x0bd72c1c305172e1275278aaeb3f161e02eccb7a819e63f62d47bd53a28189f8'],
    "network": 'subsocial',
    "prefix": 28,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": [12],
    "displayName": 'Phala Network',
    "network": 'phala',
    "prefix": 30,
    "standardAccount": '*25519',
    "symbols": ["PHA"],
    "website": "https://phala.network"
  },
  {
    "decimals": null,
    "displayName": 'Robonomics Network',
    "network": 'robonomics',
    "prefix": 32,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": null,
    "displayName": 'DataHighway',
    "network": 'datahighway',
    "prefix": 33,
    "standardAccount": '*25519',
    "symbols": null,
    "website": null
  },
  {
    "decimals": [18],
    "displayName": 'Centrifuge Chain',
    "network": 'centrifuge',
    "prefix": 36,
    "standardAccount": '*25519',
    "symbols": ['RAD'],
    "website": 'https://centrifuge.io/'
  },
  {
    "decimals": [18],
    "displayName": 'Nodle Chain',
    "network": 'nodle',
    "prefix": 37,
    "standardAccount": '*25519',
    "symbols": ['NODL'],
    "website": 'https://nodle.io/'
  },
  {
    "prefix": 38,
    "network": "kilt",
    "displayName": "KILT Chain",
    "symbols": ["KILT"],
    "decimals": [18],
    "standardAccount": "*25519",
    "website": "https://kilt.io/"
  },
  {
    "decimals": [18],
    "displayName": 'MathChain mainnet',
    "network": 'mathchain',
    "prefix": 39,
    "standardAccount": '*25519',
    "symbols": ['MATH'],
    "website": 'https://mathwallet.org'
  },
  {
    "decimals": [18],
    "displayName": 'MathChain testnet',
    "network": 'mathchain-testnet',
    "prefix": 40,
    "standardAccount": '*25519',
    "symbols": ['MATH'],
    "website": 'https://mathwallet.org'
  },
  {
    "prefix": 41,
    "network": "poli",
    "displayName": "Polimec Chain",
    "symbols": null,
    "decimals": null,
    "standardAccount": "*25519",
    "website": "https://polimec.io/"
  },
  {
    "decimals": null,
    "displayName": 'Substrate',
    "network": 'substrate',
    "prefix": 42,
    "standardAccount": '*25519',
    "symbols": null,
    "website": 'https://substrate.dev/'
  },
  createReserved(43),
  {
    "decimals": [8],
    "displayName": 'ChainX',
    "network": 'chainx',
    "prefix": 44,
    "standardAccount": '*25519',
    "symbols": ['PCX'],
    "website": 'https://chainx.org/'
  },
  createReserved(46),
  createReserved(47),
  createReserved(48, 'All prefixes 48 and higher are reserved and cannot be allocated.')
];

List<NetworkFromSubstrate> createAvailable() {
  final newList = all
      .map((element) => NetworkFromSubstrate.fromMap(element))
      .where((element) => element.standardAccount == "*25519")
      .map((e) => NetworkFromSubstrate.fromMap({
            ...e.toMap(),
            "genesisHash": e.genesisHash ?? [],
            "icon": e.icon ?? 'substrate',
          }))
      .toList();

  final fixedIndex = UNSORTED.map((e) {
    return newList[newList.indexOf(newList.singleWhere((n) => n.prefix == e))];
  }).toList();

  fixedIndex.forEach((e) => newList.remove(e));
  newList.sort((a, b) => a.displayName.compareTo(b.displayName));
  fixedIndex.addAll(newList);
  return fixedIndex;
}

final available = createAvailable();

final filtered = available.where((n) => n.genesisHash.length != 0 || n.prefix == 42).toList();
