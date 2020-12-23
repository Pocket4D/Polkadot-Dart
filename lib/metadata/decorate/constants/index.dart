import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

import '../types.dart';

Map<String, Map<String, ConstantCodec>> decorateConstants(
    Registry registry, MetadataLatest latest) {
  return latest.modules.value.fold(Map<String, Map<String, ConstantCodec>>.from({}),
      (Map<String, Map<String, ConstantCodec>> result, moduleMetadata) {
    if (moduleMetadata.constants.isEmpty) {
      return result;
    }

    final name = moduleMetadata.name;

    // For access, we change the index names, i.e. Democracy.EnactmentPeriod -> democracy.enactmentPeriod
    result[stringCamelCase(name.toString())] =
        moduleMetadata.constants.value.fold(Map<String, ConstantCodec>.from({}), (newModule, meta) {
      // convert to the natural type as received
      final type = meta.type.toString();
      final codec = registry.createType(type, hexToU8a(meta.thisValue.toHex())) as ConstantCodec;

      codec.meta = meta;
      newModule[stringCamelCase(meta.name.toString())] = codec;

      return newModule;
    });

    return result;
  });
}
