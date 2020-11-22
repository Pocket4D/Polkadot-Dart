import 'address.dart';
import 'base32.dart';
import 'base58.dart';
import 'base64.dart';
import 'blake2.dart';
import 'ethereum.dart';
import 'keccak.dart';
import 'key.dart';
import 'mnemonic.dart';
import 'nacl.dart';
import 'pbkdf2.dart';
import 'random.dart';
import 'schnorrkel.dart';
import 'scrypt.dart';
import 'secp256k1.dart';
import 'sha512.dart';
import 'signature.dart';
import 'xxhash.dart';

void main() {
  // --- util_crypto
  addressTest();
  base32Test();
  base58Test();
  base64Test();
  blake2Test();
  ethereumTest();
  keccakTest();
  keyTest();
  mnemonicTest();
  naclTest();
  pbkdf2Test();
  randomTest();
  schnorrkelTest();
  scryptTest();
  secp256k1Test();
  sha512Test();
  signatureTest();
  // typesTest();
  xxhashTest();
  //
}
