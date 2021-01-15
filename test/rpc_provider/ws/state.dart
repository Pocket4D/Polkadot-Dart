import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

import '../../testUtils/throws.dart';
import '../mock/mockWs.dart';

// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting
Scope mock;
WsProvider ws;

Future<WsProvider> createWs(List<ErrorExtends> requests, [int autoConnect = 1000]) async {
  mock = await mockWs(requests);
  ws = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: autoConnect);
  return ws;
}

void main() {
  wsStateTest(); // rename this test name
}

void wsStateTest() {
  group('state', () {
    test('requires an ws:// prefixed endpoint', () {
      expect(() => new WsProvider(endpoint: 'http://', autoConnectMs: 0),
          throwsA(assertionThrowsContains("with 'ws")));
    });

    test('allows wss:// endpoints', () {
      expect(() => new WsProvider(endpoint: 'wss://', autoConnectMs: 0), returnsNormally);
    });
  });
}
