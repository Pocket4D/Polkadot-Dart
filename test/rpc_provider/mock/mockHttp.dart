import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:mockito/mockito.dart';

const TEST_HTTP_URL = 'http://localhost:9944'; // 'http://172.16.26.136:9933';

MockTestBuilder mockHttp(List<dynamic> requests) {
  MockTestBuilder result = MockTestBuilder();
  DioAdapterMock dioAdapterMock = DioAdapterMock();
  result.mock = requests.fold<DioAdapterMock>(dioAdapterMock, (scope, request) {
    buildResponse(RequestOptions options) {
      var requestData = Map<String, dynamic>.from(jsonDecode(options.data));
      result.body = requestData;
      final responsepayload =
          jsonEncode({"jsonrpc": "2.0", "id": requestData["id"], ...(request["reply"] ?? {})});
      final thisResult = ResponseBody.fromString(responsepayload, request["code"] ?? 200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
          statusMessage: request["statusMessage"] ?? null);
      return thisResult;
    }

    when(scope.fetch(any, any, any)).thenAnswer((invo) async {
      return buildResponse((invo.positionalArguments[0] as RequestOptions));
    });

    return scope;
  });
  return result;
}

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockTestBuilder {
  DioAdapterMock mock;
  Map<String, dynamic> body;
  MockTestBuilder({this.mock, this.body});
}
