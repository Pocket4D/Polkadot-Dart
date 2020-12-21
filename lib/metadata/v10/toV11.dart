import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';

MetadataV11 toV11(Registry registry, MetadataV10 v10) {
  return MetadataV11.from(registry.createType('MetadataV11', {
    // This is new in V11, pass V0 here - something non-existing, telling the API to use
    // the fallback for this information (on-chain detection)
    "extrinsic": {"signedExtensions": [], "version": 0},
    "modules": v10.modules
  }));
}
