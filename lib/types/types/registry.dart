import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/definitions.dart';

// ignore: camel_case_types

abstract class InterfaceTypes {}

abstract class ChainUpgradeVersion {
  BigInt blockNumber;
  BigInt specVersion;
}

abstract class ChainUpgrades {
  Uint8List genesisHash;
  String network;
  List<ChainUpgradeVersion> versions;
}

// RegistryTypes= Map<String,dynamic>;
// export type RegistryTypes = Record<string, Constructor | string | Record<string, string> | { _enum: string[] | Record<string, string | null> } | { _set: Record<string, number> }>;

// class RegisteredTypes{}

abstract class RegistryMetadataText extends BaseCodec {
  void setOverride(String override);
}

abstract class RegistryMetadataCallArg {
  RegistryMetadataText name;
  RegistryMetadataText type;
}

abstract class RegistryMetadataCall {
  List<RegistryMetadataCallArg> args;
  RegistryMetadataText name;
  dynamic toJSON();
}

abstract class RegistryMetadataCalls {
  bool isSome;
  List<RegistryMetadataCall> unwrap();
}

abstract class RegistryError {
  List<String> documentation;
  int index;
  String name;
  String section;
}

abstract class RegistryMetadataError {
  RegistryMetadataText name;
  List<RegistryMetadataText> documentation;
}

// RegistryMetadataErrors= List<RegistryMetadataError>
// export type RegistryMetadataErrors = RegistryMetadataError[];

abstract class RegistryMetadataEvent {
  List<dynamic> args;
  RegistryMetadataText name;
}

abstract class RegistryMetadataEvents {
  bool isSome;
  List<RegistryMetadataEvent> unwrap();
}

class RegistryMetadataExtrinsic {
  BigInt version;
  List<RegistryMetadataEvent> signedExtensions;
  RegistryMetadataExtrinsic({this.version, this.signedExtensions});
  factory RegistryMetadataExtrinsic.fromMap(Map<String, dynamic> map) {
    return RegistryMetadataExtrinsic(
        version: BigInt.from(map["version"] as int),
        signedExtensions: map["signedExtendsion"] as List<RegistryMetadataEvent>);
  }
}

class RegistryMetadataModule {
  RegistryMetadataCalls calls;
  List<RegistryMetadataError> errors;
  RegistryMetadataEvents events;
  u8 index;
  RegistryMetadataText name;

  RegistryMetadataModule({this.calls, this.errors, this.events, this.index, this.name});
  factory RegistryMetadataModule.fromMap(Map<String, dynamic> map) {
    return RegistryMetadataModule(
        calls: map["calls"] as RegistryMetadataCalls,
        errors: map["errors"] as List<RegistryMetadataError>,
        events: map["events"] as RegistryMetadataEvents,
        index: map["index"] as u8,
        name: map["name"] as RegistryMetadataText);
  }
}

class RegistryMetadataLatest {
  List<RegistryMetadataModule> modules;
  RegistryMetadataExtrinsic extrinsic;
  RegistryMetadataLatest({this.modules, this.extrinsic});
  factory RegistryMetadataLatest.fromMap(Map<String, dynamic> map) {
    return RegistryMetadataLatest(
        modules: map["modules"] as List<RegistryMetadataModule>,
        extrinsic: map["extrinsic"] as RegistryMetadataExtrinsic);
  }
}

class RegistryMetadata {
  RegistryMetadataLatest asLatest;
  int version;
  RegistryMetadata({this.asLatest, this.version});
  factory RegistryMetadata.fromMap(Map<String, dynamic> map) {
    return RegistryMetadata(
        asLatest: map["asLatest"] as RegistryMetadataLatest, version: map["version"] as int);
  }
}

class OverrideVersionedType {
  List<dynamic> minmax; // min(v >= min) and max(v <= max)
  Map<String, dynamic> types;
  OverrideVersionedType({this.minmax, this.types});
  factory OverrideVersionedType.fromMap(Map<String, dynamic> map) {
    return OverrideVersionedType(
        minmax: map["minmax"] as List<dynamic>, types: map["types"] as Map<String, dynamic>);
  }
}

// OverrideModuleType=Map<String,String>;
// export type OverrideModuleType = Record<string, string>;

class OverrideBundleDefinition {
  Map<String, Map<String, dynamic>> alias;
  Map<String, Map<String, DefinitionRpc>> rpc;
  List<OverrideVersionedType> types;
  OverrideBundleDefinition({this.alias, this.rpc, this.types});
  factory OverrideBundleDefinition.fromMap(Map<String, dynamic> map) {
    var _alias = map["alias"] as Map<String, Map<String, dynamic>>;
    var _rpc = map["rpc"] as Map<String, Map<String, DefinitionRpc>>;
    var _types = map["types"] as List<OverrideVersionedType>;
    return OverrideBundleDefinition(alias: _alias, rpc: _rpc, types: _types);
  }
}

class OverrideBundleType {
  Map<String, OverrideBundleDefinition> chain;
  Map<String, OverrideBundleDefinition> spec;
  OverrideBundleType({this.chain, this.spec});
  factory OverrideBundleType.fromMap(Map<String, dynamic> map) {
    var _chain = map["chain"] as Map<String, OverrideBundleDefinition>;
    var _spec = map["spec"] as Map<String, OverrideBundleDefinition>;
    return OverrideBundleType(chain: _chain, spec: _spec);
  }
}

