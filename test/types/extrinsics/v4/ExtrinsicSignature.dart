import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/keyring/testingPairs.dart';
import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/extrinsic/impls.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicSignature.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata, Call;
import '../../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  extrinsicSignatureTest(); // rename this test name
}

final signOptions = {
  "blockHash": '0x1234567890123456789012345678901234567890123456789012345678901234',
  "genesisHash": '0x1234567890123456789012345678901234567890123456789012345678901234',
  "nonce": '0x69',
  "runtimeVersion": {
    "apis": [],
    "authoringVersion": BigInt.zero,
    "implName": 'test',
    "implVersion": BigInt.zero,
    "specName": 'test',
    "specVersion": BigInt.zero,
    "transactionVersion": BigInt.zero
  }
};

void extrinsicSignatureTest() {
  final registry = new TypeRegistry();
  final metadata = new Metadata(registry, rpcMetadata.v12);
  registry.setMetadata(metadata);
  group('ExtrinsicSignatureV4', () {
    final pairs = createTestPairs(KeyringOptions(type: 'ed25519'));

    test('encodes to a sane Uint8Array (default)', () {
      final registry = new TypeRegistry();

      final u8a = Uint8List.fromList([
        // signer as an AccountIndex
        0x09,
        // signature type
        0x01,
        // signature
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
        0x0f,
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
        0x0f,
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
        0x0f,
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
        0x0f,
        // extra stuff
        0x00, // immortal,
        0x04, // nonce, compact
        0x08 // tip, compact
      ]);

      expect(
          new GenericExtrinsicSignatureV4(
                  registry, u8a, ExtrinsicSignatureOptionsV4(isSigned: true))
              .toU8a(),
          u8a);
    });

    test('fake signs default', () {
      final registry = new TypeRegistry();
      final metadata = new Metadata(registry, rpcMetadata.v12);

      registry.setMetadata(metadata);

      expect(
          new GenericExtrinsicSignatureV4(registry, null)
              .signFake(Call.from(registry.createType('Call')), pairs["alice"].address,
                  SignatureOptionsImpl.fromMap(signOptions))
              .toHex(),
          '0x' +
              'ff' +
              'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d' +
              '01' +
              '4242424242424242424242424242424242424242424242424242424242424242' +
              '4242424242424242424242424242424242424242424242424242424242424242' +
              '00a50100');
    });

    test('fake signs default', () {
      final registry = new TypeRegistry();
      final metadata = new Metadata(registry, rpcMetadata.v12);

      registry.setMetadata(metadata);

      /// in javascript, type register is actually use different constructor.
      /// and these interfaces are different
      /// however in dart, constructor is called in name, and interfaces are describe as abstract classes
      /// when we use another abstract class to extend an existing class
      /// and refer the abstract class in functions, and try to send the exsiting class as params
      /// if we do that, we will find that the class is not a subtype to the abstracted class.
      /// because the abstracted class is not implemented or extends by the exisiting class
      /// for example:
      /// ```
      /// class ExistingClass{
      ///   dynamic prop;
      ///   ExistingClass(this.prop);
      /// }
      ///
      /// abstract class AbstractedClass extends ExistingClass{}
      ///
      /// void testFunction(AbstractedClass clazz){
      ///     print(clazz.prop);
      /// }
      ///
      /// testFunction(ExistingClass("try")); // Error: 'ExistingClass' is not a subtype of type 'AbstractedClass' in type cast
      ///
      /// ```
      ///
      /// here `registry.createType('class')` is to create a existing type, however, in dart, the type is unknown to compiler
      /// hence `Address = AccountId` is not correct, and `ExtrinsicSignature = AnySignature` is not either.
      registry.register({"Address": 'AccountId', "ExtrinsicSignature": 'AnySignature'});

      expect(
          new GenericExtrinsicSignatureV4(registry, null)
              .signFake(Call.from(registry.createType('Call')), pairs["alice"].address,
                  SignatureOptionsImpl.fromMap(signOptions))
              .toHex(),
          '0x' +
              // Address = AccountId
              // 'ff' +
              'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d' +
              // This is a prefix-less signature, anySignture as opposed to Multi above
              // '01' +
              '4242424242424242424242424242424242424242424242424242424242424242' +
              '4242424242424242424242424242424242424242424242424242424242424242' +
              '00a50100');
    }, skip: "Because `Address` and `ExtrinsicSignature` are written into class impl");
  });
}
