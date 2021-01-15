import 'package:polkadot_dart/types/extrinsic/constant.dart';
import 'package:polkadot_dart/types/extrinsic/types.dart';
import 'package:polkadot_dart/types/types.dart';

class GenericExtrinsicUnknown extends Struct {
  GenericExtrinsicUnknown.empty() : super.empty();
  GenericExtrinsicUnknown(Registry registry, [dynamic value, ExtrinsicOptions options])
      : super(registry, {}) {
    throw "Unsupported ${options.isSigned ?? false ? '' : 'un'}signed extrinsic version ${options.version ?? 0 & UNMASK_VERSION}";
  }
  static GenericExtrinsicUnknown constructor(Registry registry,
          [dynamic value, ExtrinsicOptions options]) =>
      GenericExtrinsicUnknown(registry, value, options);
}
