import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

import '../../testUtils/throws.dart';
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
  mockProviderStateTest(); // rename this test name
}

void mockProviderStateTest() {
  group('state', () {
    test('requires an ws:// prefixed endpoint', () {
      expect(() => new WsProvider(endpoint: 'http://', autoConnectMs: 0),
          throwsA(assertionThrowsContains("http://")));
    });

    test('allows wss:// endpoints', () {
      expect(() => new WsProvider(endpoint: 'wss://', autoConnectMs: 0), returnsNormally);
    });
  });
}
