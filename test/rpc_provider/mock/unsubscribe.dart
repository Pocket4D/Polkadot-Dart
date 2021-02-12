import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

import 'mockWs.dart';

// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting
Scope mock;
WsProvider ws;

void createMock(List<ErrorExtends> requests) async {
  mock = await mockWs(requests);
}

Future<WsProvider> createWs([autoConnect = 1000]) {
  ws = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: autoConnect);
  return ws.isReady;
}

void main() {
  mockProviderUnsubscribeTest(); // rename this test name
}

void mockProviderUnsubscribeTest() {
  group('subscribe', () {
    test('removes subscriptions', () async {
      var t1 = ErrorExtends()
        ..id = 1
        ..method = 'subscribe_test'
        ..reply = ReplyDetail()
        ..result = 1;
      var t2 = ErrorExtends()
        ..id = 2
        ..method = 'unsubscribe_test'
        ..reply = ReplyDetail()
        ..result = true;

      createMock([t1, t2]);

      var ws = await createWs();

      ws.subscribe('test', 'subscribe_test', [], (err, cb) {}).then((id) {
        return ws.unsubscribe('test', 'subscribe_test', id);
      });
    });

    test('fails when sub not found', () async {
      var t3 = ErrorExtends()
        ..id = 1
        ..method = 'subscribe_test'
        ..reply = ReplyDetail()
        ..result = 1;
      createMock([t3]);

      var ws = await createWs();

      ws.subscribe('test', 'subscribe_test', [], (err, cb) {}).then((id) {
        return ws.unsubscribe('test', 'subscribe_test', 111);
      }).then((result) {
        expect(result, false);
      });
    });
  });
}
