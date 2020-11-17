import 'dart:convert';
import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';
import 'package:p4d_rust_binding/util_crypto/random.dart';
import 'package:p4d_rust_binding/utils/number.dart';

const DEFAULT_PARAMS = {"N": 1 << 15, "p": 1, "r": 8};

class ScryptParams {
  const ScryptParams({
    this.n,
    this.p,
    this.r,
  });

  final int n;
  final int p;
  final int r;

  ScryptParams copyWith({
    int n,
    int p,
    int r,
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

Future<Map<String, dynamic>> scryptEncode(dynamic passphrase,
    {Uint8List salt, Map<String, int> params = DEFAULT_PARAMS}) async {
  if (salt == null) {
    salt = randomAsU8a();
  }
  final sParams = ScryptParams.fromMap(params);

  var result = await scrypt(
      passphrase, u8aToHex(salt, include0x: true), log2(sParams.n).floor(), sParams.r, sParams.p);

  return {...params, "password": hexToU8a(hexAddPrefix(result)), "salt": salt};
}

Uint8List scryptToU8a(Uint8List salt, Map<String, int> params) {
  final sParams = ScryptParams.fromMap(params);
  return u8aConcat([
    salt,
    bnToU8a(BigInt.from(sParams.n), bitLength: 32, endian: Endian.little),
    bnToU8a(BigInt.from(sParams.p), bitLength: 32, endian: Endian.little),
    bnToU8a(BigInt.from(sParams.r), bitLength: 32, endian: Endian.little)
  ]);
}

Map<String, dynamic> scryptFromU8a(Uint8List data) {
  final salt = data.sublist(0, 32);
  final N = u8aToBn(data.sublist(32 + 0, 32 + 4), endian: Endian.little).toInt();
  final p = u8aToBn(data.sublist(32 + 4, 32 + 8), endian: Endian.little).toInt();
  final r = u8aToBn(data.sublist(32 + 8, 32 + 12), endian: Endian.little).toInt();

  // FIXME At this moment we assume these to be fixed params, this is not a great idea since we lose flexibility
  // and updates for greater security. However we need some protection against carefully-crafted params that can
  // eat up CPU since these are user inputs. So we need to get very clever here, but atm we only allow the defaults
  // and if no match, bail out
  assert(N == DEFAULT_PARAMS["N"] && p == DEFAULT_PARAMS["p"] && r == DEFAULT_PARAMS["r"],
      'Invalid injected scrypt params found');
  final sParams = ScryptParams(n: N, p: p, r: r);
  return {...sParams.toMap(), "salt": salt};
}
