import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  encodeJsonTest(); // rename this test name
}

void encodeJsonTest() {
  final coder = new RpcCoder();
  group('encodeObject', () {
    test('starts with id === 0 (nothing sent)', () {
      expect(coder.getId(), 0);
    });

    test('encodes a valid JsonRPC object', () {
      expect(coder.encodeJson('method', 'params'),
          '{"id":1,"jsonrpc":"2.0","method":"method","params":"params"}');
    });
  });
}
