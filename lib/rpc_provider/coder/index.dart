import 'dart:convert';

import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

String formatErrorData([dynamic data]) {
  if (data == null) {
    return '';
  }
  var result;
  if (data is String) {
    result = data
        .replaceAll('Error', '')
        .replaceAll("(\"", '(')
        .replaceAll("\")", ')')
        .replaceAll("(", '')
        .replaceAll(")", '');
  } else {
    result = jsonEncode(data);
  }
  final formatted = ": $result";
  return formatted.length <= 256 ? formatted : "${formatted.substring(0, 255)}…";
}

class RpcCoder {
  int _id = 0;

  dynamic decodeResponse(JsonRpcResponse response) {
    assert(response != null, 'Empty response object received');
    assert(response.jsonrpc == '2.0', 'Invalid jsonrpc field in decoded object');

    final isSubscription = (response.params != null) && (response.method != null);

    assert(
        isNumber(response.id) ||
            (isSubscription &&
                (isNumber(response.params["subscription"]) ||
                    isString(response.params["subscription"]))),
        'Invalid id field in decoded object');

    this._checkError(response.error);

    assert((response.result != null) || isSubscription, 'No result found in JsonRpc response');

    if (isSubscription) {
      this._checkError(response.params["error"]);

      return response.params["result"];
    }

    return response.result;
  }

  String encodeJson(String method, dynamic params) {
    return jsonEncode(this.encodeObject(method, params).toMap());
  }

  JsonRpcRequest encodeObject(String method, dynamic params) {
    return JsonRpcRequest.fromMap(
        {"id": ++this._id, "jsonrpc": '2.0', "method": method, "params": params});
  }

  int getId() {
    return this._id;
  }

  void _checkError(JsonRpcResponseBaseError error) {
    if (error != null) {
      throw "${error.code}: ${error.message}${formatErrorData(error.data)}";
    }
    return;
  }
}