class OverrideVersionedTypeImpl implements OverrideVersionedType {
  @override
  List minmax;

  @override
  Map<String, Object> types;
  OverrideVersionedTypeImpl({this.minmax, this.types});
  factory OverrideVersionedTypeImpl.fromMap(Map<String, Object> map) => OverrideVersionedTypeImpl(
      minmax: map["minmax"] as List, types: map["types"] as Map<String, Object>);
}

class ChainUpgradeVersionImpl implements ChainUpgradeVersion {
  @override
  BigInt blockNumber;

  @override
  BigInt specVersion;
  ChainUpgradeVersionImpl({this.blockNumber, this.specVersion});
  factory ChainUpgradeVersionImpl.fromMap(Map<String, dynamic> map) => ChainUpgradeVersionImpl(
      blockNumber: BigInt.from(map["blockNumber"] as int),
      specVersion: BigInt.from(map["specVersion"] as int));
}

class RegisteredTypes {
  /// @description Additional types used by runtime modules. This is necessary if the runtime modules
  /// uses types not available in the base Substrate runtime.
  Map<String, dynamic> types;

  /// @description Alias an types, as received via the metadata, to a JS-specific type to avoid conflicts. For instance, you can rename the `Proposal` in the `treasury` module to `TreasuryProposal` as to not have conflicts with the one for democracy.
  Map<String, Map<String, String>> typesAlias;

  /// @description A bundle of types related to chain & spec that is injected based on what the chain contains
  OverrideBundleType typesBundle;

  /// @description Additional types that are injected based on the chain we are connecting to. There are keyed by the chain, i.e. `{ 'Kusama CC1': { ... } }`
  Map<String, Map<String, dynamic>> typesChain;

  /// @description Additional types that are injected based on the type of node we are connecting to, as set via specName in the runtime version. There are keyed by the node, i.e. `{ 'edgeware': { ... } }`
  Map<String, Map<String, dynamic>> typesSpec;

  RegisteredTypes({this.types, this.typesAlias, this.typesBundle, this.typesChain, this.typesSpec});
  factory RegisteredTypes.fromMap(Map<String, dynamic> map) {
    var _types = map["types"] as Map<String, dynamic>;
    var _typesAlias = map["typesAlias"] as Map<String, Map<String, String>>;
    var _typesBundle = map["typesBundle"] as OverrideBundleType;
    var _typesChain = map["typesChain"] as Map<String, Map<String, dynamic>>;
    var _typesSepc = map["typesSpec"] as Map<String, Map<String, dynamic>>;
    return RegisteredTypes(
        types: _types,
        typesAlias: _typesAlias,
        typesBundle: _typesBundle,
        typesChain: _typesChain,
        typesSpec: _typesSepc);
  }
}

abstract class Registry {
  int get chainDecimals;
  int get chainSS58;
  String get chainToken;
  RegisteredTypes get knownTypes;
  List<String> get signedExtensions;

  CallFunction findMetaCall(Uint8List callIndex);
  // findMetaError(errorIndex: Uint8Array | { error: BN, index: BN }): RegistryError;

  // due to same circular imports where types don't really want to import from EventData,
  // keep this as a generic Codec, however the actual impl. returns the correct
  // findMetaEvent(eventIndex: Uint8Array): Constructor<any>;
  Constructor<dynamic> findMetaEvent(Uint8List eventIndex);

  // createClass(type: K): Constructor<InterfaceTypes[K]>;
  Constructor<T> createClass<T extends BaseCodec>(String type);

  // createType <K extends keyof InterfaceTypes>(type: K, ...params: unknown[]): InterfaceTypes[K];
  T createType<T extends BaseCodec>(String type, [dynamic params]);

  Constructor<T> getConstructor<T extends BaseCodec>(String name, [bool withUnknown]);

  // ChainProperties getChainProperties();

  String getClassName(Constructor clazz);

  String getDefinition(String name);

  Constructor<T> getOrThrow<T extends BaseCodec>(String name, [String msg]);
  Constructor<T> getOrUnknown<T extends BaseCodec>(String name);
  void setKnownTypes(RegisteredTypes types);

  //  getSignedExtensionExtra(): Record<string, keyof InterfaceTypes>;
  Map<String, dynamic> getSignedExtensionExtra();
  // getSignedExtensionTypes(): Record<string, keyof InterfaceTypes>;
  Map<String, dynamic> getSignedExtensionTypes();
  bool hasClass(String name);
  bool hasDef(String name);
  bool hasType(String name);
  H256 hash(Uint8List data);
  Registry init();
  // register(type: Constructor | RegistryTypes): void;
  // register(name: string, type: Constructor): void;
  // register(arg1: string | Constructor | RegistryTypes, arg2?: Constructor): void;
  void register(dynamic arg1, [dynamic arg2]);
  // setChainProperties(properties?: ChainProperties): void;

  // setHasher(hasher?:(data: Uint8Array) => Uint8Array): void;
  void setHasher(Uint8List Function(Uint8List) hasher);
  // setMetadata(metadata: RegistryMetadata, signedExtensions?: string[]): void;
  void setMetadata(RegistryMetadata metadata, [List<String> signedExtensions]);
  // setSignedExtensions(signedExtensions?: string[]): void;
  void setSignedExtensions([List<String> signedExtensions]);
}
