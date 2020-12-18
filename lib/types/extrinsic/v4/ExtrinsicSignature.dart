import 'dart:typed_data';

import 'package:polkadot_dart/types/extrinsic/constant.dart';
import 'package:polkadot_dart/types/extrinsic/types.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicPayload.dart';
import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/utils/utils.dart';

// ignore: non_constant_identifier_names
final FAKE_NONE = Uint8List.fromList([]);
// ignore: non_constant_identifier_names
final FAKE_SOME = Uint8List.fromList([1]);

class GenericExtrinsicSignatureV4 extends Struct implements IExtrinsicSignature {
  Uint8List _fakePrefix;
  ExtrinsicSignatureOptions originOptions;
  dynamic originValue;
  GenericExtrinsicSignatureV4(Registry registry, [dynamic value, ExtrinsicSignatureOptions options])
      : super(
            registry,
            {
              "signer": 'Address',
              // eslint-disable-next-line sort-keys
              "signature": 'ExtrinsicSignature',
              ...registry.getSignedExtensionTypes()
            },
            GenericExtrinsicSignatureV4.decodeExtrinsicSignature(
                value, options?.isSigned ?? false)) {
    this._fakePrefix =
        registry.createType('ExtrinsicSignature').runtimeType.toString().startsWith("Enum")
            ? FAKE_SOME
            : FAKE_NONE;
    this.originOptions = options;
    this.originValue = value;
  }
  static GenericExtrinsicSignatureV4 constructor(Registry registry,
          [dynamic value, ExtrinsicSignatureOptions options]) =>
      GenericExtrinsicSignatureV4(registry, value, options);

  /** @internal */
  static decodeExtrinsicSignature(dynamic value, [bool isSigned = false]) {
    if (!value) {
      return EMPTY_U8A;
    } else if (value is GenericExtrinsicSignatureV4) {
      return value;
    }

    return isSigned ? value : EMPTY_U8A;
  }

  /**
   * @description The length of the value when encoded as a Uint8List
   */
  int get encodedLength {
    return this.isSigned ? super.encodedLength : 0;
  }

  /**
   * @description `true` if the signature is valid
   */
  bool get isSigned {
    return !this.signature.isEmpty;
  }

  /**
   * @description The [[ExtrinsicEra]](mortal or immortal) this signature applies to
   */
  ExtrinsicEra get era {
    return this.getCodec('era').cast<ExtrinsicEra>();
  }

  /**
   * @description The [[Index]] for the signature
   */
  Compact<Index> get nonce {
    return this.getCodec('nonce').cast<Compact<Index>>();
  }

  /**
   * @description The actual [[EcdsaSignature]], [[Ed25519Signature]] or [[Sr25519Signature]]
   */
  get signature {
    // the second case here is when we don't have an enum signature, treat as raw
    return (this.multiSignature.value ?? this.multiSignature) as Sr25519Signature;
  }

  /**
   * @description The raw [[ExtrinsicSignature]]
   */
  ExtrinsicSignature get multiSignature {
    return this.getCodec('signature').cast<ExtrinsicSignature>();
  }

  /**
   * @description The [[Address]] that signed
   */
  Address get signer {
    return this.getCodec('signer').cast<Address>();
  }

  /**
   * @description The [[Balance]] tip
   */
  Compact<Balance> get tip {
    return this.getCodec('tip').cast<Compact<Balance>>();
  }

  IExtrinsicSignature _injectSignature(
      Address signer, ExtrinsicSignature signature, GenericExtrinsicPayloadV4 payloadV4) {
    this.value['era'] = payloadV4.era;
    this.value['nonce'] = payloadV4.nonce;
    this.value['signer'] = signer;
    this.value['signature'] = signature;
    this.value['tip'] = payloadV4.tip;

    return this;
  }

  /**
   * @description Adds a raw signature
   */
  IExtrinsicSignature addSignature(dynamic signer, dynamic signature, dynamic payload) {
    return this._injectSignature(
        this.registry.createType('Address', signer),
        this.registry.createType('ExtrinsicSignature', signature),
        GenericExtrinsicPayloadV4(this.registry, payload));
  }

  /**
   * @description Creates a payload from the supplied options
   */
  GenericExtrinsicPayloadV4 createPayload(Call method, SignatureOptions options) {
    return GenericExtrinsicPayloadV4(this.registry, {
      "blockHash": options.blockHash,
      "era": options.era ?? IMMORTAL_ERA,
      "genesisHash": options.genesisHash,
      "method": method.toHex(),
      "nonce": options.nonce,
      "specVersion": options.runtimeVersion.specVersion,
      "tip": options.tip ?? 0,
      "transactionVersion": options.runtimeVersion.transactionVersion ?? 0
    });
  }

  /**
   * @description Generate a payload and applies the signature from a keypair
   */
  IExtrinsicSignature sign(Call method, IKeyringPair account, SignatureOptions options) {
    final signer = this.registry.createType('Address', account.addressRaw);
    final payload = this.createPayload(method, options);
    final signature = this.registry.createType('ExtrinsicSignature', payload.sign(account));

    return this._injectSignature(signer, signature, payload);
  }

  /**
   * @description Generate a payload and applies a fake signature
   */
  IExtrinsicSignature signFake(Call method, dynamic address, SignatureOptions options) {
    final signer = this.registry.createType('Address', address);
    final payload = this.createPayload(method, options);
    final signature = this.registry.createType('ExtrinsicSignature',
        u8aConcat([this._fakePrefix, Uint8List(64)..fillRange(0, 64, (0x42))]));

    return this._injectSignature(signer, signature, payload);
  }

  /**
   * @description Encodes the value as a Uint8List as per the SCALE specifications
   * @param isBare true when the value has none of the type-specific prefixes(internal)
   */
  Uint8List toU8a([dynamic isBare]) {
    return this.isSigned ? super.toU8a(isBare) : EMPTY_U8A;
  }
}
