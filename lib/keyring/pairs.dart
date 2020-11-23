import 'package:p4d_rust_binding/keyring/types.dart';
import 'package:p4d_rust_binding/util_crypto/util_crypto.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

class Pairs implements KeyringPairs {
  Map<String, KeyringPair> map = Map<String, KeyringPair>();

  KeyringPair add(KeyringPair pair) {
    this.map[decodeAddress(pair.address).toString()] = pair;
    return pair;
  }

  List<KeyringPair> all() {
    return this.map.values.toList();
  }

  KeyringPair get(dynamic address) {
    final pair = this.map[decodeAddress(address).toString()];

    assert(pair != null, () {
      final formatted = isU8a(address) || isHex(address) ? u8aToHex(u8aToU8a(address)) : address;

      return "Unable to retrieve keypair '$formatted'";
    });

    return pair;
  }

  void remove(dynamic address) {
    this.map.remove(decodeAddress(address).toString());
  }
}
