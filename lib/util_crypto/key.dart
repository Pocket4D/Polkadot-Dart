import 'dart:typed_data';

import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/is.dart';
import 'package:polkadot_dart/utils/utils.dart';

final regNumber = RegExp(r"^\d+$");
final regJunction = RegExp(r"(//?)([^/]+)");
final regCapture = RegExp(r"(\w+( \w+)*)((//?[^/]+)*)(///(.*))?$");

const JUNCTION_ID_LEN = 32;

class BNOPTIONS {
  static int bitLength = 256;
  static bool isLe = true;
}

class ExtractResultPath {
  List<String> parts;
  List<DeriveJunction> path;
  ExtractResultPath({this.parts, this.path});
}

class ExtractResultSuri {
  String password;
  List<DeriveJunction> path;
  String phrase;
  ExtractResultSuri({this.password, this.path, this.phrase});
}

class DeriveJunction {
  Uint8List _chainCode = Uint8List(32);

  bool _isHard = false;

  DeriveJunction();

  factory DeriveJunction.from(String value) {
    final result = DeriveJunction();
    final codeIsHard = value.startsWith('/') ? [value.substring(1), true] : [value, false];

    final code = codeIsHard[0] as String;
    final isHard = codeIsHard[1] as bool;
    result.soft(regNumber.allMatches(code).isNotEmpty ? int.parse(code, radix: 10) : code);

    return isHard ? result.harden() : result;
  }

  Uint8List get chainCode {
    return this._chainCode;
  }

  bool get isHard {
    return this._isHard;
  }

  bool get isSoft {
    return !this._isHard;
  }

  DeriveJunction hard(dynamic value) {
    return this.soft(value).harden();
  }

  DeriveJunction harden() {
    this._isHard = true;

    return this;
  }

  DeriveJunction soft(dynamic value) {
    if (isNumber(value) || isBn(value)) {
      return this.soft(bnToHex(BigInt.parse(value.toString()),
          bitLength: BNOPTIONS.bitLength, endian: BNOPTIONS.isLe ? Endian.little : Endian.big));
    } else if (isString(value)) {
      return isHex(value)
          ? this.soft(hexToU8a(value))
          : this.soft(compactAddLength(stringToU8a(value)));
    }

    if (value.length > JUNCTION_ID_LEN) {
      return this.soft(blake2AsU8a(value));
    }
    this._chainCode.fillRange(0, this._chainCode.length, 0);
    this._chainCode.setAll(0, value);

    return this;
  }

  DeriveJunction soften() {
    this._isHard = false;

    return this;
  }
}

ExtractResultPath keyExtractPath(String derivePath) {
  final parts = regJunction.allMatches(derivePath)?.map((m) => m.group(0))?.toList();
  final List<DeriveJunction> path = [];
  var constructed = '';
  if (parts != null) {
    constructed = parts.join('');
    parts.forEach((value) {
      path.add(DeriveJunction.from(value.substring(1)));
    });
  }

  assert(constructed == derivePath, "Re-constructed path $constructed does not match input");
  return ExtractResultPath(parts: parts, path: path);
}

ExtractResultSuri keyExtractSuri(String suri) {
  final match = regCapture.firstMatch(suri);
  assert(!isNull(match), 'Unable to match provided value to a secret URI');
  final phrase = match.group(1) ?? "";
  final derivePath = match.group(3) ?? "";
  final password = match.group(6) ?? "";

  return ExtractResultSuri(
      password: password, path: keyExtractPath(derivePath).path, phrase: phrase);
}

//TODO  from pair needs schnorrkel,secp256k1,ecdsa

KeyPair keyHdkdEcdsa(KeyPair keypair, DeriveJunction derive) {
  assert(derive.isHard, 'A soft key was found in the path (and is unsupported)');

  return secp256k1KeypairFromSeed(
      secp256k1DeriveHard(keypair.secretKey.sublist(0, 32), derive.chainCode));
}

KeyPair keyHdkdEd25519(KeyPair keypair, DeriveJunction derive) {
  assert(derive.isHard, 'A soft key was found in the path (and is unsupported)');

  return naclKeypairFromSeed(naclDeriveHard(keypair.secretKey.sublist(0, 32), derive.chainCode));
}

KeyPair keyHdkdSr25519(KeyPair keypair, DeriveJunction derive) {
  return derive.isSoft
      ? schnorrkelDeriveSoft(keypair, derive.chainCode)
      : schnorrkelDeriveHard(keypair, derive.chainCode);
}

const generators = {
  KeypairType.ecdsa: keyHdkdEcdsa,
  KeypairType.ed25519: keyHdkdEd25519,
  KeypairType.ethereum: keyHdkdEcdsa,
  KeypairType.sr25519: keyHdkdSr25519
};

KeyPair keyFromPath(KeyPair keypair, List<DeriveJunction> path, String type) {
  final keyHdkd = generators[type];
  return path.fold(keypair, (pair, junction) => keyHdkd(pair, junction));
}
