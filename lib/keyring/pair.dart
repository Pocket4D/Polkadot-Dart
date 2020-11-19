import 'dart:convert';
import 'dart:typed_data';

import 'package:p4d_rust_binding/util_crypto/util_crypto.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

class PairInfo {
  PairInfo({
    this.publicKey,
    this.secretKey,
    this.seed,
  });

  Uint8List publicKey;
  Uint8List secretKey;
  Uint8List seed;

  PairInfo copyWith({
    Uint8List publicKey,
    Uint8List secretKey,
    Uint8List seed,
  }) =>
      PairInfo(
        publicKey: publicKey ?? this.publicKey,
        secretKey: secretKey ?? this.secretKey,
        seed: seed ?? this.seed,
      );

  factory PairInfo.fromJson(String str) => PairInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PairInfo.fromMap(Map<String, dynamic> json) => PairInfo(
        publicKey: Uint8List.fromList(json["publicKey"].map((x) => x)),
        secretKey: Uint8List.fromList(json["secretKey"].map((x) => x)),
        seed: Uint8List.fromList(json["seed"].map((x) => x)),
      );

  Map<String, Uint8List> toMap() => {
        "publicKey": Uint8List.fromList(publicKey.map((x) => x)),
        "secretKey": Uint8List.fromList(secretKey.map((x) => x)),
        "seed": Uint8List.fromList(seed.map((x) => x)),
      };
}

const ENCODING = ['scrypt', 'xsalsa20-poly1305'];
const NONCE_LENGTH = 24;
// ignore: non_constant_identifier_names
final PKCS8_DIVIDER = Uint8List.fromList([161, 35, 3, 33, 0]);
// ignore: non_constant_identifier_names
final PKCS8_HEADER = Uint8List.fromList([48, 83, 2, 1, 1, 48, 5, 6, 3, 43, 101, 112, 4, 34, 4, 32]);
const PUB_LENGTH = 32;
const SALT_LENGTH = 32;
const SEC_LENGTH = 64;
const SEED_LENGTH = 32;
const SCRYPT_LENGTH = SALT_LENGTH + (3 * 4);

// ignore: non_constant_identifier_names
final SEED_OFFSET = PKCS8_HEADER.length;

PairInfo decodePkcs8(Uint8List encoded) {
  final header = encoded.sublist(0, PKCS8_HEADER.length);

  assert(header.toString() == PKCS8_HEADER.toString(), 'Invalid Pkcs8 header found in body');

  var secretKey = encoded.sublist(SEED_OFFSET, SEED_OFFSET + SEC_LENGTH);
  var divOffset = SEED_OFFSET + SEC_LENGTH;
  var divider = encoded.sublist(divOffset, divOffset + PKCS8_DIVIDER.length);

  // old-style, we have the seed here
  if (divider.toString() != PKCS8_DIVIDER.toString()) {
    divOffset = SEED_OFFSET + SEED_LENGTH;
    secretKey = encoded.sublist(SEED_OFFSET, divOffset);
    divider = encoded.sublist(divOffset, divOffset + PKCS8_DIVIDER.length);
  }

  assert(divider.toString() == PKCS8_DIVIDER.toString(), 'Invalid Pkcs8 divider found in body');

  final pubOffset = divOffset + PKCS8_DIVIDER.length;
  final publicKey = encoded.sublist(pubOffset, pubOffset + PUB_LENGTH);

  return PairInfo(publicKey: publicKey, secretKey: secretKey);
}

Future<PairInfo> decodePair(String passphrase,
    {Uint8List encrypted, List<String> encType = ENCODING}) async {
  assert(encrypted == null, 'No encrypted data available to decode');
  assert(passphrase == null || !encType.contains('xsalsa20-poly1305'),
      'Password required to decode encypted data');

  var encoded = encrypted;

  if (passphrase != null) {
    Uint8List password;

    if (encType.contains('scrypt')) {
      final scryptResult = scryptFromU8a(encrypted);
      var params = scryptResult["params"] as Map<String, int>;
      var salt = scryptResult["salt"] as Uint8List;

      password = (await scryptEncode(passphrase, salt: salt, params: params)).password;
      encrypted = encrypted.sublist(SCRYPT_LENGTH);
    } else {
      password = stringToU8a(passphrase);
    }

    encoded = naclDecrypt(encrypted.sublist(NONCE_LENGTH), encrypted.sublist(0, NONCE_LENGTH),
        u8aFixLength(password, bitLength: 256, atStart: true));
  }

  assert(encoded != null, 'Unable to decode using the supplied passphrase');

  return decodePkcs8(encoded);
}

Future<Uint8List> encodePair(PairInfo pair, String passphrase) async {
  assert(pair.secretKey != null, 'Expected a valid secretKey to be passed to encode');

  var encoded = u8aConcat([PKCS8_HEADER, pair.secretKey, PKCS8_DIVIDER, pair.publicKey]);

  if (passphrase == null) {
    return encoded;
  }

  final ScryptResult scryptResult = await scryptEncode(passphrase);
  var params = scryptResult.params;
  var password = scryptResult.password;
  var salt = scryptResult.salt;

  final naclResult = naclEncrypt(encoded, password.sublist(0, 32), null);

  return u8aConcat([scryptToU8a(salt, params.toMap()), naclResult.nonce, naclResult.encrypted]);
}
