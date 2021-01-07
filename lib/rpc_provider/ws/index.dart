import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/defaults.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/rpc_provider/ws/errors.dart';
import 'package:polkadot_dart/rpc_provider/ws/event_emitter.dart';

import 'package:polkadot_dart/utils/utils.dart';

const RETRY_DELAY = 1000;

const ALIASSES = {
  "chain_finalisedHead": 'chain_finalizedHead',
  "chain_subscribeFinalisedHeads": 'chain_subscribeFinalizedHeads',
  "chain_unsubscribeFinalisedHeads": 'chain_unsubscribeFinalizedHeads'
};

class SubscriptionHandler {
  ProviderInterfaceCallback callback;
  String type;
}

class WsStateAwaiting {
  ProviderInterfaceCallback callback;
  String method;
  List<dynamic> params;
  SubscriptionHandler subscription;
}

class WsStateSubscription extends SubscriptionHandler {
  String method;
  List<dynamic> params;
}

class WsProvider implements ProviderInterface {
  RpcCoder _coder;

  List<String> _endpoints;

  Map<String, String> _headers;

  EventEmitter _eventemitter;

  Map<String, WsStateAwaiting> _handlers = {};

  Future<WsProvider> _isReadyPromise;

  Map<String, JsonRpcResponse> _waitingForId = {};

  int _autoConnectMs;

  int _endpointIndex;

  bool _isConnected = false;

  Map<String, WsStateSubscription> _subscriptions = {};

  // ignore: close_sinks
  WebSocket _websocket;

  /// @param {string | string[]}  endpoint    The endpoint url. Usually `ws://ip:9944` or `wss://ip:9944`, may provide an array of endpoint strings.
  /// @param {boolean} autoConnect Whether to connect automatically or not.
  WsProvider(
      {dynamic endpoint = WS_URL,
      dynamic autoConnectMs = RETRY_DELAY,
      Map<String, String> headers}) {
    if (headers == null) {
      headers = Map<String, String>();
    }
    final endpoints = (endpoint is List<String>) ? endpoint : [endpoint as String];

    assert(endpoints.length != 0, 'WsProvider requires at least one Endpoint');

    endpoints.forEach((endpoint) {
      assert((endpoint).startsWith("ws://") || (endpoint).startsWith("wss://"),
          "Endpoint should start with 'ws://', received '$endpoint'");
    });

    this._eventemitter = new EventEmitter();
    this._autoConnectMs = autoConnectMs ?? 0;
    this._coder = new RpcCoder();
    this._endpointIndex = -1;
    this._endpoints = endpoints;
    this._headers = headers;
    this._websocket = null;

    if (autoConnectMs > 0) {
      this.connectWithRetry();
    }

    var _c = new Completer<WsProvider>();
    this._eventemitter.once(ProviderInterfaceEmitted.connected.name, (_) {
      _c.complete(this);
    });

    this._isReadyPromise = _c.future;
  }

  /// @summary `true` when this provider supports subscriptions
  @override
  bool get hasSubscriptions {
    return true;
  }

  /// @summary Whether the node is connected or not.
  /// @return {boolean} true if connected
  @override
  bool get isConnected {
    return this._isConnected;
  }

  /// @description Promise that resolves the first time we are connected and loaded
  Future<WsProvider> get isReady {
    return this._isReadyPromise;
  }

  @override
  ProviderInterface clone() {
    // TODO: implement clone
    return WsProvider(endpoint: this._endpoints);
  }

