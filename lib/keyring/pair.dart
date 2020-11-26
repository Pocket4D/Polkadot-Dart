import 'dart:convert';
import 'dart:typed_data';

import 'package:p4d_rust_binding/keyring/types.dart';
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

  factory PairInfo.fromJson(String str) => PairInfo.fromMap(jsonDecode(str));

  String toJson() => jsonEncode(toMap());

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
    [Uint8List encrypted, List<String> encType = ENCODING]) async {
  assert(encrypted != null, 'No encrypted data available to decode');
  assert(passphrase != null || (encType != null && !encType.contains('xsalsa20-poly1305')),
      'Password required to decode encypted data');

  var encoded = encrypted;
  encType = encType ?? ENCODING;
  if (passphrase != null) {
    Uint8List password;

    if (encType != null && encType.contains('scrypt')) {
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

class PairStateJson {
  String address;
  Map<String, dynamic> meta;
  PairStateJson({this.address, this.meta});
  factory PairStateJson.fromMap(Map<String, dynamic> map) => PairStateJson(
      address: map["address"] as String, meta: Map<String, dynamic>.from(map["meta"]));
}

// version 2 - nonce, encoded (previous)
// version 3 - salt, nonce, encoded
const VERSION = '3';

const ENC_NONE = ['none'];

KeyringPair$Json pairToJson(String type, PairStateJson state, Uint8List encoded, bool isEncrypted) {
  return KeyringPair$Json.fromMap({
    "address": state.address,
    "encoded": base64Encode(encoded),
    "encoding": {
      "content": ['pkcs8', type],
      "type": isEncrypted ? ENCODING : ENC_NONE,
      "version": VERSION
    },
    "meta": state.meta
  });
}

abstract class BaseSetup {
  String Function(Uint8List publicKey) toSS58Func;
  String typeString;
  String get type => typeString;
  String toSS58(Uint8List publicKey) => toSS58Func(publicKey);
}

class Setup implements BaseSetup {
  Setup({type, toSS58}) {
    typeString = type;
    toSS58Func = toSS58;
  }
  @override
  String Function(Uint8List publicKey) toSS58Func;

  @override
  String typeString;

  @override
  String toSS58(Uint8List publicKey) => toSS58Func(publicKey);

  @override
  String get type => typeString;
}

// ignore: non_constant_identifier_names
final SIG_TYPE_NONE = Uint8List.fromList([]);

// ignore: non_constant_identifier_names
final TYPE_FROM_SEED = {
  "ecdsa": secp256k1KeypairFromSeed,
  "ed25519": naclKeypairFromSeed,
  "ethereum": secp256k1KeypairFromSeed,
  "sr25519": schnorrkelKeypairFromSeed
};

// ignore: non_constant_identifier_names
final TYPE_PREFIX = {
  "ecdsa": Uint8List.fromList([2]),
  "ed25519": Uint8List.fromList([0]),
  "ethereum": Uint8List.fromList([2]),
  "sr25519": Uint8List.fromList([1])
};

// ignore: non_constant_identifier_names
final TYPE_SIGNATURE = {
  "ecdsa": (Uint8List m, KeyPair p) => secp256k1Sign(m, p, 'blake2'),
  "ed25519": naclSign,
  "ethereum": (Uint8List m, KeyPair p) => secp256k1Sign(m, p, 'keccak'),
  "sr25519": schnorrkelSign
};

// ignore: non_constant_identifier_names
final TYPE_ADDRESS = {
  "ecdsa": (Uint8List p) => p.length > 32 ? blake2AsU8a(p) : p,
  "ed25519": (Uint8List p) => p,
  "ethereum": (Uint8List p) => keccakAsU8a(secp256k1Expand(p)),
  "sr25519": (Uint8List p) => p
};

bool isEmpty(Uint8List u8a) {
  return u8a.fold(0, (count, u8) => count + u8) == 0;
}

// // Not 100% correct, since it can be a Uint8Array, but an invalid one - just say "undefined" is anything non-valid
bool isLocked(Uint8List secretKey) {
  return secretKey == null || secretKey.length == 0 || isEmpty(secretKey);
}

bool isLockedFunction(Uint8List secretKey) {
  return secretKey == null || secretKey.length == 0 || isEmpty(secretKey);
}

class CreatePairClass implements KeyringPair {
  @override
  var decodePkcs8;

  @override
  var derive;

  @override
  var encodePkcs8;

  @override
  var lock;

  @override
  var setMeta;

  @override
  var sign;

  @override
  var toJson;

  @override
  var verify;

  @override
  String get address => _address;
  String _address;

  @override
  Uint8List get addressRaw => _addressRaw;
  Uint8List _addressRaw;

  @override
  bool get isLocked => isLockedFunction(_pairInfo.secretKey);

  @override
  Map<String, dynamic> get meta => this._meta;
  Map<String, dynamic> _meta;

  @override
  Uint8List get publicKey => _publicKey;
  Uint8List _publicKey;

  @override
  String get type => _type;
  String _type;

  CreatePairClass(Setup setup, PairInfo pairInfo,
      [Map<String, dynamic> initMeta, Uint8List encoded, List<String> encTypes = ENCODING]) {
    final raw = TYPE_ADDRESS[setup.type](pairInfo.publicKey);
    final rawLength = raw.length;
    this._setup = setup;
    this._pairInfo = pairInfo;
    this._encoded = encoded;
    this._encTypes = encTypes;
    this._addressRaw = setup.type == 'ethereum' ? raw.sublist(rawLength - 20, rawLength) : raw;
    this._address = this._encodeAddress();
    this._meta = initMeta ?? Map<String, dynamic>();
    this._publicKey = pairInfo.publicKey;
    this._type = setup.type;
    this.decodePkcs8 = this._decodePkcs8;
    this.encodePkcs8 = this._encodePkcs8;
    this.derive = this._derive;
    this.lock = this._lock;
    this.setMeta = this._setMeta;
    this.sign = this._sign;
    this.toJson = this._toJson;
    this.verify = this._verify;
  }
  Setup _setup;
  PairInfo _pairInfo;

  Uint8List _encoded;
  List<String> _encTypes;
  // internal functions
  Future _decodePkcs8([String passphrase = '', Uint8List userEncoded]) async {
    final decoded = await decodePair(passphrase, userEncoded ?? _encoded, _encTypes);

    if (decoded.secretKey.length == 64) {
      _pairInfo.publicKey = decoded.publicKey;
      _pairInfo.secretKey = decoded.secretKey;
    } else {
      var pair = TYPE_FROM_SEED[_setup.type](decoded.secretKey);

      _pairInfo.publicKey = pair.publicKey;
      _pairInfo.secretKey = pair.secretKey;
    }
  }

  Future<Uint8List> _recode([String passphrase]) async {
    // print("passphrase : $passphrase");
    isLockedFunction(_pairInfo.secretKey) &&
        _encoded != null &&
        await _decodePkcs8(passphrase, _encoded);

    _encoded = await encodePair(_pairInfo, passphrase); // re-encode, latest version
    _encTypes = null; // swap to defaults, latest version follows
    return _encoded;
  }

  String _encodeAddress() {
    final raw = TYPE_ADDRESS[_setup.type](_pairInfo.publicKey);
    return _setup.type == 'ethereum' ? ethereumEncode(raw) : _setup.toSS58(raw);
  }

  KeyringPair _derive(String suri, [Map<String, dynamic> deriveMeta]) {
    assert(!isLockedFunction(_pairInfo.secretKey), 'Cannot derive on a locked keypair');

    final path = keyExtractPath(suri).path;
    final derived = keyFromPath(
        KeyPair(publicKey: _pairInfo.publicKey, secretKey: _pairInfo.secretKey), path, _setup.type);

    return createPair(_setup, PairInfo(publicKey: derived.publicKey, secretKey: derived.secretKey),
        deriveMeta, null);
  }

  Future<Uint8List> _encodePkcs8([String passphrase]) async {
    return await _recode(passphrase);
  }

  void _lock() {
    _pairInfo.secretKey = Uint8List.fromList([]);
  }

  void _setMeta(Map<String, dynamic> additional) {
    _meta = {...meta, ...additional};
  }

  Uint8List _sign(Uint8List message, [SignOptions options]) {
    assert(!isLockedFunction(_pairInfo.secretKey), 'Cannot sign with a locked key pair');
    return u8aConcat([
      options != null && options.withType ? TYPE_PREFIX[_setup.type] : SIG_TYPE_NONE,
      TYPE_SIGNATURE[_setup.type](
          message, KeyPair(publicKey: _pairInfo.publicKey, secretKey: _pairInfo.secretKey))
    ]);
  }

  Future<KeyringPair$Json> _toJson([String passphrase]) async {
    final address = ['ecdsa', 'ethereum'].contains(_setup.type)
        ? u8aToHex(secp256k1Compress(_pairInfo.publicKey))
        : _encodeAddress();

    return pairToJson(_setup.type, PairStateJson(address: address, meta: meta),
        await _recode(passphrase), passphrase != null ? true : false);
  }

  bool _verify(Uint8List message, Uint8List signature) =>
      signatureVerify(message, signature, TYPE_ADDRESS[_setup.type](_pairInfo.publicKey)).isValid;
}

///
/// @name createPair
/// @summary Creates a keyring pair object
/// @description Creates a keyring pair object with provided account public key, metadata, and encoded arguments.
/// The keyring pair stores the account state including the encoded address and associated metadata.
///
/// It has properties whose values are functions that may be called to perform account actions:
///
/// - `address` function retrieves the address associated with the account.
/// - `decodedPkcs8` function is called with the account passphrase and account encoded public key.
/// It decodes the encoded public key using the passphrase provided to obtain the decoded account public key
/// and associated secret key that are then available in memory, and changes the account address stored in the
/// state of the pair to correspond to the address of the decoded public key.
/// - `encodePkcs8` function when provided with the correct passphrase associated with the account pair
/// and when the secret key is in memory (when the account pair is not locked) it returns an encoded
/// public key of the account.
/// - `meta` is the metadata that is stored in the state of the pair, either when it was originally
/// created or set via `setMeta`.
/// - `publicKey` returns the public key stored in memory for the pair.
/// - `sign` may be used to return a signature by signing a provided message with the secret
/// key (if it is in memory) using Nacl.
/// - `toJson` calls another `toJson` function and provides the state of the pair,
/// it generates arguments to be passed to the other `toJson` function including an encoded public key of the account
/// that it generates using the secret key from memory (if it has been made available in memory)
/// and the optionally provided passphrase argument. It passes a third boolean argument to `toJson`
/// indicating whether the public key has been encoded or not (if a passphrase argument was provided then it is encoded).
/// The `toJson` function that it calls returns a JSON object with properties including the `address`
/// and `meta` that are assigned with the values stored in the corresponding state variables of the account pair,
/// an `encoded` property that is assigned with the encoded public key in hex format, and an `encoding`
/// property that indicates whether the public key value of the `encoded` property is encoded or not.
///
// KeyringPair createPair(Setup setup, PairInfo pairInfo,
//     [Map<String, dynamic> meta, Uint8List encoded, List<String> encTypes = ENCODING]) {
//   if (meta == null) meta = Map<String, dynamic>();

//   final decodePkcs8 = ([String passphrase = '', Uint8List userEncoded]) async {
//     final decoded = await decodePair(passphrase, userEncoded ?? encoded, encTypes);

//     if (decoded.secretKey.length == 64) {
//       pairInfo.publicKey = decoded.publicKey;
//       pairInfo.secretKey = decoded.secretKey;
//     } else {
//       var pair = TYPE_FROM_SEED[setup.type](decoded.secretKey);

//       pairInfo.publicKey = pair.publicKey;
//       pairInfo.secretKey = pair.secretKey;
//     }
//   };

//   final recode = ([String passphrase]) async {
//     // print("passphrase : $passphrase");
//     isLocked(pairInfo.secretKey) && encoded != null && await decodePkcs8(passphrase, encoded);

//     encoded = await encodePair(pairInfo, passphrase); // re-encode, latest version
//     encTypes = null; // swap to defaults, latest version follows
//     return encoded;
//   };

//   final encodeAddress = () {
//     final raw = TYPE_ADDRESS[setup.type](pairInfo.publicKey);
//     return setup.type == 'ethereum' ? ethereumEncode(raw) : setup.toSS58(raw);
//   };

//   final raw = TYPE_ADDRESS[setup.type](pairInfo.publicKey);
//   final rawLength = raw.length;
//   final addressRaw = setup.type == 'ethereum' ? raw.sublist(rawLength - 20, rawLength) : raw;

//   final pair = BaseKeyringPair(
//       address: encodeAddress(),
//       addressRaw: addressRaw,
//       isLocked: isLocked(pairInfo.secretKey),
//       meta: meta,
//       publicKey: pairInfo.publicKey,
//       type: setup.type);

//   pair.decodePkcs8 = decodePkcs8;
//   pair.derive = (String suri, [Map<String, dynamic> meta]) {
//     assert(!isLocked(pairInfo.secretKey), 'Cannot derive on a locked keypair');

//     final path = keyExtractPath(suri).path;
//     final derived = keyFromPath(
//         KeyPair(publicKey: pairInfo.publicKey, secretKey: pairInfo.secretKey), path, setup.type);

//     return createPair(
//         setup, PairInfo(publicKey: derived.publicKey, secretKey: derived.secretKey), meta, null);
//   };
//   pair.encodePkcs8 = ([String passphrase]) async {
//     return await recode(passphrase);
//   };
//   pair.lock = () {
//     pairInfo.secretKey = Uint8List.fromList([]);
//   };
//   pair.setMeta = (Map<String, dynamic> additional) {
//     pair.newMeta = {...meta, ...additional};
//   };
//   pair.sign = (Uint8List message, [SignOptions options]) {
//     assert(!isLocked(pairInfo.secretKey), 'Cannot sign with a locked key pair');
//     return u8aConcat([
//       options != null && options.withType ? TYPE_PREFIX[setup.type] : SIG_TYPE_NONE,
//       TYPE_SIGNATURE[setup.type](
//           message, KeyPair(publicKey: pairInfo.publicKey, secretKey: pairInfo.secretKey))
//     ]);
//   };
//   pair.toJson = ([String passphrase]) async {
//     final address = ['ecdsa', 'ethereum'].contains(setup.type)
//         ? u8aToHex(secp256k1Compress(pairInfo.publicKey))
//         : encodeAddress();

//     return pairToJson(setup.type, PairStateJson(address: address, meta: meta),
//         await recode(passphrase), passphrase != null ? true : false);
//   };
//   pair.verify = (Uint8List message, Uint8List signature) =>
//       signatureVerify(message, signature, TYPE_ADDRESS[setup.type](pairInfo.publicKey)).isValid;

//   return pair;
// }

KeyringPair createPair(Setup setup, PairInfo pairInfo,
    [Map<String, dynamic> meta, Uint8List encoded, List<String> encTypes]) {
  return CreatePairClass(setup, pairInfo, meta, encoded, encTypes);
}
