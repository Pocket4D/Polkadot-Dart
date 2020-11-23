import 'crypto/crypto.dart' as crypto;
import 'util_crypto/util_crypto.dart' as util_crypto;
import 'utils/utils.dart' as utils;
import 'keyring/keyring.dart' as keyring;

void main() {
  utils.main();
  crypto.main();
  util_crypto.main();
  keyring.main();
}
