import 'package:polkadot_dart/types/extrinsic/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/utils/utils.dart';

const EXTRINSIC_VERSION = 4;

abstract class ExtrinsicSignatureV4 extends IExtrinsicSignature {}

class ExtrinsicValueV4 {
  Call method;
  ExtrinsicSignatureV4 signature;
  ExtrinsicValueV4({this.method, this.signature});
  toMap() => {"method": this.method, "signature": this.signature};
}

class GenericExtrinsicV4 extends Struct implements IExtrinsicImpl {
  // GenericExtrinsicV4(Registry registry, Map<String, > types) : super(registry, types);

  GenericExtrinsicV4(Registry registry, [dynamic value, ExtrinsicOptions options])
      : super(
            registry,
            {
              "signature": 'ExtrinsicSignatureV4',
              // eslint-disable-next-line sort-keys
              "method": 'Call'
            },
            GenericExtrinsicV4.decodeExtrinsic(registry, value, options?.isSigned ?? false));

  static GenericExtrinsicV4 constructor(Registry registry,
          [dynamic value, ExtrinsicOptions options]) =>
      GenericExtrinsicV4(registry, value, options);

  /// @internal */
  // ExtrinsicValueV4
  static decodeExtrinsic(Registry registry, [dynamic value, bool isSigned = false]) {
    if (value is GenericExtrinsicV4) {
      return value;
      // registry.createClass('Call')
    } else if (value is Call) {
      return ExtrinsicValueV4(method: value);
    } else if (isU8a(value)) {
      // here we decode manually since we need to pull through the version information
      final signature = registry.createType('ExtrinsicSignatureV4', [
        value,
        {"isSigned": isSigned}
      ]);
      final method = registry.createType('Call', value.subList(signature.encodedLength));

      return ExtrinsicValueV4(method: method, signature: signature);
    }

    return value ?? ExtrinsicValueV4();
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this.toU8a().length;
  }

  /// @description The [[Call]] this extrinsic wraps
  Call get method {
    return this.getCodec('method').cast<Call>();
  }

  /// @description The [[ExtrinsicSignatureV4]]
  ExtrinsicSignatureV4 get signature {
    return this.getCodec('signature').cast<ExtrinsicSignatureV4>();
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
}
