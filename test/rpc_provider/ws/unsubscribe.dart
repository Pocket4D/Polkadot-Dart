import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

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
  wsUnsubscribeTest(); // rename this test name
}

void wsUnsubscribeTest() {
  tearDown(() {
    if (mock != null) {
      mock.done();
    }
  });
  group("unsubscribe", () {
    test('removes subscriptions', () async {
      createMock([
        ErrorExtends()
          ..result = 1
          ..id = 1
          ..method = 'subscribe_test',
        ErrorExtends()
          ..result = 1
          ..id = 1
          ..method = 'unsubscribe_test'
      ]);

      final ws = await createWs();
      var result = await ws.subscribe('type', 'subscribe_test', [], (err, data) {
        expect(data, returnsNormally);
      });
      await ws.unsubscribe('test', 'subscribe_test', result);
    });
    test('fails when sub not found', () async {
      createMock([
        ErrorExtends()
          ..result = 1
          ..id = 1
          ..method = 'subscribe_test',
      ]);

      final ws = await createWs();
      await ws.subscribe('type', 'subscribe_test', [], (err, data) {
        expect(data, returnsNormally);
      });
      var result = await ws.unsubscribe('test', 'subscribe_test', 111);
      expect(result, false);
    });
  });
}
