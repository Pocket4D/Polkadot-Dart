import 'dart:typed_data';

import 'package:polkadot_dart/keyring/defaults.dart';
import 'package:polkadot_dart/keyring/pair.dart';
import 'package:polkadot_dart/keyring/pairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart' as utilCrypto;
import 'package:polkadot_dart/utils/utils.dart';

final keypairFromSeed = {
  "ecdsa": (Uint8List seed) => utilCrypto.secp256k1KeypairFromSeed(seed),
  "ed25519": (Uint8List seed) => utilCrypto.naclKeypairFromSeed(seed),
  "ethereum": (Uint8List seed) => utilCrypto.secp256k1KeypairFromSeed(seed),
  "sr25519": (Uint8List seed) => utilCrypto.schnorrkelKeypairFromSeed(seed)
};

class Keyring implements KeyringInstance {
  @override
  List<KeyringPair> get pairs => this.getPairs();

  @override
  List<Uint8List> get publicKeys => this.getPublicKeys();

  @override
  String get type => this._type;

  late final Pairs _pairs;

  late final String _type;

  late final int? _ss58;

  Keyring(KeyringOptions options) {
    options.type = options.type ?? 'ed25519';
    assert(
        options != null &&
            ['ecdsa', 'ethereum', 'ed25519', 'sr25519'].contains(options.type ?? 'undefined'),
        "Expected a keyring type of either 'ed25519', 'sr25519' or 'ecdsa', found '${options.type}");
    this._pairs = Pairs();
    this._ss58 = options.ss58Format;
    this._type = options.type!;
  }

  @override
  KeyringPair addFromAddress(address,
      [Map<String, dynamic>? meta,
      Uint8List? encoded,
      String? type,
      bool? ignoreChecksum,
      List<String>? encType]) {
    final publicKey = this.decodeAddress(address, ignoreChecksum);

    return this.addPair(createPair(Setup(toSS58: this.encodeAddress, type: type),
        PairInfo(publicKey: publicKey, secretKey: Uint8List.fromList([])), meta, encoded, encType));
  }

  @override
  KeyringPair addFromJson(KeyringPair$Json pair, [bool ignoreChecksum]) {
    return this.addPair(this.createFromJson(pair, ignoreChecksum));
  }

  @override
  KeyringPair addFromMnemonic(String mnemonic, [Map<String, dynamic> meta, String type]) {
    return this.addFromUri(mnemonic, meta, type);
  }

  @override
  KeyringPair addFromSeed(Uint8List seed, [Map<String, dynamic> meta, String type]) {
    final kp = keypairFromSeed[type](seed);
    return this.addPair(createPair(Setup(toSS58: this.encodeAddress, type: type),
        PairInfo(publicKey: kp.publicKey, secretKey: kp.secretKey), meta, null));
  }

  @override
  KeyringPair addFromUri(String suri, [Map<String, dynamic> meta, String type]) {
    type = type ?? this.type;
    return this.addPair(this.createFromUri(suri, meta, type));
  }

  @override
  KeyringPair addPair(KeyringPair pair) {
    return this._pairs.add(pair);
  }

  @override
  KeyringPair createFromJson(KeyringPair$Json json, [bool ignoreChecksum]) {
    final cryptoType = json.encoding.version == '0' || !(json.encoding.content is List)
        ? this.type
        : json.encoding.content[1];
    final encType = !(json.encoding.type is List) ? [json.encoding.type] : json.encoding.type;
    final publicKey = isHex(json.address)
        ? hexToU8a(json.address)
        : this.decodeAddress(json.address, ignoreChecksum);
    final decoded =
        isHex(json.encoded) ? hexToU8a(json.encoded) : utilCrypto.base64Decode(json.encoded);

    return createPair(
        Setup(toSS58: this.encodeAddress, type: cryptoType),
        PairInfo(publicKey: publicKey, secretKey: Uint8List.fromList([])),
        json.meta,
        decoded,
        encType);
  }

  @override
  KeyringPair createFromUri(String _suri, [Map<String, dynamic> meta, String type]) {
    // here we only aut-add the dev phrase if we have a hard-derived path
    type = type ?? this.type;
    final suri = _suri.startsWith('//') ? "$DEV_PHRASE$_suri" : _suri;
    final suriExtracted = utilCrypto.keyExtractSuri(suri);
    var seed;

    if (isHex(suriExtracted.phrase, 256)) {
      seed = hexToU8a(suriExtracted.phrase);
    } else {
      final str = suriExtracted.phrase;
      final parts = str.split(' ');
      if ([12, 15, 18, 21, 24].contains(parts.length)) {
        seed = type == 'ethereum'
            ? utilCrypto.mnemonicToLegacySeed(suriExtracted.phrase)
            : utilCrypto.mnemonicToMiniSecret(suriExtracted.phrase, suriExtracted.password);
      } else {
        assert(str.length <= 32,
            'specified phrase is not a valid mnemonic and is invalid as a raw seed at > 32 bytes');

        seed = stringToU8a(str.padRight(32));
      }
    }
    // FIXME Need to support Ethereum-type derivation paths
    final derived = utilCrypto.keyFromPath(keypairFromSeed[type](seed), suriExtracted.path, type);

    return createPair(Setup(toSS58: this.encodeAddress, type: type),
        PairInfo(publicKey: derived.publicKey, secretKey: derived.secretKey), meta, null);
  }

  @override
  Uint8List decodeAddress(encoded, [bool? ignoreChecksum, int? ss58Format]) {
    return utilCrypto.decodeAddress(encoded,
        ignoreChecksum: ignoreChecksum, ss58Format: ss58Format);
  }

  @override
  String encodeAddress(key, [int ss58Format]) {
    return utilCrypto.encodeAddress(key, isNull(ss58Format) ? this._ss58 : ss58Format);
  }

  @override
  KeyringPair getPair(address) {
    return this._pairs.get(address);
  }

  @override
  List<KeyringPair> getPairs() {
    return this._pairs.all();
  }

  @override
  List<Uint8List> getPublicKeys() {
    return this._pairs.all().map((kp) => kp.publicKey);
  }

  @override
  void removePair(address) {
    this._pairs.remove(address);
  }

  @override
  void setSS58Format(int ss58Format) {
    this._ss58 = ss58Format;
  }

  @override
  Future<KeyringPair$Json> toJson(address, [String passphrase]) async {
    return await this._pairs.get(address).toJson(passphrase);
  }
}

class KeyringSingleton extends Keyring {
  static KeyringSingleton _instance;
  KeyringSingleton._internal({KeyringOptions options}) : super(options);
  factory KeyringSingleton({KeyringOptions options}) => _getInstance(options: options);
  static KeyringSingleton get instance => _instance;

  /// get internal instance
  static _getInstance({KeyringOptions options}) {
    // only one instance live
    if (_instance == null) {
      _instance = KeyringSingleton._internal(options: options);
    }
    return _instance;
  }
}
