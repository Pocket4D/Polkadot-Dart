import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/crypto.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

class Pbkdf2Result {
  Uint8List password;
  int rounds;
  Uint8List salt;
  Pbkdf2Result({this.password, this.rounds, this.salt});
}

Future<Pbkdf2Result> pbkdf2Encode(dynamic passphrase, Uint8List salt, [int rounds = 2048]) async {
  final u8aPass = u8aToU8a(passphrase);
  final u8aSalt = u8aToU8a(salt);
  final password = await pbkdf2(u8aPass.u8aToString(), u8aSalt.u8aToString(), rounds);

  return Pbkdf2Result(password: password.toU8a(), rounds: rounds, salt: salt);
}
