// export type Icon = 'beachball' | 'empty' | 'jdenticon' | 'polkadot' | 'substrate';

import 'dart:convert';

class NetworkFromSubstrate {
  List<dynamic> decimals;
  String displayName;
  String network;
  int prefix;
  List<dynamic> genesisHash;
  String icon;
  String standardAccount;
  List<dynamic> symbols;
  String website;
  NetworkFromSubstrate(
      {this.decimals,
      this.displayName,
      this.network,
      this.prefix,
      this.genesisHash,
      this.icon,
      this.standardAccount,
      this.symbols,
      this.website});
  factory NetworkFromSubstrate.fromMap(Map<String, dynamic> map) {
    return NetworkFromSubstrate(
        decimals: map["decimals"] as List<dynamic>,
        displayName: map["displayName"] as String,
        network: map["network"] as String,
        prefix: map["prefix"] as int,
        genesisHash: map["genesisHash"] as List<dynamic>,
        icon: map["icon"] as String,
        standardAccount: map["standardAccount"] as String,
        symbols: map["symbols"] as List<dynamic>,
        website: map["website"] as String);
  }
  factory NetworkFromSubstrate.fromJson(String json) {
    final decoded = Map<String, dynamic>.from(jsonDecode(json));
    return NetworkFromSubstrate.fromMap(decoded);
  }

  Map<String, dynamic> toMap() => {
        "decimals": this.decimals,
        "displayName": this.displayName,
        "network": this.network,
        "prefix": this.prefix,
        "genesisHash": this.genesisHash,
        "icon": this.icon,
        "standardAccount": this.standardAccount,
        "symbols": this.symbols,
        "website": this.website
      };
  String toJson() => jsonEncode(toMap());
}

class Ss58Registry {
  List<NetworkFromSubstrate> registry;
  String specification;
  Map<String, dynamic> schema;
  Ss58Registry({this.registry, this.specification, this.schema});
  factory Ss58Registry.fromJson(String json) {
    var map = Map<String, dynamic>.from(jsonDecode(json));
    return Ss58Registry(
        registry: (map["registry"] as List).map((e) {
          return NetworkFromSubstrate.fromMap(e);
        }).toList(),
        specification: map["specification"],
        schema: map["schema"]);
  }
}
