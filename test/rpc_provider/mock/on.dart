import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/http/index.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/types/types.dart';

import '../../testUtils/throws.dart';
import '../mock/mockHttp.dart';
import 'index.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  mockProviderOnTest(); // rename this test name
}

void mockProviderOnTest() {
  final registry = new TypeRegistry();
  final mock = new MockProvider(registry);

  group('on', () {
    test('it emits both connected and disconnected events', () {
      final events = {"connected": false, "disconnected": false};

      final handler = (ProviderInterfaceEmitted type) {
        mock.on(type, ([subValue]) {
          events[type.name] = true;
          if ((events.values).where((value) => value).length == 2) {
            print("done");
          }
        });
      };

      handler(ProviderInterfaceEmitted.connected);
      handler(ProviderInterfaceEmitted.disconnected);
    });
  });
}
