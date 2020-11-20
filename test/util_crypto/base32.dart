// TODO
import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/util_crypto/base32.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

void main() {
  base32Test();
}

void base32Test() {
  test('base32Decode', () {
    expect(base32Decode('irswgzloorzgc3djpjssazlwmvzhs5dinfxgoijb').u8aToString(),
        "Decentralize everything!!");
    expect(
        base32Decode('birswgzloorzgc3djpjssazlwmvzhs5dinfxgoijb', ipfsCompat: true).u8aToString(),
        "Decentralize everything!!");
  });

  test('base32Encode', () {
    expect(base32Encode('Decentralize everything!!'), 'irswgzloorzgc3djpjssazlwmvzhs5dinfxgoijb');
    expect(base32Encode('Decentralize everything!!', ipfsCompat: true),
        'birswgzloorzgc3djpjssazlwmvzhs5dinfxgoijb');
  });

  test('base32Validate', () {
    expect(
        () => base32Validate('bafkreigh2akiscaildcqabsyg3dfr6chu3fgpregiymsck7e7aqa4s52zy',
            ipfsCompat: true),
        returnsNormally);
  });
}
