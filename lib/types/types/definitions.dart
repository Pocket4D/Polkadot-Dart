// export type DefinitionTypeType = string;

// export type DefinitionTypeEnum = { _enum: DefinitionTypeType[] } | { _enum: Record<string, DefinitionTypeType | null> };

// export type DefinitionTypeSet = { _set: Record<string, number> };

// export type DefinitionTypeStruct = Record<string, DefinitionTypeType> | { _alias?: Record<string, DefinitionTypeType> } & Record<string, unknown>;

// export type DefinitionType = string | DefinitionTypeEnum | DefinitionTypeSet | DefinitionTypeStruct;

import 'dart:convert';

class DefinitionRpcParam {
  bool isCached;
  bool isHistoric;
  bool isOptional;
  String name;
  String type;
  DefinitionRpcParam({this.isCached, this.isHistoric, this.isOptional, this.name, this.type});
  factory DefinitionRpcParam.fromMap(Map<String, dynamic> map) {
    return DefinitionRpcParam(
        isCached: map["isCached"] as bool ?? null,
        isHistoric: map["isHistoric"] as bool ?? null,
        isOptional: map["isOptional"] as bool ?? null,
        name: map["name"] as String ?? null,
        type: map["type"] as String ?? null);
  }
  Map<String, dynamic> toMap() {
    var resultMap = {
      "isCached": this.isCached,
      "isHistoric": this.isHistoric,
      "isOptional": this.isOptional,
      "name": this.name,
      "type": this.type,
    };
    Map<String, dynamic> newMap = Map<String, dynamic>.from({});
    resultMap.forEach((key, value) {
      if (value != null) {
        newMap[key] = value;
      }
    });
    return newMap;
  }
}

class DefinitionRpc {
  List<String> alias;
  String aliasSection;
  String description;
  String endpoint;
  List<DefinitionRpcParam> params;
  String type;
  DefinitionRpc(
      {this.alias, this.description, this.endpoint, this.params, this.type, this.aliasSection});
  factory DefinitionRpc.fromMap(Map<String, dynamic> map) {
    var alias = (map["alias"] is Iterable<String>)
        ? (map["alias"] as Iterable<String>).map((e) => e).toList()
        : null;
    var aliasSection = map["aliasSection"] as String ?? null;
    var description = map["description"] as String ?? null;
    var endpoint = map["endpoint"] as String ?? null;
    var params = (map["params"] is Iterable)
        ? (map["params"] as Iterable).map((e) => DefinitionRpcParam.fromMap(e)).toList()
        : null;
    var type = map["type"] as String ?? null;
    return DefinitionRpc(
        alias: alias,
        aliasSection: aliasSection,
        description: description,
        endpoint: endpoint,
        params: params,
        type: type);
  }
  Map<String, dynamic> toMap() {
    var resultMap = {
      "alias": this.alias,
      "aliasSection": this.aliasSection,
      "description": this.description,
      "endpoint": this.endpoint,
      "params": this.params?.map((e) => e.toMap())?.toList() ?? null,
      "type": this.type,
    };
    Map<String, dynamic> newMap = Map<String, dynamic>.from({});
    resultMap.forEach((key, value) {
      if (value != null) {
        newMap[key] = value;
      }
    });
    return newMap;
  }
}

class DefinitionRpcExt extends DefinitionRpc {
  bool isSubscription;
  String jsonrpc;
  String method;
  List<String> pubsub;
  String section;
  DefinitionRpcExt(
      {List<String> alias,
      String aliasSection,
      String description,
      String endpoint,
      List<DefinitionRpcParam> params,
      String type,
      this.isSubscription,
      this.jsonrpc,
      this.method,
      this.pubsub,
      this.section})
      : super(
            alias: alias,
            aliasSection: aliasSection,
            description: description,
            endpoint: endpoint,
            params: params,
            type: type);
  factory DefinitionRpcExt.fromMap(Map<String, dynamic> map) {
    final parent = DefinitionRpc.fromMap(map);
    return DefinitionRpcExt(
        alias: parent.alias,
        aliasSection: parent.aliasSection,
        description: parent.description,
        endpoint: parent.endpoint,
        params: parent.params,
        type: parent.type,
        isSubscription: map["isSubscription"] ?? false,
        jsonrpc: map["jsonrpc"],
        method: map["method"],
        pubsub: map["pubsub"],
        section: map["section"]);
  }
}

class DefinitionRpcSub extends DefinitionRpc {
  List<String> pubsub;
  DefinitionRpcSub() : super();
  factory DefinitionRpcSub.fromMap(Map<String, dynamic> map) {
    var parent = DefinitionRpc.fromMap(map);
    return DefinitionRpcSub()
      ..alias = parent.alias
      ..aliasSection = parent.aliasSection
      ..description = parent.description
      ..endpoint = parent.description
      ..params = parent.params
      ..type = parent.type
      ..pubsub = map["pubsub"] ?? [];
  }
}

class Definitions {
  Map<String, DefinitionRpc> rpc;
  Map<String, dynamic> types;
  Definitions({this.rpc, this.types});
  factory Definitions.fromMap(Map<String, dynamic> map) {
    Map<String, DefinitionRpc> newRpc = Map<String, DefinitionRpc>.from({});
    (map["rpc"] as Map<String, Object>).forEach((key, value) {
      newRpc.putIfAbsent(key, () => DefinitionRpc.fromMap(value));
    });
    return Definitions(
        rpc: newRpc, types: Map<String, dynamic>.from(jsonDecode(jsonEncode(map['types']))));
  }
  toMap() => {"rpc": this.rpc, "types": this.types};
}
