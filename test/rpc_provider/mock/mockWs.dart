import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const TEST_WS_URL = 'ws://localhost:9955';

class Scope {
  Map<String, dynamic> body;
  int requests;
  HttpServer server;
  dynamic done;
  int get clientCount => sinkMap.length;
  Map<int, WebSocketSink> sinkMap;
}

class ErrorDetail {
  int code;
  String messasge;
}

class ErrorDef {
  int id;
  ErrorDetail error;
}

class ErrorExtends extends ErrorDef {
  String method;
  dynamic result;
  ReplyDetail reply;
}

class ReplyDetail {
  dynamic result;
}

class ReplyDef {
  int id;
  ReplyDetail reply;
}

Map<String, dynamic> createError(ErrorDef errorDef) {
  return {
    "error": {"code": errorDef.error.code, "message": errorDef.error.messasge},
    "id": errorDef.id,
    "jsonrpc": '2.0'
  };
}

Map<String, dynamic> createReply(ReplyDef replyDef) {
  return {"id": replyDef.id, "jsonrpc": '2.0', "result": replyDef.reply.result};
}

Future<Scope> mockWs(List<ErrorExtends> requests, [String wsUrl = TEST_WS_URL]) async {
  final uri = Uri.parse(wsUrl);
  final server = await HttpServer.bind(uri.host, uri.port, shared: true);

  var requestCount = 0;
  final scope = new Scope();
  scope.body = Map<String, dynamic>();
  scope.done = () {
    server.close(force: true);
  };
  scope.requests = 0;
  scope.server = server;

  scope.sinkMap = {};

  server.transform(WebSocketTransformer()).listen((webSocket) {
    var channel = IOWebSocketChannel(webSocket);
    scope.sinkMap[scope.sinkMap.length] = channel.sink;
    channel.stream.listen((message) {
      final request = requests[requestCount];
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment,@typescript-eslint/no-unsafe-member-access
      final response = request.error != null
          ? createError(request)
          : createReply(ReplyDef()
            ..id = request.id
            ..reply = (ReplyDetail()..result = request.result));

      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment,@typescript-eslint/no-unsafe-member-access
      scope.body[request.method] = message;
      requestCount++;
      channel.sink.add(jsonEncode(response));
    });
  });

  return scope;
}