  @override
  Future<void> connect() async {
    // TODO: implement connect
    try {
      this._endpointIndex = (this._endpointIndex + 1) % this._endpoints.length;
      if (this._websocket == null) {
        this._websocket = await WebSocket.connect(this._endpoints[this._endpointIndex],
            headers: this._headers,
            compression: CompressionOptions(clientMaxWindowBits: 256 * 1024, enabled: true));
      }
      if (this._websocket.readyState == WebSocket.open) {
        var opened = this._onSocketOpen();

        if (opened) {
          this._websocket.listen(
              // listen on message
              this._onSocketMessage,
              // listen on close
              onDone: this._onSocketClose,
              // listen on error
              onError: this._onSocketError
              // nother futher
              );
        }
      }

      // print(this._websocket.connected);
      // this._websocket = typeof global.WebSocket !== 'undefined' && isChildClass(global.WebSocket, WebSocket)
      //   ? new WebSocket(this._endpoints[this._endpointIndex])
      //   // eslint-disable-next-line @typescript-eslint/ban-ts-comment
      //   // @ts-ignore - WS may be an instance of w3cwebsocket, which supports headers
      //   : new WebSocket(this._endpoints[this._endpointIndex], undefined, undefined, this._headers, undefined, {
      //     // default: true
      //     fragmentOutgoingMessages: true,
      //     // default: 16K
      //     fragmentationThreshold: 256 * 1024
      //   });

      // this._websocket.onclose = this._onSocketClose;
      // this._websocket.onerror = this._onSocketError;
      // this._websocket.onmessage = this._onSocketMessage;
      // this._websocket.onopen = this._onSocketOpen;
    } catch (error) {
      print(error);

      // this._emit('error', error);

      throw error;
    }
  }

  /// @description Connect, never throwing an error, but rather forcing a retry
  void connectWithRetry() async {
    try {
      await this.connect();
    } catch (error) {
      Future.delayed(Duration(milliseconds: this._autoConnectMs ?? RETRY_DELAY),
          () => this.connectWithRetry());
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      assert((this._websocket != null), 'Cannot disconnect on a non-connected websocket');

      // switch off autoConnect, we are in manual mode now
      this._autoConnectMs = 0;

      // 1000 - Normal closure; the connection successfully completed
      await this._websocket.close(1000);

      this._websocket = null;
    } catch (error) {
      this._emit(ProviderInterfaceEmitted.error, error);
      throw error;
    }
  }

  /// @summary Listens on events after having subscribed using the [[subscribe]] function.
  /// @param  {ProviderInterfaceEmitted} type Event
  /// @param  {ProviderInterfaceEmitCb}  sub  Callback
  /// @return unsubscribe function
  @override
  void Function() on(ProviderInterfaceEmitted type, ProviderInterfaceEmitCb sub) {
    this._eventemitter.on(type.name, sub);

    return () {
      this._eventemitter.off(type.name, sub);
    };
  }

