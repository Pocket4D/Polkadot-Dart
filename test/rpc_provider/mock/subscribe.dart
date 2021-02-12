import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';

import '../../testUtils/throws.dart';
import 'index.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

/// FIXME: should make this work

void main() {
  mockProviderSubscribeTest(); // rename this test name
}

void mockProviderSubscribeTest() {
  var registry;
  MockProvider mock;

  setUp(() async {
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
    // test('fails on unknown methods', () {
    //   expect(() => mock.subscribe('test', 'test_notFound', [], (err, val) => null),
    //       throwsA(assertionThrowsContains("Invalid method 'test_notFound'")));
    // });

    // test('returns a subscription id', () {
    //   mock
    //       .subscribe('chain_newHead', 'chain_subscribeNewHead', null, (err, val) => null)
    //       .then((id) {
    //     expect(id, 1);
    //   });
    // });

    // test('calls back with the last known value', () async {
    //   mock.isUpdating = false;
    //   //  mock.subscriptions["chain_subscribeNewHead"]["lastValue"] = 'testValue';

    //   await mock.subscribe('chain_newHead', 'chain_subscribeNewHead', [], (_, value) {
    //     expect(value, mock.subscriptions["chain_subscribeNewHead"]["lastValue"]);
    //     // done();
    //   });
    // });

    // test('calls back with new headers', () {
    //   mock.subscribe('chain_newHead', 'chain_subscribeNewHead', [], (_, header) {
    //     if (header["number"] == 4) {
    //       print("done");
    //       // emitsDone;

    //       // done();
    //     }
    //   });
    // });

    test('handles errors withing callbacks gracefully', () {
      // var hasThrown = false;

      mock.subscribe('chain_newHead', 'chain_subscribeNewHead', [], (_, header) {
        // if (!hasThrown) {
        //   hasThrown = true;

        //   throw 'testing';
        // }

        // expect(header, lv);

        // expect(header, mock.subscriptions["chain_subscribeNewHead"]["lastValue"]);

        if (header["number"] == 3) {
          print("done");
        }
      });
    });
  });
}
