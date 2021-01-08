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
  wsSubscribeTest(); // rename this test name
}

void wsSubscribeTest() {
  tearDown(() {
    if (mock != null) {
      mock.done();
    }
  });
  group("subscribe", () {
    test('adds subscriptions', () async {
      createMock([
        ErrorExtends()
          ..result = 1
          ..id = 1
          ..method = 'test_sub'
      ]);

      final ws = await createWs();
      var result = await ws.subscribe('type', 'test_sub', [], (err, data) {
        expect(data, returnsNormally);
      });
      expect(result, 1);
    });
  });
}
