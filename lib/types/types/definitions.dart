// export type DefinitionTypeType = string;

// export type DefinitionTypeEnum = { _enum: DefinitionTypeType[] } | { _enum: Record<string, DefinitionTypeType | null> };

// export type DefinitionTypeSet = { _set: Record<string, number> };

// export type DefinitionTypeStruct = Record<string, DefinitionTypeType> | { _alias?: Record<string, DefinitionTypeType> } & Record<string, unknown>;

// export type DefinitionType = string | DefinitionTypeEnum | DefinitionTypeSet | DefinitionTypeStruct;

abstract class DefinitionRpcParam {
  bool isCached;
  bool isHistoric;
  bool isOptional;
  String name;
  String type;
}

abstract class DefinitionRpc {
  List<String> alias;
  String description;
  String endpoint;
  List<DefinitionRpcParam> params;
  String type;
}

abstract class DefinitionRpcExt extends DefinitionRpc {
  bool isSubscription;
  String jsonrpc;
  String method;
  List<String> pubsub;
  String section;
}

abstract class DefinitionRpcSub extends DefinitionRpc {
  List<String> pubsub;
}

abstract class Definitions {
  Map<String, DefinitionRpc> rpc;
  Map<String, String> types;
}
