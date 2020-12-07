import 'dart:typed_data';

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

abstract class RegistryMetadataExtrinsic {
  BigInt version;
  List<RegistryMetadataEvent> signedExtensions;
}

abstract class RegistryMetadataModule {
  RegistryMetadataCalls calls;
  List<RegistryMetadataError> errors;
  RegistryMetadataEvents events;
  u8 index;
  RegistryMetadataText name;
}

abstract class RegistryMetadataLatest {
  List<RegistryMetadataModule> modules;
  RegistryMetadataExtrinsic extrinsic;
}

abstract class RegistryMetadata {
  RegistryMetadataLatest asLatest;
  int version;
}

abstract class OverrideVersionedType {
  List<dynamic> minmax; // min(v >= min) and max(v <= max)
  Map<String, dynamic> types;
}

// OverrideModuleType=Map<String,String>;
// export type OverrideModuleType = Record<string, string>;

abstract class OverrideBundleDefinition {
  Map<String, Map<String, dynamic>> alias;
  Map<String, Map<String, DefinitionRpc>> rpc;
  List<OverrideVersionedType> types;
}

abstract class OverrideBundleType {
  Map<String, OverrideBundleDefinition> chain;
  Map<String, OverrideBundleDefinition> spec;
}

abstract class RegisteredTypes {
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
}

abstract class Registry {
  int get chainDecimals;
  int get chainSS58;
  String get chainToken;
  RegisteredTypes get knownTypes;
  List<String> get signedExtensions;

  // findMetaCall(callIndex: Uint8Array): CallFunction;
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
