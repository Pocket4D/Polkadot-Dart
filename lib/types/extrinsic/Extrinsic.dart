import 'dart:typed_data';

import 'package:polkadot_dart/types/extrinsic/ExtrinsicEra.dart';
import 'package:polkadot_dart/types/extrinsic/v4/Extrinsic.dart';
import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/utils/utils.dart';

import 'constant.dart';

const VERSIONS = [
  'ExtrinsicUnknown', // v0 is unknown
  'ExtrinsicUnknown',
  'ExtrinsicUnknown',
  'ExtrinsicUnknown',
  'ExtrinsicV4'
];

// ArgsDef = Map<String,Constructor>

abstract class ExtrinsicBase extends Base<BaseCodec> {
  ExtrinsicBase(Registry registry, BaseCodec value) : super(registry, value);
  /**
   * @description The arguments passed to for the call, exposes args so it is compatible with [[Call]]
   */
  List<BaseCodec> get args {
    return this.method.args;
  }

  /**
   * @description The argument definitions, compatible with [[Call]]
   */
  Map<String, Constructor> get argsDef {
    return this.method.argsDef;
  }

  /**
   * @description The actual `[sectionIndex, methodIndex]` as used in the Call
   */
  Uint8List get callIndex {
    return this.method.callIndex;
  }

  /**
   * @description The actual data for the Call
   */
  Uint8List get data {
    return this.method.data;
  }

  /**
   * @description The era for this extrinsic
   */
  GenericExtrinsicEra get era {
    return (this.raw as GenericExtrinsicV4).signature.era;
  }

  /**
   * @description The length of the value when encoded as a Uint8Array
   */
  int get encodedLength {
    return this.toU8a().length;
  }

  /**
   * @description `true` is method has `Origin` argument(compatibility with [Call])
   */
  bool get hasOrigin {
    return this.method.hasOrigin;
  }

  /**
   * @description `true` id the extrinsic is signed
   */
  bool get isSigned {
    return (this.raw as GenericExtrinsicV4).signature.isSigned;
  }

  /**
   * @description The length of the actual data, excluding prefix
   */
  int get length {
    return this.toU8a(true).length;
  }

  /**
   * @description The [[FunctionMetadataLatest]] that describes the extrinsic
   */
  FunctionMetadataLatest get meta {
    return this.method.meta;
  }

  /**
   * @description The [[Call]] this extrinsic wraps
   */
  Call get method {
    return (this.raw as GenericExtrinsicV4).method;
  }

  /**
   * @description The nonce for this extrinsic
   */
  Compact<Index> get nonce {
    return (this.raw as GenericExtrinsicV4).signature.nonce;
  }

  /**
   * @description The actual [[EcdsaSignature]], [[Ed25519Signature]] or [[Sr25519Signature]]
   */
  // EcdsaSignature | Ed25519Signature | Sr25519Signature
  get signature {
    return (this.raw as GenericExtrinsicV4).signature.signature;
  }

  /**
   * @description The [[Address]] that signed
   */
  Address get signer {
    return (this.raw as GenericExtrinsicV4).signature.signer;
  }

  /**
   * @description Forwards compat
   */
  // Compact<Balance>
  get tip {
    return (this.raw as GenericExtrinsicV4).signature.tip;
  }

  /**
   * @description Returns the raw transaction version(not flagged with signing information)
  */
  int get type {
    return (this.raw as GenericExtrinsicV4).version;
  }

  /**
   * @description Returns the encoded version flag
  */
  int get version {
    return this.type | (this.isSigned ? BIT_SIGNED : BIT_UNSIGNED);
  }
}

class CreateOptions {
  int version;
  CreateOptions(this.version);
  toMap() => {"version": this.version};
}

class GenericExtrinsic extends ExtrinsicBase {
  GenericExtrinsic(Registry registry, dynamic value, [CreateOptions option])
      : super(registry,
            GenericExtrinsic._decodeExtrinsic(registry, value, option?.version ?? DEFAULT_VERSION));

