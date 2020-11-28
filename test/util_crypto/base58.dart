import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/base32.dart';
import 'package:polkadot_dart/util_crypto/base58.dart';

void main() {
  base58Test();
}

void base58Test() {
  test("base58Encode", () {
    expect(
        base58Encode(
            base32Decode('bafkreigh2akiscaildcqabsyg3dfr6chu3fgpregiymsck7e7aqa4s52zy',
                ipfsCompat: true),
            ipfsCompat: true),
        'zb2rhk6GMPQF3hfzwXTaNYFLKomMeC6UXdUt6jZKPpeVirLtV');
  });
}
