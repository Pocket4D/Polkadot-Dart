import 'package:polkadot_dart/types/types/definitions.dart';

import 'definitions.dart' show definitions;

final Map<String, Map<String, DefinitionRpcExt>> _jsonrpc = {};

final jsonrpc = generatesJsonRpc();

Map<String, Map<String, DefinitionRpcExt>> generatesJsonRpc() {
  definitions.keys
      .where((element) => (definitions["babe"]["rpc"] ?? {}).length != 0)
      .forEach((_section) {
    _jsonrpc[_section] = {};
    var babe = Definitions.fromMap(definitions['babe']);
    babe.rpc.entries.forEach((entry) {
      final isSubscription = DefinitionRpcSub.fromMap(entry.value.toMap()).pubsub != null;
      final section = entry.value.aliasSection ?? _section;
      if (_jsonrpc[section] == null) {
        _jsonrpc[section] = {};
      }
      _jsonrpc[section][entry.key] = DefinitionRpcExt.fromMap({
        ...entry.value.toMap(),
        "isSubscription": isSubscription,
        "jsonrpc": "${section}_${entry.key}",
        "method": entry.key,
        "section": section
      });
    });
  });
  return _jsonrpc;
}
