import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/crypto/common.dart';
import 'package:polkadot_dart/polkadot_dart.dart';
import 'package:polkadot_dart/util_crypto/random.dart';
import 'package:polkadot_dart/utils/number.dart';

const DEFAULT_PARAMS = {"N": 1 << 15, "p": 1, "r": 8};

class ScryptParams {
  const ScryptParams({
    required this.n,
    required this.p,
    required this.r,
  });

  final int n;
  final int p;
  final int r;

  ScryptParams copyWith({
    int? n,
    int? p,
    int? r,
  }) =>
      ScryptParams(
        n: n ?? this.n,
        p: p ?? this.p,
        r: r ?? this.r,
      );

  factory ScryptParams.fromJson(String str) => ScryptParams.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScryptParams.fromMap(Map<String, dynamic> json) => ScryptParams(
        n: json["N"],
        p: json["p"],
        r: json["r"],
      );

  Map<String, int> toMap() => {
        "N": n,
        "p": p,
        "r": r,
      };
}

class ScryptResult {
  final ScryptParams params;
  final Uint8List password;
  final Uint8List salt;
  ScryptResult({required this.params, required this.password, required this.salt});

  factory ScryptResult.fromMap(Map<String, dynamic> json) => ScryptResult(
        params: ScryptParams.fromMap(json["params"] as Map<String, dynamic>),
        password: json["password"] as Uint8List,
        salt: json["salt"] as Uint8List,
      );

  Map<String, dynamic> toMap() => {
        "params": params,
        "password": password,
        "salt": salt,
      };
}

Future<ScryptResult> scryptEncode(dynamic passphrase,
    {Uint8List? salt, Map<String, int> params = DEFAULT_PARAMS}) async {
  if (salt == null) {
    salt = randomAsU8a();
  }
  final sParams = ScryptParams.fromMap(params);

  var result = await scrypt(
      passphrase, salt.toHex(include0x: true), log2(sParams.n).floor(), sParams.r, sParams.p);

  return ScryptResult.fromMap(
      {"params": params, "password": result.hexAddPrefix().toU8a(), "salt": salt});
}

Uint8List scryptToU8a(Uint8List salt, Map<String, int> params) {
  final sParams = ScryptParams.fromMap(params);
  return u8aConcat([
    salt,
    BigInt.from(sParams.n).toU8a(bitLength: 32, endian: Endian.little),
    BigInt.from(sParams.p).toU8a(bitLength: 32, endian: Endian.little),
    BigInt.from(sParams.r).toU8a(bitLength: 32, endian: Endian.little)
  ]);
}

Map<String, dynamic> scryptFromU8a(Uint8List data) {
  final salt = data.sublist(0, 32);
  final N = data.sublist(32 + 0, 32 + 4).toBn(endian: Endian.little).toInt();
  final p = data.sublist(32 + 4, 32 + 8).toBn(endian: Endian.little).toInt();
  final r = data.sublist(32 + 8, 32 + 12).toBn(endian: Endian.little).toInt();

  // FIXME At this moment we assume these to be fixed params, this is not a great idea since we lose flexibility
  // and updates for greater security. However we need some protection against carefully-crafted params that can
  // eat up CPU since these are user inputs. So we need to get very clever here, but atm we only allow the defaults
  // and if no match, bail out
  assert(N == DEFAULT_PARAMS["N"] && p == DEFAULT_PARAMS["p"] && r == DEFAULT_PARAMS["r"],
      'Invalid injected scrypt params found');
  final sParams = ScryptParams(n: N, p: p, r: r);
  return {"params": sParams.toMap(), "salt": salt};
}
