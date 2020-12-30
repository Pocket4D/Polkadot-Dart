import 'package:polkadot_dart/types/extrinsic/ExtrinsicPayload.dart';
import 'package:polkadot_dart/types/types.dart';

class GenericExtrinsicPayloadUnknown extends Struct {
  GenericExtrinsicPayloadUnknown(Registry registry,
      [dynamic value, ExtrinsicPayloadOptions options])
      : super(registry, {}) {
    throw "Unsupported extrinsic payload version ${options.version ?? 0}";
  }
  static GenericExtrinsicPayloadUnknown constructor(registry,
          [dynamic value, ExtrinsicPayloadOptions options]) =>
      GenericExtrinsicPayloadUnknown(registry, value, options);
}
