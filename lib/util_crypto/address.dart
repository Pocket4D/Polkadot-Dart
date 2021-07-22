import 'dart:typed_data';

import 'package:polkadot_dart/util_crypto/base58.dart';
import 'package:polkadot_dart/util_crypto/blake2.dart';
import 'package:polkadot_dart/util_crypto/key.dart';
import 'package:polkadot_dart/util_crypto/schnorrkel.dart';
import 'package:polkadot_dart/util_crypto/secp256k1.dart';
import 'package:polkadot_dart/utils/utils.dart';

final ss58Prefix = stringToU8a('SS58PRE');
final keyMultiPrefix = stringToU8a('modlpy/utilisuba');
final keyDerivedPrefix = stringToU8a('modlpy/utilisuba');

class SS58Defaults {
  static const allowedDecodedLengths = [1, 2, 4, 8, 32, 33];
  // publicKey has prefix + 2 checksum bytes, short only prefix + 1 checksum byte
  static const allowedEncodedLengths = [3, 4, 6, 10, 35, 36];
  // static final allowedPrefix= available.map(({ prefix }) => prefix);
  static const prefix = 42;
}

Uint8List sshash(Uint8List key) {
  return blake2AsU8a(u8aConcat([ss58Prefix, key]), bitLength: 512);
}

dynamic checkAddressChecksum(Uint8List decoded) {
  final isPublicKey = [35, 36].contains(decoded.length);

  // non-publicKeys has 1 byte checksums, else default to 2
  final length = decoded.length - (isPublicKey ? 2 : 1);

  // calculate the hash and do the checksum byte checks
  final hash = sshash(decoded.sublist(0, length));

  // see if the hash actually matches
  final isValid = isPublicKey
      ? decoded[decoded.length - 2] == hash[0] && decoded[decoded.length - 1] == hash[1]
      : decoded[decoded.length - 1] == hash[0];

  return [isValid, length];
}

String encodeAddress(dynamic _key, [int? ss58Format = SS58Defaults.prefix]) {
  // decode it, this means we can re-encode an address
  final Uint8List key = decodeAddress(_key);

  assert(SS58Defaults.allowedDecodedLengths.contains(key.length),
      "Expected a valid key to convert, with length ${SS58Defaults.allowedDecodedLengths.join(', ')}");

  final isPublicKey = [32, 33].contains(key.length);

  final input = u8aConcat([
    Uint8List.fromList([ss58Format ?? SS58Defaults.prefix]),
    key
  ]);
  final hash = sshash(input);

  return base58Encode(u8aConcat([input, hash.sublist(0, isPublicKey ? 2 : 1)]));
}

Uint8List decodeAddress(dynamic encoded, {bool? ignoreChecksum, int ss58Format = -1}) {
  if (isU8a(encoded) || isHex(encoded)) {
    return u8aToU8a(encoded);
  }

  final wrapError = (String message) => "Decoding ${encoded as String}: $message";
  var decoded;
  try {
    decoded = base58Decode(encoded);
  } catch (error) {
    throw wrapError((error).toString());
  }

  assert(SS58Defaults.allowedEncodedLengths.contains(decoded.length),
      wrapError('Invalid decoded address length'));

  // TODO Unless it is an "use everywhere" prefix, throw an error
  // if (ss58Format !== -1 && (decoded[0] !== ss58Format)) {
  //   console.log(`WARN: Expected ${ss58Format}, found ${decoded[0]}`);
  // }

  final checkStatus = checkAddressChecksum(decoded);
  bool isValid = checkStatus[0] as bool;
  int endPos = checkStatus[1] as int;

  assert((ignoreChecksum == null ? isValid : ignoreChecksum || isValid),
      wrapError('Invalid decoded address checksum'));

  return decoded.sublist(1, endPos);
}

List<String> sortAddresses(List<dynamic> addresses, [int? ss58Format]) {
  return u8aSorted(addresses.map((who) => decodeAddress(who)).toList())
      .map((u8a) => encodeAddress(u8a, ss58Format))
      .toList();
}

Uint8List createKeyMulti(List<dynamic> who, num threshold) {
  return blake2AsU8a(u8aConcat([
    keyMultiPrefix,
    compactToU8a(who.length),
    ...u8aSorted(who.map((who) => decodeAddress(who)).toList()),
    bnToU8a(isBn(threshold) ? (threshold as BigInt) : BigInt.from(threshold),
        bitLength: 16, endian: Endian.little)
  ]));
}

Uint8List createKeyDerived(List<dynamic> who, num index) {
  return blake2AsU8a(u8aConcat([
    keyDerivedPrefix,
    decodeAddress(who),
    bnToU8a(isBn(index) ? (index as BigInt) : BigInt.from(index),
        bitLength: 16, endian: Endian.little)
  ]));
}

String evmToAddress(dynamic evmAddress, int ss58Format, [String hashType = 'blake2']) {
  final wrapError = (String message) => "Converting ${evmAddress as String}: $message";

  final message = u8aConcat(['evm:', evmAddress]);

  if (message.length != 24) {
    throw wrapError('Invalid evm address length');
  }
  final address = secp256k1Hasher(hashType, message);
  return encodeAddress(address, ss58Format);
}

bool addressEq(dynamic a, dynamic b) {
  return u8aEq(decodeAddress(a), decodeAddress(b));
}

String encodeMultiAddress(List<dynamic> who, num threshold, [int? ss58Format]) {
  return encodeAddress(createKeyMulti(who, threshold), ss58Format);
}

String encodeDerivedAddress(dynamic who, num index, [int? ss58Format]) {
  return encodeAddress(createKeyDerived(decodeAddress(who), index), ss58Format);
}

String deriveAddress(dynamic who, String suri, [int? ss58Format]) {
  final path = keyExtractPath(suri).path;
  assert(path.length != 0 && path.where((element) => element.isHard).isEmpty,
      'Expected suri to contain a combination of non-hard paths');
  final finalPath = path.fold<Uint8List>(
    decodeAddress(who),
    (Uint8List publicKey, path) {
      return schnorrkelDerivePublic(publicKey, path.chainCode);
    },
  );

  return encodeAddress(finalPath, ss58Format);
}

List<dynamic> checkAddress(String address, int prefix) {
  var decoded;

  try {
    decoded = base58Decode(address);
  } catch (error) {
    return [false, error.toString()];
  }

  if (decoded[0] != prefix) {
    return [false, "Prefix mismatch, expected $prefix, found ${decoded[0]}"];
  } else if (!SS58Defaults.allowedEncodedLengths.contains(decoded.length)) {
    return [false, 'Invalid decoded address length'];
  }

  final isValid = checkAddressChecksum(decoded)[0] as bool;

  return [isValid, isValid ? null : 'Invalid decoded address checksum'];
}

Uint8List addressToEvm(dynamic address, [bool? ignoreChecksum]) {
  final decoded = decodeAddress(address, ignoreChecksum: ignoreChecksum);
  return decoded.sublist(0, 20);
}
