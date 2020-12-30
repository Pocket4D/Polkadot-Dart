import 'crypto/crypto.dart' as crypto;
import 'util_crypto/util_crypto.dart' as util_crypto;
import 'utils/utils.dart' as utils;
import 'keyring/keyring.dart' as keyring;
import 'types/types.dart' as types;
import 'networks/networks.dart' as networks;
import 'types-known/index.dart' as typesUnknown;

void main() {
  utils.main();
  crypto.main();
  util_crypto.main();
  keyring.main();
  types.main();
  networks.main();
  typesUnknown.main();
}
