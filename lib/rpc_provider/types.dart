class JsonRpcObject {
  int id;
  String jsonrpc = '2.0';
  JsonRpcObject({this.id = 0, this.jsonrpc = '2.0'});

  factory JsonRpcObject.fromMap(Map<String, dynamic> map) =>
      JsonRpcObject(id: map['id'] ?? 0, jsonrpc: '2.0');
  toMap() => {"id": id ?? 0, "jsonrpc": '2.0'};
}

class JsonRpcRequest extends JsonRpcObject {
  String method;
  dynamic params;
  JsonRpcRequest({id, jsonrpc, this.method, this.params}) : super(id: id, jsonrpc: '2.0');
  factory JsonRpcRequest.fromMap(Map<String, dynamic> map) => JsonRpcRequest(
      id: map['id'] ?? 0, jsonrpc: '2.0', method: map["method"], params: map["params"]);
  toMap() => {"id": id ?? 0, "jsonrpc": '2.0', "method": this.method, "params": this.params};
}

class JsonRpcResponseBaseError {
  int code;
  dynamic data;
  String message;
  JsonRpcResponseBaseError({this.code, this.data, this.message});
  factory JsonRpcResponseBaseError.fromMap(Map<String, dynamic> map) =>
      JsonRpcResponseBaseError(code: map['code'], data: map["data"], message: map["message"]);
  toMap() => {
        "code": code,
        "data": data,
        "message": message,
      };
}

class JsonRpcResponseSingle {
  JsonRpcResponseBaseError error;
  dynamic result;
  JsonRpcResponseSingle({this.error, this.result});
  factory JsonRpcResponseSingle.fromMap(Map<String, dynamic> map) => JsonRpcResponseSingle(
      error: map['error'] is JsonRpcResponseBaseError
          ? map['error']
          : JsonRpcResponseBaseError.fromMap(map['error']),
      result: map["result"]);
  toMap() => {
        "error": error?.toMap(),
        "result": result,
      };
}

class JsonRpcResponseSubscription {
  String method;
  Map<String, dynamic> params;
  JsonRpcResponseSubscription({this.method, this.params});
  factory JsonRpcResponseSubscription.fromMap(Map<String, dynamic> map) {
    final _error = map["params"] != null && map["params"]["error"] != null
        ? map["params"]["error"] is JsonRpcResponseBaseError
            ? map["params"]["error"]
            : JsonRpcResponseBaseError.fromMap(map["params"]["error"])
        : null;
    final _result =
        map["params"] != null && map["params"]["result"] != null ? map["params"]["result"] : null;
    final _subscription = map["params"] != null && map["params"]["subscription"]
        ? map["params"]["subscription"]
        : null;
    return JsonRpcResponseSubscription(
        method: map["method"],
        params: {"error": _error, "result": _result, "subscription": _subscription});
  }
  toMap() => {
        "method": method,
        "params": {
          "error": (params["error"] as JsonRpcResponseBaseError).toMap(),
          "result": params["result"],
          "subscription": params['subscription']
        }
      };
}

// export type JsonRpcResponseBase = JsonRpcResponseSingle & JsonRpcResponseSubscription;

class JsonRpcResponseBase implements JsonRpcResponseSingle, JsonRpcResponseSubscription {
  @override
  JsonRpcResponseBaseError error;

  @override
  String method;

  @override
  Map<String, dynamic> params;

  @override
  var result;

  JsonRpcResponseBase({this.error, this.method, this.params, this.result});
  factory JsonRpcResponseBase.fromMap(Map<String, dynamic> map) {
    final _error = map["error"] is JsonRpcResponseBaseError
        ? map["error"]
        : JsonRpcResponseBaseError.fromMap(map["error"]);
    final _method = map["method"];
    final _params = {
      "error": map["params"] != null && map["params"]["error"] != null
          ? map["params"]["error"] is JsonRpcResponseBaseError
              ? map["params"]["error"]
              : JsonRpcResponseBaseError.fromMap(map["params"]["error"])
          : null,
      "result":
          map["params"] != null && map["params"]["result"] != null ? map["params"]["result"] : null,
      "subscription": map["params"] != null && map["params"]['subscription'] != null
          ? map["params"]['subscription']
          : null
    };
    final _result = map["result"];
    return JsonRpcResponseBase(error: _error, params: _params, method: _method, result: _result);
  }
  @override
  toMap() {
    return {
      "error": error?.toMap(),
      "method": method,
      "params": {
        "error": (params["error"] as JsonRpcResponseBaseError).toMap(),
        "result": params["result"],
        "subscription": params['subscription']
      },
      "result": result
    };
  }
}

