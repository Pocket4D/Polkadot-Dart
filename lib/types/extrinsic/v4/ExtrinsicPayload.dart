import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types.dart';
import '../util.dart' as util;

class GenericExtrinsicPayloadV4 extends Struct {
  SignOptions _signOptions;

  GenericExtrinsicPayloadV4(Registry registry, [dynamic value])
      : super(
            registry,
            {
              "method": 'Bytes',
              ...registry.getSignedExtensionTypes(),
              ...registry.getSignedExtensionExtra()
            },
            value) {
    // Do detection for the type of extrinsic, in the case of MultiSignature this is an
    // enum, in the case of AnySignature, this is a Hash only (may be 64 or 65 bytes)
    this._signOptions = SignOptions(
        withType:
            registry.createType('ExtrinsicSignature').runtimeType.toString().startsWith("Enum"));
  }

  static GenericExtrinsicPayloadV4 constructor(Registry registry, [dynamic value]) =>
      GenericExtrinsicPayloadV4(registry, value);
  /**
   * @description The block [[Hash]] the signature applies to (mortal/immortal)
   */
  Hash get blockHash {
    return Hash.from(this.getCodec('blockHash'));
  }

  /**
   * @description The [[ExtrinsicEra]]
   */
  ExtrinsicEra get era {
    return ExtrinsicEra.from(this.getCodec('era'));
  }

  /**
   * @description The genesis [[Hash]] the signature applies to (mortal/immortal)
   */
  Hash get genesisHash {
    return Hash.from(this.getCodec('genesisHash'));
  }

  /**
   * @description The [[Bytes]] contained in the payload
   */
  Bytes get method {
    return Bytes.from(this.getCodec('method'));
  }

  /**
   * @description The [[Index]]
   */
  // Compact<Index>
  get nonce {
    return this.getCodec('nonce');
  }

  /**
   * @description The specVersion for this signature
   */
  u32 get specVersion {
    return this.getCodec('specVersion').cast<u32>();
  }

  /**
   * @description The tip [[Balance]]
   */
  // Compact<Balance>
  get tip {
    return this.getCodec('tip');
  }

  /**
   * @description The transactionVersion for this signature
   */
  u32 get transactionVersion {
    return this.getCodec('transactionVersion').cast<u32>();
  }

  /**
   * @description Sign the payload with the keypair
   */
  Uint8List sign(IKeyringPair signerPair) {
    // NOTE The `toU8a({ method: true })` argument is absolutely critical - we don't want the method (Bytes)
    // to have the length prefix included. This means that the data-as-signed is un-decodable,
    // but is also doesn't need the extra information, only the pure data (and is not decoded)
    // ... The same applies to V1..V3, if we have a V5, carry move this comment to latest
    return util.sign(this.registry, signerPair, this.toU8a({"method": true}), this._signOptions);
  }
}
