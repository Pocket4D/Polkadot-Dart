import 'crypto/crypto.dart' as crypto;
import 'util_crypto/util_crypto.dart' as util_crypto;
import 'utils/utils.dart' as utils;
import 'keyring/keyring.dart' as keyring;
import 'types/types.dart' as types;

void main() {
  utils.main();
  crypto.main();
  util_crypto.main();
  keyring.main();
  types.main();
}
