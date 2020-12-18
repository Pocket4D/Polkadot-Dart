import 'dart:typed_data';

import 'package:polkadot_dart/types/extrinsic/ExtrinsicEra.dart';
import 'package:polkadot_dart/types/extrinsic/constant.dart';
import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

class ExtrinsicPayloadOptions {
  int version;
  ExtrinsicPayloadOptions({this.version});
  toMap() => {"version": this.version};
}

// ignore: non_constant_identifier_names
abstract class ExtrinsicPayloadVx extends ExtrinsicPayloadV4 {
  ExtrinsicPayloadVx(Registry registry, [dynamic value]) : super(registry, value);
}

// all our known types that can be returned
// type ExtrinsicPayloadVx = ExtrinsicPayloadV4;

const _VERSIONS = [
  'ExtrinsicPayloadUnknown', // v0 is unknown
  'ExtrinsicPayloadUnknown',
  'ExtrinsicPayloadUnknown',
  'ExtrinsicPayloadUnknown',
  'ExtrinsicPayloadV4'
];

class GenericExtrinsicPayload extends Base<ExtrinsicPayloadVx> {
  GenericExtrinsicPayload(Registry registry, dynamic value, ExtrinsicPayloadOptions options)
      : super(
            registry,
            GenericExtrinsicPayload.decodeExtrinsicPayload(
                registry, value as ExtrinsicPayloadValue, options.version ?? DEFAULT_VERSION));

  static GenericExtrinsicPayload constructor(Registry registry,
          [dynamic value, ExtrinsicPayloadOptions options]) =>
      GenericExtrinsicPayload(registry, value, options);
  /** @internal */
  static ExtrinsicPayloadVx decodeExtrinsicPayload(Registry registry, dynamic value,
      [int version = DEFAULT_VERSION]) {
    if (value is GenericExtrinsicPayload) {
      return value.raw;
    }

    return registry.createType(_VERSIONS[version] ?? _VERSIONS[0], [
      value,
      {"version": version}
    ]) as ExtrinsicPayloadVx;
  }

  /**
   * @description The block [[Hash]] the signature applies to(mortal/immortal)
   */
  Hash get blockHash {
    return this.raw.blockHash;
  }

  /**
   * @description The [[ExtrinsicEra]]
   */
  GenericExtrinsicEra get era {
    return this.raw.era;
  }

  /**
   * @description The genesis block [[Hash]] the signature applies to
   */
  Hash get genesisHash {
    // NOTE only v3+
    return this.raw.genesisHash ?? this.registry.createType('Hash');
  }

  /**
   * @description The [[Raw]] contained in the payload
   */
  Raw get method {
    return this.raw.method;
  }

  /**
   * @description The [[Index]]
   */
  Compact<Index> get nonce {
    return this.raw.nonce;
  }

  /**
   * @description The specVersion as a [[u32]] for this payload
   */
  u32 get specVersion {
    // NOTE only v3+
    return this.raw.specVersion ?? this.registry.createType('u32');
  }

  /**
   * @description The [[Balance]]
   */
  Compact<Balance> get tip {
    // NOTE from v2+
    return this.raw.tip ?? this.registry.createType('Compact<Balance>');
  }

  /**
   * @description The transaction version as a [[u32]] for this payload
   */
  u32 get transactionVersion {
    // NOTE only v4+
    return this.raw.transactionVersion ?? this.registry.createType('u32');
  }

  /**
   * @description Compares the value of the input to see if there is a match
   */
  bool eq([dynamic other]) {
    return this.raw.eq(other);
  }

  /**
   * @description Sign the payload with the keypair
   */
  Map<String, String> sign(IKeyringPair signerPair) {
    final signature = this.raw.sign(signerPair);

    // This is extensible, so we could quite readily extend to send back extra
    // information, such as for instance the payload, i.e. `payload: this.toHex()`
    // For the case here we sign via the extrinsic, we ignore the return, so generally
    // this is applicable for external signing
    return {"signature": u8aToHex(signature)};
  }

  /**
   * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
   */
  dynamic toHuman([bool isExtended]) {
    return this.raw.toHuman(isExtended);
  }

  /**
   * @description Converts the Object to JSON, typically used for RPC transfers
   */
  dynamic toJSON() {
    return this.toHex();
  }

  /**
   * @description Returns the string representation of the value
   */
  String toString() {
    return this.toHex();
  }

  /**
   * @description Returns a serialized u8a form
   */
  Uint8List toU8a([dynamic isBare]) {
    // call our parent, with only the method stripped
    return super.toU8a(isBare != null && isBare != false ? {"method": true} : false);
  }

  @override
  // TODO: implement value
  get value => this.raw;
}
