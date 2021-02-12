import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/rpc_provider/coder/index.dart';
import 'package:polkadot_dart/rpc_provider/http/index.dart';
import 'package:polkadot_dart/rpc_provider/types.dart';
import 'package:polkadot_dart/types/interfaces/definitions.dart';
import 'package:polkadot_dart/types/types.dart';

import '../../testUtils/throws.dart';
import '../mock/mockHttp.dart';
import 'index.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  mockProviderSendTest(); // rename this test name
}

void mockProviderSendTest() {
  var registry;
  var mock;

  setUpAll(() async {
    registry = new TypeRegistry();

    final metaJsonFile = new File('test/metadata/v12/static.json');
    final headerFile = new File('lib/types/json/Header.004.json');
    final blockFile = new File('lib/types/json/SignedBlock.004.immortal.json');
    var rpcMetadata = Map<String, dynamic>.from(jsonDecode(await metaJsonFile.readAsString()));
    var rpcHeader = Map<String, dynamic>.from(jsonDecode(await headerFile.readAsString()));
    var rpcSignedBlock = Map<String, dynamic>.from(jsonDecode(await blockFile.readAsString()));

    mock = new MockProvider(registry,
        rpcHeader: rpcHeader, rpcMetadata: rpcMetadata, rpcSignedBlock: rpcSignedBlock);
  });

  group('send', () {
    test('it emits both connected and disconnected events', () async {
      try {
        await mock.send('something_invalid', []);
      } catch (e) {
        expect(e.toString(), contains("Invalid method"));
      }
    });
    test('returns values for mocked requests', () async {
      var result = await mock.send('system_name', []);
      expect(result, 'mockClient');
    });
  });
}
