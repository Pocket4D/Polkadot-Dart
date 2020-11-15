class JsonRpcParam {
  bool isOptional;
  String name;
  String type;

  JsonRpcParam(String name, String type, [bool isOptional = false]) {
    this.isOptional = isOptional;
    this.name = name;
    this.type = type;
  }

  void setOptional(bool optional) {
    isOptional = optional;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getType() {
    return type;
  }

  void setType(String type) {
    this.type = type;
  }
}

class JsonRpcMethodOpt {
  String description;
  bool isDeprecated;
  bool isHidden;
  bool isSigned;
  bool isSubscription;
  List<JsonRpcParam> params = List<JsonRpcParam>();
  List<String> pubsub;
  String type;

  JsonRpcMethodOpt(
      {String description,
      List<JsonRpcParam> params,
      List<String> pubsub,
      String type,
      bool isSigned}) {
    this.description = description;
    this.isSigned = isSigned;
    this.params = params;
    this.pubsub = pubsub;
    this.type = type;
  }
}

class JsonRpcMethod {
  String alias;
  String description;
  bool isDeprecated;
  bool isHidden;
  bool isSigned;
  bool isSubscription;
  String method;
  List<JsonRpcParam> params;
  List<String> pubsub;
  String section;
  String type;

  JsonRpcMethod(JsonRpcMethodOpt rpcMethodOpt, String section, String method) {
    this.description = rpcMethodOpt.description;
    this.isDeprecated = rpcMethodOpt.isDeprecated;
    this.isHidden = rpcMethodOpt.isHidden;
    this.isSigned = rpcMethodOpt.isSigned;
    this.isSubscription = (rpcMethodOpt.pubsub).isNotEmpty;
    this.method = method;
    this.params = rpcMethodOpt.params;
    if (this.params == null) {
      this.params = List<JsonRpcParam>();
    }
    this.pubsub = rpcMethodOpt.pubsub;
    this.section = section;
    this.type = rpcMethodOpt.type;
  }

  String getAlias() {
    return alias;
  }

  void setAlias(String alias) {
    this.alias = alias;
  }

  String getDescription() {
    return description;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setDeprecated(bool deprecated) {
    isDeprecated = deprecated;
  }

  void setHidden(bool hidden) {
    isHidden = hidden;
  }

  void setSigned(bool signed) {
    isSigned = signed;
  }

  void setSubscription(bool subscription) {
    isSubscription = subscription;
  }

  String getMethod() {
    return method;
  }

  void setMethod(String method) {
    this.method = method;
  }

  List<JsonRpcParam> getParams() {
    return params;
  }

  void setParams(List<JsonRpcParam> params) {
    this.params = params;
  }

  List<String> getPubsub() {
    return pubsub;
  }

  void setPubsub(List<String> pubsub) {
    this.pubsub = pubsub;
  }

  String getSection() {
    return section;
  }

  void setSection(String section) {
    this.section = section;
  }

  String getType() {
    return type;
  }

  void setType(String type) {
    this.type = type;
  }
}

class JsonRpcSection {
  bool isDeprecated;
  bool isHidden;
  String description;
  String section;
  Map<String, JsonRpcMethod> rpcMethods;

  JsonRpcSection(bool isDeprecated, bool isHidden, String description, String section,
      Map<String, JsonRpcMethod> rpcMethods) {
    this.isDeprecated = isDeprecated;
    this.isHidden = isHidden;
    this.description = description;
    this.section = section;
    this.rpcMethods = rpcMethods;
  }
}
