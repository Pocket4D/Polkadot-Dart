import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/ws/index.dart';

import '../mock/mockWs.dart';

// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

Future sleepMs([int ms = 0]) {
  return Future.delayed(Duration(milliseconds: ms));
}

void main() {
  wsConnectTest(); // rename this test name
}

void wsConnectTest() {
  group('onConnect', () {
    List<Scope> mocks;

    setUp(() async {
      mocks = [await mockWs([])];
    });

    tearDown(() {
      mocks.forEach((m) {
        if (m != null) {
          m.done();
        }
      });
    });

    test('Does not connect when autoConnect is false', () {
      final provider = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: 0);

      expect(provider.isConnected, false);
    });

    test('Does connect when autoConnect is true', () async {
      final provider = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: 1);

      await sleepMs(100); // Hack to give the provider time to connect
      expect(provider.isConnected, true);
    });

    test('Creates a new WebSocket instance by calling the connect() method', () async {
      final provider = new WsProvider(endpoint: TEST_WS_URL, autoConnectMs: false);
      expect(provider.isConnected, false);
      expect(mocks[0].server.connectionsInfo().active, 0);
      expect(mocks[0].clientCount, 0);
      await provider.connect();
      await sleepMs(100); // Hack to give the provider time to connect

      expect(provider.isConnected, true);
      expect(mocks[0].clientCount, 1);
    });

    test('Connects to first endpoint when an array is given', () async {
      final provider = new WsProvider(endpoint: [TEST_WS_URL], autoConnectMs: 1);

      await provider.connect();
      await sleepMs(100); // Hack to give the provider time to connect

      expect(provider.isConnected, true);
    });

    test('Connects to the second endpoint when the first is unreachable', () async {
      /* eslint-disable @typescript-eslint/no-empty-function */
      // jest.spyOn(console, 'error').mockImplementation((){});

      final endpoints = ['ws://localhost:9956', TEST_WS_URL];
      final provider = new WsProvider(endpoint: endpoints, autoConnectMs: 1);

      await sleepMs(100); // Hack to give the provider time to connect

      expect(provider.isConnected, true);
    });

    test('Connects to the second endpoint when the first is dropped', () async {
      final endpoints = [TEST_WS_URL, 'ws://localhost:9957'];

      mocks.add(await mockWs([], endpoints[1]));
      final provider = new WsProvider(endpoint: endpoints, autoConnectMs: 1);

      await sleepMs(100); // Hack to give the provider time to connect
      // Check that first server is connected
      expect(mocks[0].clientCount, 1);
      expect(mocks[1].clientCount, 0);
      mocks[0].sinkMap[0].close();
      // // (await mocks[0].server.elementAt(0)).drain();
      // // Close connection from first server
      await sleepMs(100);

      // // Check that second server is connected
      expect(mocks[1].clientCount, 1);
      expect(provider.isConnected, true);
    });

    test('Round-robin of endpoints on WsProvider', () async {
      final rounds = 5;
      final endpoints = [
        TEST_WS_URL,
        'ws://localhost:9956',
        'ws://localhost:9957',
        'ws://invalid:9956',
        'ws://localhost:9958'
      ];

      mocks.add(await mockWs([], endpoints[1]));
      mocks.add(await mockWs([], endpoints[2]));
      mocks.add(await mockWs([], endpoints[4]));

      final mockNext = [mocks[1], mocks[2], mocks[3], mocks[0]];
      final provider = new WsProvider(endpoint: endpoints, autoConnectMs: 1);

      for (int round = 0; round < rounds; round++) {
        for (int index = 0; index < mocks.length; index++) {
          await sleepMs(100); // Hack to give the provider time to connect

          // Check that first server is connected and the next one isn't
          expect(mocks[index].clientCount, 1);
          expect(mockNext[index].clientCount, 0);
          expect(provider.isConnected, true);

          // Close connection from first server
          mocks[index].sinkMap[0].close();
          mocks[index].sinkMap.remove(0);
        }
      }
    });
  });
}
