import 'dart:typed_data';

import 'package:polkadot_dart/crypto/crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

class Pbkdf2Result {
  final Uint8List password;
  final int rounds;
  final Uint8List salt;
  Pbkdf2Result({required this.password, required this.rounds, required this.salt});
}

Future<Pbkdf2Result> pbkdf2Encode(dynamic passphrase, Uint8List salt, [int rounds = 2048]) async {
  final u8aPass = u8aToU8a(passphrase);
  final u8aSalt = u8aToU8a(salt);
  final password = await pbkdf2(u8aPass.u8aToString(), u8aSalt.u8aToString(), rounds);

  return Pbkdf2Result(password: password.toU8a(), rounds: rounds, salt: salt);
}
