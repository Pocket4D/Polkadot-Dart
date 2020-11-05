import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:p4d_rust_binding/bindings/ffi_base.dart';
import 'package:p4d_rust_binding/bindings/ffi_helpers.dart';
import 'package:p4d_rust_binding/wrapper/util.dart';

String bip39Generate(int wordsNumber) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final phrasePointer = rustBip39(wordsNumber);
  return Utf8.fromUtf8(phrasePointer);
}

bool bip39Validate(String phrase) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final phrasePointer = rustBip39Validate(Utf8.toUtf8(phrase));
  return phrasePointer == 1;
}

String bip39ToEntropy(String phrase) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToEntropy(Utf8.toUtf8(phrase));
  var resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

String bip39ToMiniSecret(String phrase, String password) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToMiniSecret(Utf8.toUtf8(phrase), Utf8.toUtf8(password));
  var resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

String bip39ToSeed(String phrase, String password) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBip39ToSeed(Utf8.toUtf8(phrase), Utf8.toUtf8(password));
  var resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

String blake2b(String data, String password, int size) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustBlake2b(Utf8.toUtf8(data), Utf8.toUtf8(password), size);
  var resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

String keccak256(String data) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustKeccak256(Utf8.toUtf8(data));
  var resultString = Utf8.fromUtf8(result);
  return throwReturn(resultString);
}

String sha512(String data) {
  if (dylib == null) throw "ERROR: The library is not initialized 🙁";
  final result = rustSha512(Utf8.toUtf8(data));
  var resultString = Utf8.fromUtf8(result);
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
    var resultString = result.toString();
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
      encrypted = rustPbkdf2(Utf8.toUtf8(data), Utf8.toUtf8(salt), rounds);
      send.send(Utf8.fromUtf8(encrypted));
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
    var resultString = result.toString();
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
      encrypted = rustScrypt(Utf8.toUtf8(password), Utf8.toUtf8(salt), log2N, r, p);
      send.send(Utf8.fromUtf8(encrypted));
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
    var resultString = result.toString();
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
      encrypted = rustTwox(Utf8.toUtf8(data), rounds);
      send.send(Utf8.fromUtf8(encrypted));
    } catch (e) {
      message.last.send(e);
    }
  });
}
