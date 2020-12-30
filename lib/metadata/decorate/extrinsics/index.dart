import 'dart:typed_data';

import 'package:polkadot_dart/metadata/decorate/extrinsics/createUnchecked.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

Map<String, Map<String, CallFunction>> decorateExtrinsics(
    Registry registry, MetadataLatest latest, int metaVersion) {
  final filtered =
      latest.modules.value.where((module) => module.calls != null && module.calls.isSome).toList();

  Map<String, Map<String, CallFunction>> returnModules = Map<String, Map<String, CallFunction>>();
  filtered.asMap().entries.forEach((moduleEntry) {
    int index = moduleEntry.key;
    ModuleMetadataLatest module = moduleEntry.value;
    final sectionIndex = metaVersion == 12 ? module.index.toNumber() : index;
    final section = stringCamelCase(module.name.toString());
    final arr = module.calls.unwrap().value;

    Map<String, CallFunction> newModule = Map<String, CallFunction>();
    arr.asMap().entries.forEach((entry) {
      int index = entry.key;
      FunctionMetadataLatest callMetadata = entry.value;
      newModule[stringCamelCase(callMetadata.name.toString())] = createUnchecked(
          registry, section, Uint8List.fromList([sectionIndex, index]), callMetadata);
    });
    returnModules[section] = newModule;
  });

  return returnModules;
}
