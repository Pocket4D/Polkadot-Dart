import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';

import '../../testUtils/throws.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  decodeReponseTest(); // rename this test name
}

void decodeReponseTest() {
  final coder = new RpcCoder();

  test('expects a non-empty input object', () {
    expect(() => coder.decodeResponse(null), throwsA(assertionThrowsContains("Empty response")));
  });

  test('expects a valid jsonrpc field', () {
    expect(() => coder.decodeResponse(JsonRpcResponse.fromMap({})),
        throwsA(assertionThrowsContains("Invalid jsonrpc")));
  });

  test('expects a valid id field', () {
    expect(() => coder.decodeResponse(JsonRpcResponse.fromMap({"jsonrpc": '2.0'})),
        throwsA(assertionThrowsContains("Invalid id")));
  });

  test('expects a valid result field', () {
    expect(() => coder.decodeResponse(JsonRpcResponse.fromMap({"id": 1, "jsonrpc": '2.0'})),
        throwsA(assertionThrowsContains("No result")));
  });

  test('throws any error found', () {
    expect(
        () => coder.decodeResponse(JsonRpcResponse.fromMap({
              "error": {"code": 123, "message": 'test error'},
              "id": 1,
              "jsonrpc": '2.0'
            })),
        throwsA(contains("123: test error")));
  });

  test('throws any error found, with data', () {
    expect(
        () => coder.decodeResponse(JsonRpcResponse.fromMap({
              "error": {
                "code": 123,
                "data": 'Error("Some random error description")',
                "message": 'test error'
              },
              "id": 1,
              "jsonrpc": '2.0'
            })),
        throwsA(contains("123: test error: Some random error description")));
  });

  test('allows for number subscription ids', () {
    expect(
        coder.decodeResponse(JsonRpcResponse.fromMap({
          "id": 1,
          "jsonrpc": '2.0',
          "method": 'test',
          "params": {"result": 'test result', "subscription": 1}
        })),
        'test result');
  });

  test('allows for string subscription ids', () {
    expect(
        coder.decodeResponse(JsonRpcResponse.fromMap({
          "id": 1,
          "jsonrpc": '2.0',
          "method": 'test',
          "params": {"result": 'test result', "subscription": 'abc'}
        })),
        'test result');
  });

  test('returns the result', () {
    expect(
        coder.decodeResponse(
            JsonRpcResponse.fromMap({"id": 1, "jsonrpc": '2.0', "result": 'some result'})),
        'some result');
  });
}
