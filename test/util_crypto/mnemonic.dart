import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/util_crypto/mnemonic.dart';
import '../fixtures/schnorrkel_tests.dart';

void main() {
  mnemonicTest();
}

void mnemonicTest() {
  const MNEMONIC = 'seed sock milk update focus rotate barely fade car face mechanic mercy';
  const SEED = '0x4d1ab2a57929edfd018aaa974e62ed557e3f54b4104acabedf73c8f5a1dbb029';
  const SEED2 = '0x3c121e20de068083b49c2315697fb59a2d9e8643c24e5ea7628132c58969a027';
  test('mnemonicValidate', () {
    expect(mnemonicValidate(MNEMONIC), true);
    expect(
        mnemonicValidate('wine photo extra cushion basket dwarf humor cloud truck job boat submit'),
        false);
  });
  test('mnemonicToMiniSecret', () {
    expect(mnemonicToMiniSecret(MNEMONIC).toHex(), SEED);
    tests.forEach((element) {
      var mnemonic = element[0];
      var seed = element[2];
      expect(mnemonicToMiniSecret(mnemonic, 'Substrate').toHex(), seed.substring(0, 66));
    });
  });
  test('mnemonicToLegacySeed', () {
    expect(mnemonicToLegacySeed(MNEMONIC).toHex(), SEED2);
  });
  test('mnemonicToEntropy', () {
    tests.forEach((element) {
      var mnemonic = element[0];
      var entropy = element[1];
      expect(mnemonicToEntropy(mnemonic).toHex(), entropy);
    });
  });

  test('mnemonicGenerate', () {
    expect(mnemonicValidate(mnemonicGenerate()), true);

    final listOfPhrase = [12, 15, 18, 21, 24];
    listOfPhrase.forEach((element) {
      final mnemonic = mnemonicGenerate(element);
      final isValid = mnemonicValidate(mnemonic);
      expect(mnemonic.split(' ').toList().length, element);
      expect(isValid, true);
    });

    final m1 = mnemonicGenerate(24);
    final m2 = mnemonicGenerate(24);
    expect(m1 == m2, false);
    expect(mnemonicValidate(m1), true);
    expect(mnemonicValidate(m2), true);
  });
}
