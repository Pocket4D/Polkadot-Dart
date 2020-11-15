import 'package:p4d_rust_binding/rpc/json_author.dart';
import 'package:p4d_rust_binding/rpc/json_chain.dart';
import 'package:p4d_rust_binding/rpc/json_state.dart';
import 'package:p4d_rust_binding/rpc/json_system.dart';
import 'package:p4d_rust_binding/rpc/types.dart';

class JsonRpc {
  static final JsonRpcSection author = JsonAuthor.author;
  static final JsonRpcSection chain = JsonChain.chain;
  static final JsonRpcSection state = JsonState.state;
  static final JsonRpcSection system = JsonSystem.system;
}
