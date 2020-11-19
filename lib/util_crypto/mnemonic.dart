import 'dart:typed_data';

import 'package:p4d_rust_binding/crypto/common.dart';
import 'package:p4d_rust_binding/utils/utils.dart';

Uint8List mnemonicToMiniSecret(String mnemonic, [String password = '']) {
  var nativeResult = bip39ToMiniSecret(mnemonic, password);
  return nativeResult.hexAddPrefix().toU8a();
}
