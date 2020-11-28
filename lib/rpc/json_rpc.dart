import 'package:polkadot_dart/rpc/json_author.dart';
import 'package:polkadot_dart/rpc/json_chain.dart';
import 'package:polkadot_dart/rpc/json_state.dart';
import 'package:polkadot_dart/rpc/json_system.dart';
import 'package:polkadot_dart/rpc/types.dart';

class JsonRpc {
  static final JsonRpcSection author = JsonAuthor.author;
  static final JsonRpcSection chain = JsonChain.chain;
  static final JsonRpcSection state = JsonState.state;
  static final JsonRpcSection system = JsonSystem.system;
}
