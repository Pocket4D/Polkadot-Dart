import 'package:p4d_rust_binding/util_crypto/keccak.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

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
