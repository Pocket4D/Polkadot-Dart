import 'dart:typed_data';

import 'package:polkadot_dart/types/extrinsic/types.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicSignature.dart';
import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
// import 'package:polkadot_dart/utils/utils.dart';

const EXTRINSIC_VERSION = 4;

// abstract class ExtrinsicSignatureV4 extends IExtrinsicSignature {}

class ExtrinsicValueV4 {
  Call method;
  ExtrinsicSignatureV4 signature;
  ExtrinsicValueV4({this.method, this.signature});
  toMap() => {"method": this.method, "signature": this.signature};
}

class GenericExtrinsicV4Options implements ExtrinsicOptions {
  @override
  bool isSigned;

  @override
  int version;
  GenericExtrinsicV4Options({this.isSigned, this.version});
  factory GenericExtrinsicV4Options.fromMap(Map<String, dynamic> map) =>
      GenericExtrinsicV4Options(isSigned: map["isSigned"] ?? null, version: map["version"] ?? null);
}

class GenericExtrinsicV4 extends Struct implements IExtrinsicImpl {
  // GenericExtrinsicV4(Registry registry, Map<String, > types) : super(registry, types);
  ExtrinsicOptions originOptions;
  dynamic originValue;
  GenericExtrinsicV4.empty() : super.empty();
  GenericExtrinsicV4(Registry registry, [dynamic thisValue, ExtrinsicOptions options])
      : super(
            registry,
            {
              "signature": 'ExtrinsicSignatureV4',
              // eslint-disable-next-line sort-keys
              "method": 'Call'
            },
            GenericExtrinsicV4.decodeExtrinsic(registry, thisValue, options?.isSigned ?? false)) {
    originValue = thisValue;
    originOptions = options;
  }

  static GenericExtrinsicV4 constructor(Registry registry, [dynamic value, dynamic options]) {
    return GenericExtrinsicV4(registry, value,
        options is ExtrinsicOptions ? options : GenericExtrinsicV4Options.fromMap(options));
  }

  /// @internal */
  // ExtrinsicValueV4
  static decodeExtrinsic(Registry registry, [dynamic value, bool isSigned = false]) {
    if (value is GenericExtrinsicV4) {
      return value;
      // registry.createClass('Call')
    } else if (value is Call) {
      return ExtrinsicValueV4(method: value).toMap();
    } else if (value is Uint8List) {
      // here we decode manually since we need to pull through the version information
      final signature = ExtrinsicSignatureV4.from(registry.createType('ExtrinsicSignatureV4', [
        value,
        {"isSigned": isSigned}
      ]));
      final method = registry.createType('Call', value.sublist(signature.encodedLength));

      return ExtrinsicValueV4(method: Call.from(method), signature: signature).toMap();
    }
    return value ?? ExtrinsicValueV4().toMap();
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.toU8a().length;
  }

  /// @description The [[Call]] this extrinsic wraps
  Call get method {
    return Call.from(this.getCodec('method'));
  }

  /// @description The version for the signature
  int get version {
    return EXTRINSIC_VERSION;
  }

  /// @description Add an [[ExtrinsicSignatureV4]] to the extrinsic(already generated)
  GenericExtrinsicV4 addSignature(dynamic signer, dynamic signature, dynamic payload) {
    this.signature.addSignature(signer, signature, payload);
    return this;
  }

  /// @description Sign the extrinsic with a specific keypair
  GenericExtrinsicV4 sign(IKeyringPair account, SignatureOptions options) {
    this.signature.sign(this.method, account, options);
    return this;
  }

  /// @describe Adds a fake signature to the extrinsic
  GenericExtrinsicV4 signFake(dynamic signer, SignatureOptions options) {
    this.signature.signFake(this.method, signer, options);
    return this;
  }

  @override
  // TODO: implement signature
  IExtrinsicSignature get signature {
    return this.getCodec("signature");
  }
}
