import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/util_crypto/scrypt.dart';

void main() {
  scryptTest();
}

void scryptTest() async {
  test('scryptEncode', () async {
    var scryptEncoded = await scryptEncode("123123123");
    var salt = scryptEncoded.salt;
    var sU8a = scryptToU8a(salt, scryptEncoded.params.toMap());
    var mU8a = scryptFromU8a(sU8a);
    expect(mU8a["salt"], salt);
    // print("\n");
  });
}
