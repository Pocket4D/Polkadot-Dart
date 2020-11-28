import 'dart:typed_data';

import 'package:polkadot_dart/crypto/common.dart';
import 'package:polkadot_dart/utils/utils.dart';

Uint8List mnemonicToMiniSecret(String mnemonic, [String password = '']) {
  var nativeResult = bip39ToMiniSecret(mnemonic, password);
  return nativeResult.hexAddPrefix().toU8a();
}

bool mnemonicValidate(String mnemonic) {
  return bip39Validate(mnemonic);
}

Uint8List mnemonicToLegacySeed(String mnemonic, [String password = '']) {
  return bip39ToSeed(mnemonic, password).hexAddPrefix().toU8a();
}

Uint8List mnemonicToEntropy(String mnemonic) {
  return bip39ToEntropy(mnemonic).hexAddPrefix().toU8a();
}

String mnemonicGenerate([int numWords = 12]) {
  assert(
      [12, 15, 18, 21, 24].contains(numWords), "number or words should be 12 | 15 | 18 | 21 | 24");
  return bip39Generate(numWords);
}
