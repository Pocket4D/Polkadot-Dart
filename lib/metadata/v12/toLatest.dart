import 'package:polkadot_dart/types-known/index.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

const KNOWN_ORIGINS = {
  "Council": 'CollectiveOrigin',
  "System": 'SystemOrigin',
  "TechnicalCommittee": 'CollectiveOrigin'
};

bool setTypeOverride(Map<String, String> sectionTypes, CodecType type) {
  bool isOverride = false;
  final override = sectionTypes.containsKey(type.toString()) ? type.toString() : null;

  if (override != null) {
    type.setOverride(sectionTypes[override]);
    isOverride = true;
  } else {
    // FIXME: NOT happy with this approach, but gets over the initial hump cased by (Vec<Announcement>,BalanceOf)
    final orig = type.toString();
    final alias = (sectionTypes.entries).fold<String>(
        orig,
        (result, entry) => [
              ['<', '>'],
              ['<', ','],
              [',', '>'],
              ['(', ')'],
              ['(', ','],
              [',', ','],
              [',', ')']
            ].fold<String>(
                result,
                (subResult, subEntry) => subResult.replaceAll(
                    "${subEntry.first}${entry.key}${subEntry.last}",
                    "${subEntry.first}${entry.value}${subEntry.last}")));

    if (orig != alias) {
      type.setOverride(alias);
      isOverride = true;
    }
  }
  return isOverride;
}

// List<FunctionMetadataLatest>
convertCalls(Registry registry, List<FunctionMetadataV12> calls, Map<String, String> sectionTypes) {
  return calls.map((v12) {
    // v12.args.value.forEach((meta) {
    //   if (sectionTypes.containsKey("EquivocationProof")) {
    //     print(meta.type);
    //   }
    //   setTypeOverride(sectionTypes, meta.type);
    //   if (sectionTypes.containsKey("EquivocationProof")) {
    //     print(meta.type);
    //   }
    // });
    var newList = v12.args.map((value, [index, array]) {
      // if (sectionTypes.containsKey("Balance")) {
      //   print("\n");
      //   print(value.type);
      // }
      setTypeOverride(sectionTypes, value.type);
      // if (sectionTypes.containsKey("Balance")) {
      //   print(value.type);
      // }
      return value;
    });

    var newVec = Vec.fromList(newList, registry, "FunctionArgumentMetadataV12");

    final result = registry.createType('FunctionMetadataLatest',
        {"args": newVec, "documentation": v12.documentation, "name": v12.name});

    return result;
    // return FunctionMetadataLatest.from(registry.createType('FunctionMetadataLatest',
    //     {"args": v12.args, "documentation": v12.documentation, "name": v12.name}));
  }).toList();
}

// List<EventMetadataLatest>
convertEvents(Registry registry, List<EventMetadataV12> events, Map<String, String> sectionTypes) {
  return events.map((v12) {
    // v12.args.value.forEach((type) {
    //   setTypeOverride(sectionTypes, type);
    // });

    var newList = v12.args.map((type, [index, array]) {
      setTypeOverride(sectionTypes, type);
      return type;
    });

    var newVec = Vec.fromList(newList, registry, "CodecType");

    final result = registry.createType('EventMetadataLatest',
        {"args": newVec, "documentation": v12.documentation, "name": v12.name});
    return result;
    // return EventMetadataLatest.from(registry.createType('EventMetadataLatest',
    //     {"args": v12.args, "documentation": v12.documentation, "name": v12.name}));
  }).toList();
}

convertConstants(Registry registry, List<ModuleConstantMetadataV12> constants,
    Map<String, String> sectionTypes) {
  return constants.map((c) {
    setTypeOverride(sectionTypes, c.type);
    return registry.createType('ModuleConstantMetadataLatest', c);
  }).toList();
}