// export type JsonRpcResponse = JsonRpcObject & JsonRpcResponseBase;

class JsonRpcResponse implements JsonRpcObject, JsonRpcResponseBase {
  @override
  JsonRpcResponseBaseError error;

  @override
  int id;

  @override
  String jsonrpc;

  @override
  String method;

  @override
  Map<String, dynamic> params;

  @override
  var result;

  JsonRpcResponse({this.error, this.id, this.jsonrpc, this.method, this.params, this.result});

  factory JsonRpcResponse.fromMap(Map<String, dynamic> map) {
    final _id = map["id"];
    final _jsonrpc = map["jsonrpc"];
    final _error = map["error"] is JsonRpcResponseBaseError
        ? map["error"]
        : map["error"] != null
            ? JsonRpcResponseBaseError.fromMap(map["error"])
            : null;
    final _method = map["method"];
    final _params = {
      "error": map["params"] != null && map["params"]["error"] != null
          ? map["params"]["error"] is JsonRpcResponseBaseError
              ? map["params"]["error"]
              : JsonRpcResponseBaseError.fromMap(map["params"]["error"])
          : null,
      "result":
          map["params"] != null && map["params"]["result"] != null ? map["params"]["result"] : null,
      "subscription": map["params"] != null && map["params"]['subscription'] != null
          ? map["params"]['subscription']
          : null
    };
    final _result = map["result"];
    return JsonRpcResponse(
        error: _error,
        id: _id,
        jsonrpc: _jsonrpc,
        method: _method,
        params: _params,
        result: _result);
  }
  @override
  toMap() {
    return {
      "id": id,
      "jsonrpc": '2.0',
      "error": error?.toMap(),
      "method": method,
      "params": {
        "error": (params["error"] as JsonRpcResponseBaseError).toMap(),
        "result": params["result"],
        "subscription": params['subscription']
      },
      "result": result
    };
  }
}

// export type ProviderInterfaceCallback = (error: Error | null, result: any) => void;

typedef ProviderInterfaceCallback = void Function(dynamic error, dynamic result);

// export type ProviderInterfaceEmitted = 'connected' | 'disconnected' | 'error';

enum ProviderInterfaceEmitted { connected, disconnected, error }

extension ProviderInterfaceEmittedExt on ProviderInterfaceEmitted {
  get name => this.toString().replaceFirst("ProviderInterfaceEmitted.", "");
  static ProviderInterfaceEmitted fromString(String value) {
    return ProviderInterfaceEmitted.values.firstWhere(
        (element) => element.name == value.replaceFirst("ProviderInterfaceEmitted.", ""),
        orElse: () => throw "$value is not in ProviderInterfaceEmitted.");
  }

  static Iterable<String> get names => ProviderInterfaceEmitted.values.map((e) => e.name);
  static Map<String, ProviderInterfaceEmitted> get stringMaps =>
      Map<String, ProviderInterfaceEmitted>.fromEntries(
          ProviderInterfaceEmitted.values.map((e) => MapEntry(e.name, e)));
  static Map<ProviderInterfaceEmitted, String> get enumMaps =>
      Map<ProviderInterfaceEmitted, String>.fromEntries(
          ProviderInterfaceEmitted.values.map((e) => MapEntry(e, e.name)));
}

// export type ProviderInterfaceEmitCb = (value?: any) => any;

typedef ProviderInterfaceEmitCb = dynamic Function([dynamic value]);

abstract class ProviderInterface {
  bool get hasSubscriptions;
  bool get isConnected;

  ProviderInterface clone();
  Future<void> connect();
  Future<void> disconnect();
  void Function() on(ProviderInterfaceEmitted type, ProviderInterfaceEmitCb sub);
  Future<dynamic> send(String method, List<dynamic> params);
  Future<dynamic> subscribe(
      String type, String method, List<dynamic> params, ProviderInterfaceCallback cb);
  Future<bool> unsubscribe(String type, String method, dynamic id);
}
