import 'package:polkadot_dart/direct/ifunction.dart';

abstract class Unsubscribe<T> {
  T unsubscribe(int subscriptionId);
}

abstract class SubscribeCallback<T> {
  void callback(T t);
}

abstract class IRpcFunction<T> extends IFunction {
  Future<T> invoke(Object params);

  bool isSubscribe() {
    return false;
  }

  // ignore: missing_return
  Future unsubscribe(int subscriptionId) {
    //
  }
}