// StorageMetadataLatest
convertStorage(Registry registry, StorageMetadataV12 v12, Map<String, String> sectionTypes) {
  //return StorageMetadataLatest.from(
  return registry.createType('StorageMetadataLatest', {
    "items": v12.items.map((item, [index, list]) {
      CodecType resultType;
      if (item.type.isMap) {
        resultType = CodecType(registry, item.type.asMap.thisValue);
      } else if (item.type.isDoubleMap) {
        resultType = CodecType(registry, item.type.asDoubleMap.thisValue);
      } else {
        resultType = item.type.asPlain;
      }

      bool isOverride = setTypeOverride(sectionTypes, resultType);
      StorageEntryTypeV12 newTypeResult;
      if (isOverride) {
        if (item.type.isMap) {
          var newType = Struct(registry, item.type.asMap.originTypes,
              {...item.type.asMap.value, "value": resultType});
          newTypeResult = StorageEntryTypeV12.from(item.type)..setRaw(newType);
          // item.type.setRaw(newType);
        } else if (item.type.isDoubleMap) {
          var newType = Struct(registry, item.type.asDoubleMap.originTypes,
              {...item.type.asDoubleMap.value, "value": resultType});
          newTypeResult = StorageEntryTypeV12.from(item.type)..setRaw(newType);
        } else {
          newTypeResult = StorageEntryTypeV12.from(item.type)..setRaw(resultType);
        }
      }
      // if (item.type.isMap && sectionTypes.containsKey("Proposal")) {
      //   print("\n");
      //   print(sectionTypes);
      //   print(item.type);
      //   print(newTypeResult.asMap.value["value"]);
      //   print(newTypeResult.asMap.thisValue);
      //   print(resultType);
      //   print(newTypeResult);
      // }
      // if (item.name.toString() == "Proposals") {
      //   print("\n");
      //   print(item.type);
      //   print(item.documentation);
      //   print(resultType);
      // }

      final result = registry.createType('StorageEntryMetadataLatest', {
        "documentation": item.documentation,
        "fallback": item.fallback,
        "modifier": item.modifier,
        "name": item.name,
        "type": newTypeResult ?? item.type
      });
      return result;
    }),
    "prefix": v12.prefix
  });
  // );
}

void registerOriginCaller(Registry registry, List<ModuleMetadataV12> modules, int metaNumber) {
  var newModules = List<List<dynamic>>.empty(growable: true);
  for (var index = 0; index < modules.length; index += 1) {
    var mod = modules[index];
    newModules.add([mod.name.toString(), metaNumber >= 12 ? mod.index.toNumber() : index]);
  }
  newModules.sort((a, b) => a[1] - b[1]);
  newModules.fold({}, (result, arr) {
    for (var i = (result.keys).length; i < arr.last; i++) {
      result["Empty$i"] = 'Null';
    }

    result[arr.first] = KNOWN_ORIGINS[arr.first] ?? 'Null';

    return result;
  });

  registry.register({
    "OriginCaller": {"_enum": newModules}
  });
}

// { calls, events, storage }: { calls: FunctionMetadataV12[] | null, events: EventMetadataV12[] | null, storage: StorageMetadataV12 | null }

// ModuleMetadataLatest
createModule(Registry registry, ModuleMetadataV12 mod,
    {List<FunctionMetadataV12> calls,
    List<EventMetadataV12> events,
    StorageMetadataV12 storage,
    List<ModuleConstantMetadataV12> constants}) {
  final sectionTypes = getModuleTypes(registry, stringCamelCase(mod.name.toString()));
  //return ModuleMetadataLatest.from(
  // print(DateTime.now().toString());
  final result = registry.createType('ModuleMetadataLatest', {
    ...mod.value,
    "calls": calls != null ? convertCalls(registry, calls, sectionTypes) : null,
    "events": events != null ? convertEvents(registry, events, sectionTypes) : null,
    "storage": storage != null ? convertStorage(registry, storage, sectionTypes) : null,
    "constants": constants != null ? convertConstants(registry, constants, sectionTypes) : null
  });
  // print(DateTime.now().toString());
  return result;
  // );
}

MetadataLatest toLatest(Registry registry, MetadataV12 v12, int metaNumber) {
  registerOriginCaller(registry, v12.modules.value, metaNumber);

  var result = registry.createType('MetadataLatest', {
    "extrinsic": v12.extrinsic,
    "modules": v12.modules.map(
      (mod, [index, list]) {
        return createModule(registry, mod,
            calls: (mod.calls?.unwrapOr(null) as Vec)?.value,
            events: (mod.events?.unwrapOr(null) as Vec)?.value,
            storage: mod.storage?.unwrapOr(null),
            constants: mod.constants.value);
      },
    )
  });
  // print(result.value["modules"].value[16].value["storage"].value.value["items"].value[1]);
  return MetadataLatest.from(result);
}
