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
  wsIndexTest(); // rename this test name
}

void wsIndexTest() {
  tearDownAll(() {
    if (mock != null) {
      mock.done();
    }
  });
  group('Ws', () {
    test('returns the connected state', () async {
      var ws = await createWs([]);
      expect(ws.isConnected, false);
    });

    test('allows you to initialize the provider with custom headers', () {
      expect(
          () => new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: 1000, headers: {"foo": 'bar'}),
          returnsNormally);
    });
  });
  group('Endpoint Parsing', () {
    test('Succeeds when WsProvider endpoint is a valid string', () {
      /* eslint-disable no-new */
      expect(() => new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: 0), returnsNormally);
    });

    test('Throws when WsProvider endpoint is an invalid string', () {
      expect(() {
        /* eslint-disable no-new */
        new WsProvider(endpoint: 'http://127.0.0.1:9955', autoConnectMs: 0);
      }, throwsA(assertionThrowsContains("Endpoint should start with")));
    });

    test('Succeeds when WsProvider endpoint is a valid array', () {
      final endpoints = ['ws://127.0.0.1:9955', 'wss://testnet.io:9944', 'ws://mychain.com:9933'];

      /* eslint-disable no-new */
      new WsProvider(endpoint: endpoints, autoConnectMs: 0);
    });

    test('Throws when WsProvider endpoint is an empty array', () {
      final endpoints = [];

      expect(() {
        /* eslint-disable no-new */
        new WsProvider(endpoint: endpoints, autoConnectMs: 0);
      }, throwsA(assertionThrowsContains('WsProvider requires at least one Endpoint')));
    });

    test('Throws when WsProvider endpoint is an invalid array', () {
      final endpoints = ['ws://127.0.0.1:9955', 'http://bad.co:9944', 'ws://mychain.com:9933'];

      expect(() {
        /* eslint-disable no-new */
        new WsProvider(endpoint: endpoints, autoConnectMs: 0);
      }, throwsA(assertionThrowsContains("Endpoint should start with ")));
    });
  });
}