  /// @summary Send JSON data using WebSockets to configured HTTP Endpoint or queue.
  /// @param method The RPC methods to execute
  /// @param params Encoded parameters as applicable for the method
  /// @param subscription Subscription details (internally used)
  @override
  Future send(String method, List params, [SubscriptionHandler subscription]) {
    /// use Completer to simulate Promise((resolve,reject));
    Completer c = new Completer();
    try {
      assert(this.isConnected && !isNull(this._websocket), 'WebSocket is not connected');
      final json = this._coder.encodeJson(method, params);
      final id = this._coder.getId();
      final callback = ([dynamic error, dynamic result]) {
        if (error != null) {
          c.completeError(error);
        } else {
          c.complete(result);
        }
      };

      this._handlers[(id.toString())] = WsStateAwaiting()
        ..callback = callback
        ..method = method
        ..params = params
        ..subscription = subscription;

      this._websocket.add(json);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  @override
  Future subscribe(String type, String method, List params, ProviderInterfaceCallback cb) async {
    final id = await this.send(
        method,
        params,
        SubscriptionHandler()
          ..callback = cb
          ..type = type);

    return id;
  }

  @override
  Future<bool> unsubscribe(String type, String method, id) async {
    final subscription = "$type::$id";

    // // FIXME This now could happen with re-subscriptions. The issue is that with a re-sub
    // // the assigned id now does not match what the API user originally received. It has
    // // a slight complication in solving - since we cannot rely on the send id, but rather
    // // need to find the actual subscription id to map it
    if ((this._subscriptions[subscription] == null)) {
      print("Unable to find active subscription=$subscription");

      return false;
    }

    // delete this._subscriptions[subscription];
    this._subscriptions.remove(subscription);
    final result = await this.send(method, [id]);
    return result;
  }

  _emit(ProviderInterfaceEmitted type, [dynamic args]) {
    this._eventemitter.emit(type.name, args);
  }

  _onSocketClose() {
    if (this._autoConnectMs > 0) {
      final code = this._websocket.closeCode;
      final reason = this._websocket.closeReason;
      print(
          "disconnected from ${this._endpoints[this._endpointIndex]}: $code::${reason ?? getWSErrorString(code)}");
    }

    this._isConnected = false;
    this._emit(ProviderInterfaceEmitted.disconnected);

    if (this._autoConnectMs > 0) {
      Future.delayed(Duration(milliseconds: this._autoConnectMs), () => this.connectWithRetry());
    }
  }

  _onSocketError(dynamic error) {
    // l.debug(() => ['socket error', error]);
    // this._emit('error', error);
    this._emit(ProviderInterfaceEmitted.error, error);
  }

  _onSocketMessage(dynamic message) {
    // l.debug(() => ['received', message.data]);
    JsonRpcResponse response;
    if (message is String) {
      response = JsonRpcResponse.fromMap(Map<String, dynamic>.from(jsonDecode(message)));
    }

    return response.method == null
        ? this._onSocketMessageResult(response)
        : this._onSocketMessageSubscribe(response);
  }

  _onSocketMessageResult(JsonRpcResponse response) {
    final handler = this._handlers[(response.id).toString()];

    if (handler == null) {
      print("Unable to find handler for id=${response.id}");
      return;
    }

    try {
      final method = handler.method;
      final params = handler.params;
      final subscription = handler.subscription;
      final result = this._coder.decodeResponse(response);

      // first send the result - in case of subs, we may have an update
      // immediately if we have some queued results already
      handler.callback(null, result);

      if (subscription != null) {
        final subId = "${subscription.type}::$result";

        this._subscriptions[subId] = WsStateSubscription()
          ..method = method
          ..params = params
          ..callback = subscription.callback
          ..type = subscription.type;

        // if we have a result waiting for this subscription already
        if (this._waitingForId[subId] != null) {
          this._onSocketMessageSubscribe(this._waitingForId[subId]);
        }
      }
    } catch (error) {
      handler.callback(error, null);
    }
    this._handlers.remove((response.id).toString());
  }

  _onSocketMessageSubscribe(JsonRpcResponse response) {
    final method = ALIASSES[response.method] ?? response.method ?? 'invalid';
    final subId = "$method::${response.params["subscription"]}";
    final handler = this._subscriptions[subId];

    if (handler == null) {
      // store the JSON, we could have out-of-order subid coming in
      this._waitingForId[subId] = response;
      // l.debug(() => `Unable to find handler for subscription=${subId}`);

      return;
    }

    // // housekeeping
    this._waitingForId.remove(subId);

    try {
      final result = this._coder.decodeResponse(response);

      handler.callback(null, result);
    } catch (error) {
      handler.callback(error, null);
    }
  }

  bool _onSocketOpen() {
    assert(!isNull(this._websocket), 'WebSocket cannot be null in onOpen');

    // l.debug(() => ['connected to', this._endpoints[this._endpointIndex]]);

    this._isConnected = true;

    this._emit(ProviderInterfaceEmitted.connected);

    this._resubscribe();
    return true;
  }

  void _resubscribe() {
    final subscriptions = this._subscriptions;

    this._subscriptions = {};

    Future.wait(subscriptions.keys.map((id) async {
      final sub = subscriptions[id];
      final callback = sub.callback;
      final method = sub.method;
      final params = sub.params;
      final type = sub.type;

      if (type.startsWith('author_')) {
        return;
      }
      try {
        await this.subscribe(type, method, params, callback);
      } catch (error) {
        print(error);
      }
    })).catchError((err) {
      print(err);
    });
  }
}
