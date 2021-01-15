import 'package:polkadot_dart/types-known/chain/index.dart';
import 'package:polkadot_dart/types-known/modules.dart';
import 'package:polkadot_dart/types-known/spec/index.dart';
import 'package:polkadot_dart/types-known/upgrades/index.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

Map<String, dynamic> filterVersions(List<OverrideVersionedType> versions, int specVersion) {
  if (versions == null) {
    versions = [];
  }
  return versions
      .where((version) =>
          (isNull(version.minmax.first) || specVersion >= version.minmax.first) &&
          (isNull(version.minmax.last) || specVersion <= version.minmax.last))
      .fold({}, (result, overrideVersionType) => ({...result, ...overrideVersionType.types}));
}

Map<String, String> getModuleTypes(Registry registry, String section) {
  final result = {
    ...(typesModules[section] ?? {}),
    ...(registry.knownTypes.typesAlias[section] ?? {})
  };
  return result;
}

Map<String, dynamic> getSpecTypes(
    Registry registry, dynamic chainName, dynamic specName, dynamic specVersion) {
  final _chainName = chainName is CodecText ? chainName.toString() : chainName.toString();
  final _specName = specName is CodecText ? specName.toString() : specName.toString();
  final _specVersion = bnToBn(specVersion).toInt();

  // The order here is always, based on -
  //   - spec then chain
  //   - typesBundle takes higher precedence
  //   - types is the final catch-all override
  return {
    ...filterVersions(
        typesSpec[_specName].map((e) => OverrideVersionedTypeImpl.fromMap(e)).toList(),
        _specVersion),
    ...filterVersions(
        typesChain[_chainName].map((e) => OverrideVersionedTypeImpl.fromMap(e)).toList(),
        _specVersion),
    ...filterVersions(registry.knownTypes.typesBundle?.spec[_specName]?.types, _specVersion),
    ...filterVersions(registry.knownTypes.typesBundle?.chain[_chainName]?.types, _specVersion),
    ...(registry.knownTypes.typesSpec[_specName] ?? {}),
    ...(registry.knownTypes.typesChain[_chainName] ?? {}),
    ...(registry.knownTypes.types ?? {})
  };
}

Map<String, dynamic> getSpecRpc(Registry registry, dynamic chainName, dynamic specName) {
  final _chainName = chainName is CodecText ? chainName.toString() : chainName.toString();

  final _specName = specName is CodecText ? specName.toString() : specName.toString();

  return {
    ...(registry.knownTypes.typesBundle?.spec[_specName]?.rpc ?? {}),
    ...(registry.knownTypes.typesBundle?.chain[_chainName]?.rpc ?? {})
  };
}

Map<String, Map<String, dynamic>> getSpecAlias(
    Registry registry, dynamic chainName, dynamic specName) {
  final _chainName = chainName is CodecText ? chainName.toString() : chainName.toString();

  final _specName = specName is CodecText ? specName.toString() : specName.toString();

  // as per versions, first spec, then chain then finally non-versioned
  return {
    ...(registry.knownTypes.typesBundle?.spec[_specName]?.alias ?? {}),
    ...(registry.knownTypes.typesBundle?.chain[_chainName]?.alias ?? {}),
    ...(registry.knownTypes.typesAlias ?? {})
  };
}

dynamic getUpgradeVersion(Hash genesisHash, BigInt blockNumber) {
  final known = upgrades.firstWhere((u) => genesisHash.eq(u["genesisHash"]));

  return known != null
      ? [
          (known["versions"] as List<Map<String, dynamic>>)
              .map((element) {
                return ChainUpgradeVersionImpl.fromMap(element);
              })
              .toList()
              .fold(null, (last, version) {
                return blockNumber > (version.blockNumber) ? version : last;
              }),
          (known["versions"] as List<Map<String, dynamic>>)
              .map((element) {
                return ChainUpgradeVersionImpl.fromMap(element);
              })
              .toList()
              .firstWhere((version) => blockNumber >= (version.blockNumber))
        ]
      : [null, null];
}
