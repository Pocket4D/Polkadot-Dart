import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/mnemonic.dart';
import 'package:polkadot_dart/util_crypto/random.dart';
import 'package:polkadot_dart/util_crypto/schnorrkel.dart';
import 'package:polkadot_dart/utils/utils.dart';
import '../fixtures/schnorrkel_tests.dart';

void main() {
  schnorrkelTest();
}

void schnorrkelTest() {
  test('schnorrkel', () {
    var test2 = stringToU8a('12345678901234567890123456789012');
    var result2 = {
      "publicKey": Uint8List.fromList([
        116,
        28,
        8,
        160,
        111,
        65,
        197,
        150,
        96,
        143,
        103,
        116,
        37,
        155,
        217,
        4,
        51,
        4,
        173,
        250,
        93,
        62,
        234,
        98,
        118,
        11,
        217,
        190,
        151,
        99,
        77,
        99
      ]),
      "secretKey": Uint8List.fromList([
        240,
        16,
        102,
        96,
        195,
        221,
        162,
        63,
        22,
        218,
        169,
        172,
        91,
        129,
        27,
        150,
        48,
        119,
        245,
        188,
        10,
        248,
        159,
        133,
        128,
        79,
        13,
        232,
        228,
        36,
        240,
        80,
        249,
        141,
        102,
        243,
        148,
        66,
        80,
        111,
        249,
        71,
        253,
        145,
        31,
        24,
        199,
        167,
        165,
        218,
        99,
        154,
        99,
        232,
        211,
        180,
        226,
        51,
        247,
        65,
        67,
        217,
        81,
        193
      ])
    };

    // schnorrkelKeypairFromSeed(test2);
    expect(schnorrkelKeypairFromSeed(test2).toJson(), json.encode(result2));

    tests.forEach((t) {
      var seed = mnemonicToMiniSecret(t[0], 'Substrate');
      var pair = schnorrkelKeypairFromSeed(seed);
      expect(u8aToHex(pair.secretKey), t[3]);
    });

    var schnorrkelMessage = stringToU8a('this is a message');
    var kp = schnorrkelKeypairFromSeed(randomAsU8a());
    var schnorrkelSig = schnorrkelSign(schnorrkelMessage, kp);
    expect(schnorrkelSig.length, 64);
    expect(schnorrkelVerify(schnorrkelMessage, schnorrkelSig, kp.publicKey), true);
    // print("\n");
  });
}
