import 'dart:typed_data';

import 'package:polkadot_dart/metadata/decorate/extrinsics/createUnchecked.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

Map<String, Map<String, CallFunction>> decorateExtrinsics(
    Registry registry, MetadataLatest latest) {
  final isIndexed = latest.modules.value.any((module) => module.index.value != (BigInt.from(255)));
  final filtered = latest.modules.value.where((module) => module.calls.isSome);
  return filtered.fold(Map<String, Map<String, CallFunction>>.from({}),
      (Map<String, Map<String, CallFunction>> result, module) {
    final sectionIndex = isIndexed ? module.index.toNumber() : filtered.toList().indexOf(module);
    final section = stringCamelCase(module.name.toString());

    final arr = module.calls.unwrap().value;
    result[section] = arr.fold({}, (Map<String, CallFunction> newModule, callMetadata) {
      newModule[stringCamelCase(callMetadata.name.toString())] = createUnchecked(registry, section,
          Uint8List.fromList([sectionIndex, arr.indexOf(callMetadata)]), callMetadata);
      return newModule;
    });

    return result;
  });
}
