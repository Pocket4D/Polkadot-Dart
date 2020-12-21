import 'dart:convert';

import 'package:polkadot_dart/types-known/upgrades/kusama.dart' as kusama;
import 'package:polkadot_dart/types-known/upgrades/polkadot.dart' as polkadot;
import 'package:polkadot_dart/types-known/upgrades/westend.dart' as westend;
import 'package:polkadot_dart/utils/utils.dart';

class ChainUpgradesRaw {
  String genesisHash;
  List<List<int>> versions;
  ChainUpgradesRaw({this.genesisHash, this.versions});
  factory ChainUpgradesRaw.fromMap(Map<String, dynamic> map) => ChainUpgradesRaw(
      genesisHash: map["genesisHash"] as String, versions: map["versions"] as List<List<int>>);
  toMap() => {"genesisHash": this.genesisHash, "versions": this.versions};
}

List<List<int>> checkOrder(String network, List<List<int>> versions) {
  final ooo = versions.where((curr) {
    final index = versions.indexOf(curr);
    final prev = versions[index - 1];

    return index == 0 ? false : curr[0] <= prev[0] || curr[1] <= prev[1];
  });

  assert(ooo.length == 0, "$network: Mismatched upgrade ordering: ${jsonEncode(ooo)}");

  return versions;
}

Map<String, dynamic> rawToFinal(String network, ChainUpgradesRaw chainUpgradesRaw) {
  return {
    "genesisHash": hexToU8a(chainUpgradesRaw.genesisHash),
    "network": network,
    "versions": checkOrder(network, chainUpgradesRaw.versions).map((result) =>
        ({"blockNumber": BigInt.from(result.first), "specVersion": BigInt.from(result.last)}))
  };
}

final upgrades = [
  rawToFinal('kusama', ChainUpgradesRaw.fromMap(kusama.upgrades)),
  rawToFinal('polkadot', ChainUpgradesRaw.fromMap(polkadot.upgrades)),
  rawToFinal('westend', ChainUpgradesRaw.fromMap(westend.upgrades))
];
