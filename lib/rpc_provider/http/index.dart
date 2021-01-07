import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/defaults.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:dio/dio.dart';

const ERROR_SUBSCRIBE = 'HTTP Provider does not have subscriptions, use WebSockets instead';

class HttpProvider implements ProviderInterface {
  RpcCoder _coder;

  String _endpoint;

  Map<String, String> _headers;

  Dio dio;

  /**
   * @param {string} endpoint The endpoint url starting with http://
   */
  HttpProvider({String endpoint = HTTP_URL, Map<String, String> headers}) {
    assert(endpoint.startsWith("http://") || endpoint.startsWith("https://"),
        "Endpoint should start with 'http://', received '$endpoint'");

    this._coder = new RpcCoder();
    this._endpoint = endpoint;
    this._headers = headers ?? Map<String, String>();
    this.dio = new Dio();
  }

  /**
   * @summary `true` when this provider supports subscriptions
   */
  bool get hasSubscriptions {
    return false;
  }

  /**
   * @description Returns a clone of the object
   */
  HttpProvider clone() {
    throw UnimplementedError();
  }

  /**
   * @description Manually connect from the connection
   */
  Future<void> connect() async {
    // noop
  }

  /**
   * @description Manually disconnect from the connection
   */
  Future<void> disconnect() async {
    // noop
  }

  /**
   * @summary Whether the node is connected or not.
   * @return {boolean} true if connected
   */
  bool get isConnected {
    return true;
  }

  /**
   * @summary Events are not supported with the HttpProvider, see [[WsProvider]].
   * @description HTTP Provider does not have 'on' emitters. WebSockets should be used instead.
   */
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  on(ProviderInterfaceEmitted type, ProviderInterfaceEmitCb sub) {
    print('HTTP Provider does not have \'on\' emitters, use WebSockets instead');

    return () {
      // noop
    };
  }

  /**
   * @summary Send HTTP POST Request with Body to configured HTTP Endpoint.
   */
  Future<dynamic> send(String method, List<dynamic> params) async {
    final body = this._coder.encodeJson(method, params);

    var options = Options(
      // // connectTimeout: 5000,
      // // receiveTimeout: 100000,
      headers: {
        "Accept": 'application/json',
        'Content-Length': "${body.length}",
        'Content-Type': 'application/json',
        ...this._headers
      },
      contentType: Headers.jsonContentType,
      // // Transform the response data to a String encoded with UTF8.
      // // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    );

    Response response;
    try {
      //404
      response = await dio.post<Map>(this._endpoint, options: options, data: body);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        throw "${e.response.statusCode}: ${e.response.statusMessage}";
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    }

    assert(response.data != null, "[${response.statusCode}]: ${response.statusMessage}");

    // // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    final result = JsonRpcResponse.fromMap(response.data);

    return this._coder.decodeResponse(result);
  }

  /**
   * @summary Subscriptions are not supported with the HttpProvider, see [[WsProvider]].
   */
  // eslint-disable-next-line @typescript-eslint/no-unused-vars,@typescript-eslint/require-await
  Future<dynamic> subscribe(
      String types, String method, List<dynamic> params, ProviderInterfaceCallback cb) {
    print(ERROR_SUBSCRIBE);

    throw ERROR_SUBSCRIBE;
  }

  /**
   * @summary Subscriptions are not supported with the HttpProvider, see [[WsProvider]].
   */
  // eslint-disable-next-line @typescript-eslint/no-unused-vars,@typescript-eslint/require-await
  Future<bool> unsubscribe(String type, String method, dynamic id) {
    print(ERROR_SUBSCRIBE);

    throw ERROR_SUBSCRIBE;
  }
}
