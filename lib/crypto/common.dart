import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:p4d_rust_binding/bindings/bindings.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

String bip39Generate(int wordsNumber) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final phrasePointer = rustBip39(wordsNumber);
  final resultString = Utf8.fromUtf8(phrasePointer);
  freeCString(phrasePointer);
  return throwReturn(resultString);
}

bool bip39Validate(String phrase) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final phrasePointer = rustBip39Validate(phrase.toUtf8());
  return phrasePointer == 1;
}

String bip39ToEntropy(String phrase) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToEntropy(phrase.toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String bip39ToMiniSecret(String phrase, String password) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToMiniSecret(phrase.toUtf8(), password.toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String bip39ToSeed(String phrase, String password) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToSeed(phrase.toUtf8(), password.toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

// common::tests::can_pbkdf2
// common::tests::can_scrypt
// common::tests::can_sha512
// common::tests::can_twox
// common::tests::can_xxhash64

/// data have to be `hex` without `0x`
String blake2b(String data, String password, int size) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(data)) {
    throw "ERROR: `data` should be `hex` without `0x`";
  }
  final result = rustBlake2b(
      data.hexStripPrefix().toUtf8(), password.plainToHex().hexStripPrefix().toUtf8(), size);
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String keccak256(String data) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(data)) {
    throw "ERROR: `data` should be `hex` without `0x`";
  }
  final result = rustKeccak256(data.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String sha512(String data) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustSha512(data.plainToHex().hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String xxhash(String data, int seed) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  var result = rustXxhash64(data.plainToHex().hexStripPrefix().toUtf8(), seed);
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

Future<String> pbkdf2(String data, String salt, int rounds) async {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final response = new ReceivePort();
  await Isolate.spawn(
    _isolatePbkdf2,
    response.sendPort,
    onExit: response.sendPort,
  );
  final sendPort = await response.first as SendPort;
  final receivePort = new ReceivePort();
  sendPort.send([data, salt, rounds, receivePort.sendPort]);

  try {
    final result = await receivePort.first;
    final resultString = result.toString();
    response.close();

    return throwReturn(resultString);
  } catch (e) {
    rethrow;
  }
}

void _isolatePbkdf2(SendPort initialReplyTo) {
  final port = new ReceivePort();

  initialReplyTo.send(port.sendPort);

  port.listen((message) async {
    try {
      final data = message[0] as String;
      final salt = message[1] as String;
      final rounds = message[2] as int;
      final send = message.last as SendPort;
      var encrypted;
      encrypted = rustPbkdf2(data.plainToHex().hexStripPrefix().toUtf8(),
          salt.plainToHex().hexStripPrefix().toUtf8(), rounds);
      final result = Utf8.fromUtf8(encrypted);
      freeCString(encrypted);
      send.send(result);
    } catch (e) {
      message.last.send(e);
    }
  });
}

Future<String> scrypt(String password, String salt, int log2N, int r, int p) async {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final response = new ReceivePort();
  await Isolate.spawn(
    _isolateScrypt,
    response.sendPort,
    onExit: response.sendPort,
  );
  final sendPort = await response.first as SendPort;
  final receivePort = new ReceivePort();
  sendPort.send([password, salt, log2N, r, p, receivePort.sendPort]);

  try {
    final result = await receivePort.first;
    final resultString = result.toString();
    response.close();
    return throwReturn(resultString);
  } catch (e) {
    rethrow;
  }
}

void _isolateScrypt(SendPort initialReplyTo) {
  final port = new ReceivePort();

  initialReplyTo.send(port.sendPort);

  port.listen((message) async {
    try {
      final password = message[0] as String;
      final salt = message[1] as String;
      final log2N = message[2] as int;
      final r = message[3] as int;
      final p = message[4] as int;
      final send = message.last as SendPort;
      var encrypted;
      encrypted = rustScrypt(password.plainToHex().hexStripPrefix().toUtf8(),
          salt.plainToHex().hexStripPrefix().toUtf8(), log2N, r, p);
      final result = Utf8.fromUtf8(encrypted);
      freeCString(encrypted);
      send.send(result);
    } catch (e) {
      message.last.send(e);
    }
  });
}

Future<String> twox(String data, int rounds) async {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final response = new ReceivePort();
  await Isolate.spawn(
    _isolateTwox,
    response.sendPort,
    onExit: response.sendPort,
  );
  final sendPort = await response.first as SendPort;
  final receivePort = new ReceivePort();
  sendPort.send([data, rounds, receivePort.sendPort]);

  try {
    final result = await receivePort.first;
    final resultString = result.toString();
    response.close();
    return throwReturn(resultString);
  } catch (e) {
    rethrow;
  }
}

void _isolateTwox(SendPort initialReplyTo) {
  final port = new ReceivePort();

  initialReplyTo.send(port.sendPort);

  port.listen((message) async {
    try {
      final data = message[0] as String;
      final rounds = message[1] as int;
      final send = message.last as SendPort;
      var encrypted;
      encrypted = rustTwox(data.plainToHex().hexStripPrefix().toUtf8(), rounds);
      final result = Utf8.fromUtf8(encrypted);
      freeCString(encrypted);
      send.send(result);
    } catch (e) {
      message.last.send(e);
    }
  });
}

/// `seed` should be `hex` without `0x`
String bip32GetPrivateKey(String seed, String path) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(seed)) throw "ERROR: `seed` should be `hex` without `0x`";
  final result =
      rustBip32GetPrivateKey(seed.hexStripPrefix().toUtf8(), path.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `privateKey` should be `hex` without `0x`
String ed25519GetPubFromPrivate(String privateKey) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(privateKey)) throw "ERROR: `privateKey` should be `hex` without `0x`";
  final result = rustEd25519GetPubFromPrivate(privateKey.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `privateKey` should be `hex` without `0x`
String secp256k1GetPubFromPrivate(String privateKey) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(privateKey)) throw "ERROR: `privateKey` should be `hex` without `0x`";
  final result = rustSecp256k1GetPubFromPrivate(privateKey.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

String secp256k1RecoverPublic(String message, String signature, int recoveryId) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(message)) throw "ERROR: `message` should be `hex` without `0x`";
  if (!isHexString(signature)) throw "ERROR: `signature` should be `hex` without `0x`";
  final result = rustSecp256k1Recover(
      message.hexStripPrefix().toUtf8(), signature.hexStripPrefix().toUtf8(), recoveryId);
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `pubKey` should be `hex` without `0x`
String secp256k1GetCompressPub(String pubKey) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(pubKey)) throw "ERROR: `pubKey` should be `hex` without `0x`";
  final result = rustSecp256k1GetCompressPub(pubKey.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `seed` should be `hex` without `0x`
String sr25519GetPubFromSeed(String seed) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(seed)) throw "ERROR: `seed` should be `hex` without `0x`";
  final result = rustSr25519GetPubFromSeed(seed.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `seed` should be `hex` without `0x`
String ed25519KeypairFromSeed(String seed) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(seed)) throw "ERROR: `seed` should be `hex` without `0x`";
  final result = rustEd25519KeypairFromSeed(seed.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `pubkey`,`seckey`,`message` should be `hex` without `0x`
String ed25519Sign(String pubkey, String seckey, String message) {
  if (dylib == null) {
    throw "ERROR: The library is not initialized 🙁";
  }

  if (!isHexString(pubkey)) {
    throw "ERROR: `pubkey` should be `hex` without `0x`";
  }
  if (!isHexString(seckey)) {
    throw "ERROR: `seckey` should be `hex` without `0x`";
  }
  if (!isHexString(message)) {
    throw "ERROR: `message` should be `hex` without `0x`";
  }

  final result = rustEd25519Sign(pubkey.hexStripPrefix().toUtf8(), seckey.hexStripPrefix().toUtf8(),
      message.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `signature`,`message`,`pubkey` should be `hex` without `0x`
bool ed25519Verify(String signature, String message, String pubkey) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(signature)) throw "ERROR: `signature` should be `hex` without `0x`";
  if (!isHexString(message)) throw "ERROR: `message` should be `hex` without `0x`";
  if (!isHexString(pubkey)) throw "ERROR: `pubkey` should be `hex` without `0x`";
  final result = rustEd25519Verify(signature.hexStripPrefix().toUtf8(),
      message.hexStripPrefix().toUtf8(), pubkey.hexStripPrefix().toUtf8());
  return result == 1;
}

/// `pair`,`cc`,should be `hex` without `0x`
String sr25519DeriveKeypairHard(String pair, String cc) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(pair)) throw "ERROR: `pair` should be `hex` without `0x`";
  if (!isHexString(cc)) throw "ERROR: `cc` should be `hex` without `0x`";

  final result =
      rustSr25519DeriveKeypairHard(pair.hexStripPrefix().toUtf8(), cc.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `pair`,`cc`,should be `hex` without `0x`
String sr25519DeriveKeypairSoft(String pair, String cc) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(pair)) throw "ERROR: `pair` should be `hex` without `0x`";
  if (!isHexString(cc)) throw "ERROR: `cc` should be `hex` without `0x`";
  final result =
      rustSr25519DeriveKeypairSoft(pair.hexStripPrefix().toUtf8(), cc.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `pair`,`cc`,should be `hex` without `0x`
String sr25519DerivePublicSoft(String public, String cc) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(public)) throw "ERROR: `public` should be `hex` without `0x`";
  if (!isHexString(cc)) throw "ERROR: `cc` should be `hex` without `0x`";
  final result =
      rustSr25519DerivePublicSoft(public.hexStripPrefix().toUtf8(), cc.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `seed`,should be `hex` without `0x`
String sr25519KeypairFromSeed(String seed) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(seed)) throw "ERROR: `seed` should be `hex` without `0x`";
  final result = rustSr25519KeypairFromSeed(seed.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

/// `seed`,should be `hex` without `0x`
String sr25519KeypairFromPair(String seed) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(seed)) throw "ERROR: `seed` should be `hex` without `0x`";
  final result = rustSr25519KeypairFromPair(seed.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `pubkey`,`seckey` and `message` should be `hex` without `0x`
String sr25519Sign(String pubkey, String seckey, String message) {
  if (dylib == null) {
    throw "ERROR: The library is not initialized 🙁";
  }
  if (!isHexString(seckey)) {
    throw "ERROR: `seckey` should be `hex` without `0x`";
  }
  if (!isHexString(message)) {
    throw "ERROR: `message` should be `hex` without `0x`";
  }
  if (!isHexString(pubkey)) {
    throw "ERROR: `pubkey` should be `hex` without `0x`";
  }
  final result = rustSr25519Sign(pubkey.hexStripPrefix().toUtf8(), seckey.hexStripPrefix().toUtf8(),
      message.hexStripPrefix().toUtf8());
  final resultString = Utf8.fromUtf8(result);
  freeCString(result);
  return throwReturn(resultString);
}

/// `signature`,`message` and `pubkey` should be `hex` without `0x`
bool sr25519Verify(String signature, String message, String pubkey) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  if (!isHexString(signature)) throw "ERROR: `signature` should be `hex` without `0x`";
  if (!isHexString(message)) throw "ERROR: `message` should be `hex` without `0x`";
  if (!isHexString(pubkey)) throw "ERROR: `pubkey` should be `hex` without `0x`";
  final result = rustSr25519Verify(signature.hexStripPrefix().toUtf8(),
      message.hexStripPrefix().toUtf8(), pubkey.hexStripPrefix().toUtf8());
  return result == 1;
}