  static GenericExtrinsic constructor(Registry registry, [dynamic value, CreateOptions option]) =>
      GenericExtrinsic(registry, value, option);

  // : ExtrinsicVx | ExtrinsicUnknown
  static _newFromValue(Registry registry, dynamic value, int version) {
    if (value is GenericExtrinsic) {
      return value.raw;
    }

    final isSigned = (version & BIT_SIGNED) == BIT_SIGNED;
    final type = VERSIONS[version & UNMASK_VERSION] ?? VERSIONS[0];

    // we cast here since the VERSION definition is incredibly broad - we don't have a
    // slice for "only add extrinsic types", and more string definitions become unwieldy
    return registry.createType(type, [
      value,
      {"isSigned": isSigned, "version": version}
    ]);
  }

  /** @internal */
  // : ExtrinsicVx | ExtrinsicUnknown
  static _decodeExtrinsic(Registry registry, dynamic value, [int version = DEFAULT_VERSION]) {
    if (isU8a(value) || (value is List) || isHex(value)) {
      return GenericExtrinsic._decodeU8a(registry, u8aToU8a(value), version);
    } else if (value is Call) {
      return GenericExtrinsic._newFromValue(registry, {"method": value}, version);
    }
    return GenericExtrinsic._newFromValue(registry, value, version);
  }

  /** @internal */
  //  ExtrinsicVx | ExtrinsicUnknown
  static _decodeU8a(Registry registry, Uint8List value, int version) {
    if (value.length == 0) {
      return GenericExtrinsic._newFromValue(registry, Uint8List.fromList([0]), version);
    }

    final compact = compactFromU8a(value);
    final offset = compact[0] as int;
    final length = compact[1] as BigInt;
    final total = offset + length.toInt();

    assert(total <= value.length,
        "Extrinsic: length less than remainder, expected at least $total, found ${value.length}");

    final data = value.sublist(offset, total);

    return GenericExtrinsic._newFromValue(registry, data.sublist(1), data[0]);
  }

  @override
  // TODO: implement value
  get value => this.raw;

  GenericExtrinsic sign(IKeyringPair account, SignatureOptions options) {
    (this.raw as GenericExtrinsicV4).sign(account, options);
    return this;
  }

  GenericExtrinsic signFake(dynamic signer, SignatureOptions options) {
    (this.raw as GenericExtrinsicV4).signFake(signer, options);
    return this;
  }

  String toHex([dynamic isBare]) {
    return u8aToHex(this.toU8a(isBare));
  }

  dynamic toHuman([bool isExpanded]) {
    return {
      "isSigned": this.isSigned,
      "method": this.method.toHuman(isExpanded),
      ...(this.isSigned
          ? {
              "era": this.era.toHuman(isExpanded),
              "nonce": this.nonce.toHuman(isExpanded),
              "signature": this.signature.toHex(),
              "signer": this.signer.toHuman(isExpanded),
              "tip": this.tip.toHuman(isExpanded)
            }
          : {})
    };
  }

  /**
   * @description Converts the Object to JSON, typically used for RPC transfers
   */
  String toJSON() {
    return this.toHex();
  }

  /**
   * @description Returns the base runtime type name for this instance
   */
  String toRawType() {
    return 'Extrinsic';
  }

  /**
   * @description Encodes the value as a Uint8Array as per the SCALE specifications
   * @param isBare true when the value is not length-prefixed
   */
  Uint8List toU8a([dynamic isBare]) {
    // we do not apply bare to the internal values, rather this only determines out length addition,
    // where we strip all lengths this creates an extrinsic that cannot be decoded

    final encoded = u8aConcat([
      new Uint8List.fromList([this.version]),
      this.raw.toU8a()
    ]);

    return isBare != null && isBare == true ? encoded : compactAddLength(encoded);
  }
}
