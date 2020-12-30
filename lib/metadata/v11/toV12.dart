import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';

MetadataV12 toV12(Registry registry, MetadataV11 v11) {
  final result = registry.createType('MetadataLatest', {
    "extrinsic": v11.extrinsic,
    "modules": v11.modules.map((mod, [index, list]) => ModuleMetadataV12.from(
        registry.createType('ModuleMetadataV12', {...mod.value, "index": 255})))
  });

  return MetadataV12.from(result);
}
