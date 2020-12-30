import 'package:polkadot_dart/types-known/index.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

const KNOWN_ORIGINS = {
  "Council": 'CollectiveOrigin',
  "System": 'SystemOrigin',
  "TechnicalCommittee": 'CollectiveOrigin'
};

void setTypeOverride(Map<String, String> sectionTypes, CodecType type) {
  final override =
      (sectionTypes.keys).singleWhere((aliased) => type.eq(aliased), orElse: () => null);

  if (override != null) {
    type.setOverride(sectionTypes[override]);
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
    }
  }
}

// List<FunctionMetadataLatest>
convertCalls(Registry registry, List<FunctionMetadataV12> calls, Map<String, String> sectionTypes) {
  return calls.map((v12) {
    v12.args.value.forEach((meta) => setTypeOverride(sectionTypes, meta.type));
    final result = registry.createType('FunctionMetadataLatest',
        {"args": v12.args, "documentation": v12.documentation, "name": v12.name});
    return result;
    // return FunctionMetadataLatest.from(registry.createType('FunctionMetadataLatest',
    //     {"args": v12.args, "documentation": v12.documentation, "name": v12.name}));
  }).toList();
}

// List<EventMetadataLatest>
convertEvents(Registry registry, List<EventMetadataV12> events, Map<String, String> sectionTypes) {
  return events.map((v12) {
    v12.args.value.forEach((type) => setTypeOverride(sectionTypes, type));
    final result = registry.createType('EventMetadataLatest',
        {"args": v12.args, "documentation": v12.documentation, "name": v12.name});
    return result;
    // return EventMetadataLatest.from(registry.createType('EventMetadataLatest',
    //     {"args": v12.args, "documentation": v12.documentation, "name": v12.name}));
  }).toList();
}

// StorageMetadataLatest
convertStorage(Registry registry, StorageMetadataV12 v12, Map<String, String> sectionTypes) {
  //return StorageMetadataLatest.from(
  return registry.createType('StorageMetadataLatest', {
    "items": v12.items.map((v11, [index, list]) {
      CodecType resultType;

      if (v11.type.isMap) {
        resultType = CodecType(registry, v11.type.asMap.value);
      } else if (v11.type.isDoubleMap) {
        resultType = CodecType(registry, v11.type.asDoubleMap.value);
      } else {
        resultType = v11.type.asPlain;
      }

      setTypeOverride(sectionTypes, resultType);
      final result = registry.createType('StorageEntryMetadataLatest', {
        "documentation": v11.documentation,
        "fallback": v11.fallback,
        "modifier": v11.modifier,
        "name": v11.name,
        "type": v11.type
      });
      return result;
      // return StorageEntryMetadataLatest.from(registry.createType('StorageEntryMetadataLatest', {
      //   "documentation": v11.documentation,
      //   "fallback": v11.fallback,
      //   "modifier": v11.modifier,
      //   "name": v11.name,
      //   "type": v11.type
      // }));
    }),
    "prefix": v12.prefix
  });
  // );
}

void registerOriginCaller(Registry registry, List<ModuleMetadataV12> modules) {
  final isIndexed = modules.any((v12) => !(v12.index.value.toInt() == (255)));

  var newModules = List<List<dynamic>>.empty(growable: true);
  for (var index = 0; index < modules.length; index += 1) {
    var mod = modules[index];
    newModules.add([mod.name.toString(), isIndexed ? mod.index.toNumber() : index]);
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
    {List<FunctionMetadataV12> calls, List<EventMetadataV12> events, StorageMetadataV12 storage}) {
  final sectionTypes = getModuleTypes(registry, stringCamelCase(mod.name.toString()));

  //return ModuleMetadataLatest.from(
  return registry.createType('ModuleMetadataLatest', {
    ...mod.value,
    "calls": calls != null ? convertCalls(registry, calls, sectionTypes) : null,
    "events": events != null ? convertEvents(registry, events, sectionTypes) : null,
    "storage": storage != null ? convertStorage(registry, storage, sectionTypes) : null
  });
  // );
}

MetadataLatest toLatest(Registry registry, MetadataV12 v12) {
  print("slowFuck");
  registerOriginCaller(registry, v12.modules.value);
  var result = registry.createType('MetadataLatest', {
    "extrinsic": v12.extrinsic,
    "modules": v12.modules.map((mod, [index, list]) => createModule(registry, mod,
        calls: (mod.calls?.unwrapOr(null) as Vec)?.value,
        events: (mod.events?.unwrapOr(null) as Vec)?.value,
        storage: mod.storage?.unwrapOr(null)))
  });
  print("slowFuck1");
  return MetadataLatest.from(result);
}
