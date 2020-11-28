import 'dart:typed_data';

import 'package:polkadot_dart/util_crypto/keccak.dart';
import 'package:polkadot_dart/util_crypto/secp256k1.dart';
import 'package:polkadot_dart/utils/utils.dart';

bool isInvalidChar(String char, num byte) {
  return (byte > 7 && char != char.toUpperCase()) || (byte <= 7 && char != char.toLowerCase());
}

bool isEthereumChecksum(String _address) {
  var address = _address.hexStripPrefix();
  var hash = u8aToHex(keccakAsU8a(address.toLowerCase()), include0x: false);

  for (var index = 0; index < 40; index++) {
    if (isInvalidChar(address[index], int.parse(hash[index], radix: 16))) {
      return false;
    }
  }
  return true;
}

bool isEthereumAddress(String address) {
  if (address == null || address.length != 42 || !isHex(address)) {
    return false;
  }

  if (RegExp(r"^(0x)?[0-9a-f]{40}$").allMatches(address).isNotEmpty ||
      RegExp(r"^(0x)?[0-9A-F]{40}$").allMatches(address).isNotEmpty) {
    return true;
  }

  return isEthereumChecksum(address);
}

Uint8List getH160(Uint8List u8a) {
  if ([33, 65].contains(u8a.length)) {
    u8a = keccakAsU8a(secp256k1Expand(u8a));
  }
  final u8aLength = u8a.length;
  return u8a.sublist(u8aLength - 20, u8aLength);
}

String ethereumEncode(dynamic addressOrPublic) {
  if (addressOrPublic == null) {
    return '0x';
  }

  final u8aAddress = u8aToU8a(addressOrPublic);

  assert([20, 32, 33, 65].contains(u8aAddress.length), 'Invalid address or publicKey passed');

  final address = u8aToHex(getH160(u8aAddress), include0x: false);
  final hash = u8aToHex(keccakAsU8a(address), include0x: false);
  var result = '';

  for (var index = 0; index < 40; index++) {
    result =
        "$result${int.parse(hash[index], radix: 16) > 7 ? address[index].toUpperCase() : address[index]}";
  }

  return "0x$result";
}
