import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/http/index.dart';

import '../../testUtils/throws.dart';
import '../mock/mockHttp.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  httpTest(); // rename this test name
}

void httpTest() {
  final http = new HttpProvider(endpoint: TEST_HTTP_URL);
  group('Http', () {
    test('requires an http:// prefixed endpoint', () {
      expect(() => new HttpProvider(endpoint: 'ws://'),
          throwsA(assertionThrowsContains("with 'http")));
    });

    test('allows https:// endpoints', () {
      expect(() => new HttpProvider(endpoint: 'https://'), returnsNormally);
    });

    test('allows custom headers', () {
      expect(
          () => new HttpProvider(endpoint: 'https://', headers: {"foo": 'bar'}), returnsNormally);
    });

    test('always returns isConnected true', () {
      expect(http.isConnected, true);
    });

    test('does not (yet) support subscribe', () {
      try {
        http.subscribe('', '', [], (cb, exec) {
          expect(cb, returnsNormally);
        });
      } catch (e) {
        expect(e.toString(), contains("does not have subscriptions"));
      }
    });

    test('does not (yet) support unsubscribe', () {
      try {
        http.unsubscribe('', '', 0);
      } catch (e) {
        expect(e.toString(), contains("does not have subscriptions"));
      }
    });
  });
}
