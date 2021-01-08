import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/http/index.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

import '../../testUtils/throws.dart';
import '../mock/mockWs.dart';

// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting
Scope mock;
WsProvider provider;

// Future<WsProvider> createWs(List<ErrorExtends> requests, [int autoConnect = 1000]) async {
//   mock = await mockWs(requests);
//   ws = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: autoConnect);
//   return ws;
// }

void createMock(List<ErrorExtends> requests) async {
  mock = await mockWs(requests);
}

Future<WsProvider> createWs([int autoConnect = 1000]) {
  provider = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: autoConnect);
  return provider.isReady;
}

void main() {
  wsSendTest(); // rename this test name
}

void wsSendTest() {
  tearDown(() {
    if (mock != null) {
      mock.done();
    }
  });
  group("send", () {
    test('handles internal errors', () async {
      var mock = ErrorExtends()
        ..id = 1
        ..method = 'test_body'
        ..result = 'ok';
      createMock([mock]);

      final ws = await createWs();
      try {
        await ws.send('test_encoding', [
          {"error": 'send error'}
        ]);
      } catch (e) {
        expect(e, 'send error');
      }
    });

    test('passes the body through correctly', () async {
      createMock([
        ErrorExtends()
          ..id = 1
          ..method = 'test_body'
          ..result = 'ok'
      ]);

      final ws = await createWs();
      await ws.send('test_body', ['param']);
      expect(mock.body["test_body"],
          '{"id":1,"jsonrpc":"2.0","method":"test_body","params":["param"]}');
    });

    test('throws error when !response.ok', () async {
      createMock([
        ErrorExtends()
          ..error = (ErrorDetail()
            ..code = 666
            ..messasge = "error")
          ..id = 1
      ]);
      final ws = await createWs();
      try {
        await ws.send('test_error', []);
      } catch (e) {
        expect(e, "666: error");
      }
    });

    test('adds subscriptions', () async {
      createMock([
        ErrorExtends()
          ..result = 1
          ..id = 1
          ..method = 'test_sub'
      ]);

      final ws = await createWs();
      var result = await ws.send('test_sub', []);
      expect(result, 1);
    });
  });
}
