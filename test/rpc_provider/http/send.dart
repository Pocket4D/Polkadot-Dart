import 'package:flutter_test/flutter_test.dart';

import 'package:polkadot_dart/rpc_provider/http/index.dart';

import '../mock/mockHttp.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  httpSendTest(); // rename this test name
}

void httpSendTest() {
  final http = new HttpProvider(endpoint: TEST_HTTP_URL);

  group('send', () {
    test('passes the body through correctly', () async {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      var dioAdapterMock = mockHttp([
        {
          "method": 'test_body',
          "reply": {"result": 'ok'}
        }
      ]);
      http.dio.httpClientAdapter = dioAdapterMock.mock;
      var res = await http.send("test_body", ['param']);
      expect(res, "ok");
      expect(dioAdapterMock.body, {
        "id": 1,
        "jsonrpc": '2.0',
        "method": 'test_body',
        "params": ['param']
      });
    });
  });

  test('throws error when !response.ok', () {
    //   // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    final dioAdapterMock = mockHttp([
      {"code": 500, "statusMessage": "Internal Server", "method": 'test_error'}
    ]);

    http.dio.httpClientAdapter = dioAdapterMock.mock;

    expect(() async => http.send('test_error', []), throwsA(contains("500: Internal Server")));
  });
}
