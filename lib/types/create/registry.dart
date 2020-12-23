import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/metadata/decorate/extrinsics/index.dart';
import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/create/createClass.dart' as classCreator;
import 'package:polkadot_dart/types/create/createClass.dart';
import 'package:polkadot_dart/types/create/createTypes.dart' as typesCreator;
import 'package:polkadot_dart/types/create/getTypeDef.dart';
import 'package:polkadot_dart/types/create/types.dart';
import 'package:polkadot_dart/types/generic/Event.dart';
import 'package:polkadot_dart/types/interfaces/definitions.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';

import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/calls.dart';
import 'package:polkadot_dart/types/types/codec.dart';

import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/format.dart';
import 'package:polkadot_dart/utils/is.dart';
import 'package:polkadot_dart/utils/u8a.dart';
import 'package:polkadot_dart/utils/utils.dart';

// create error mapping from metadata
void injectErrors(Registry _, Metadata metadata, Map<String, RegistryError> metadataErrors) {
  final modules = metadata.asLatest.modules;
  final isIndexed = modules.value.any((module) => module.index.value != BigInt.from(255));

  // decorate the errors
  modules.value.forEach((section) {
    final sectionIndex = isIndexed ? section.index.toNumber() : modules.value.indexOf(section);
    final sectionName = stringCamelCase(section.name.toString());

    section.errors.value.forEach((errorModule) {
      final index = section.errors.value.indexOf(errorModule);
      final eventIndex = Uint8List.fromList([sectionIndex, index]);

      metadataErrors[u8aToHex(eventIndex)] = RegistryError(
          documentation:
              errorModule.documentation.map((d, [index, list]) => d.value.toString()).toList(),
          index: index,
          name: errorModule.name.toString(),
          section: sectionName);
    });
  });
}

void injectEvents(Registry registry, Metadata metadata,
    Map<String, Constructor<GenericEventData>> metadataEvents) {
  final modules = metadata.asLatest.modules;
  final isIndexed = modules.value.any((module) => module.index.value != BigInt.from(255));

  // decorate the events
  final filtered = modules.value.where((module) => module.events.isSome).toList();

  filtered.forEach((section) {
    final _sectionIndex = filtered.indexOf(section);
    final sectionIndex = isIndexed ? section.index.toNumber() : _sectionIndex;
    final sectionName = stringCamelCase(section.name.toString());

    final events = section.events.unwrap().value;
    events.forEach((meta) {
      final methodIndex = events.indexOf(meta);
      final methodName = meta.name.toString();
      final eventIndex = Uint8List.fromList([sectionIndex, methodIndex]);
      // eslint-disable-next-line @typescript-eslint/no-unsafe-call,@typescript-eslint/no-unsafe-member-access
      final typeDef = meta.args.map((arg, [index, list]) => getTypeDef(arg.toString()));
      List<Constructor<BaseCodec>> Types = [];
      try {
        Types = typeDef.map((typeDef) => getTypeClass(registry, typeDef));
      } catch (error) {
        print(error);
      }
      metadataEvents[u8aToHex(eventIndex)] = (Registry registry, [dynamic value]) {
        return GenericEventData(
            registry, value as Uint8List, Types, typeDef, meta, sectionName, methodName);
      };
    });
  });
}

void injectExtrinsics(
    Registry registry, Metadata metadata, Map<String, CallFunction> metadataCalls) {
  final extrinsics = decorateExtrinsics(registry, metadata.asLatest);
  // decorate the extrinsics
  (extrinsics.values).forEach((methods) => (methods.values).forEach((method) {
        metadataCalls[u8aToHex(method.callIndex)] = method;
      }));
}

class TypeRegistry implements Registry {
  Map<String, dynamic> _knownDefaults;
  Map<String, dynamic> _knownDefinitions;
  Map<String, String> _definitions;
  Map<String, bool> _unknownTypes;
  RegisteredTypes _knownTypes;
  RegisteredTypes _registeredTypes;
  Map<String, Constructor> _classes;
  Map<String, Constructor> get cls => _classes;
  Map<String, String> get defs => _definitions;

  Map<String, CallFunction> _metadataCalls = {};

  Map<String, RegistryError> _metadataErrors = {};

  Map<String, Constructor<GenericEventData>> _metadataEvents = {};

  TypeRegistry() {
    this._knownDefaults = {
      'Json': Json.constructor,
      // metadata,
      ...baseTypes
    };
    this._knownDefinitions = Map<String, dynamic>.from(definitions);

    init();
  }

  @override
  // TODO: implement chainDecimals
  int get chainDecimals {
    // return this.#chainProperties?.tokenDecimals.isSome
    //   ? this.#chainProperties.tokenDecimals.unwrap().toNumber()
    //   : 12;
    return 12;
  }

  @override
  // TODO: implement chainSS58
  int get chainSS58 {
    // return this.#chainProperties?.ss58Format.isSome
    //   ? this.#chainProperties.ss58Format.unwrap().toNumber()
    //   : undefined;
    return null;
  }

  @override
  // TODO: implement chainToken
  String get chainToken {
    // return this.#chainProperties?.tokenSymbol.isSome
    //   ? this.#chainProperties.tokenSymbol.unwrap().toString()
    //   : formatBalance.getDefaults().unit;
    return BalanceFormatter.instance.getDefaults().unit;
  }

  @override
  Constructor<T> createClass<T extends BaseCodec>(String type) {
    return classCreator.createClass(this, type);
  }

  @override
  T createType<T extends BaseCodec>(String type, [dynamic params]) {
    return typesCreator.createType(this, type, params != null ? [params] : null);
  }

  @override
  findMetaEvent(Uint8List eventIndex) {
    // TODO: implement findMetaEvent
    throw UnimplementedError();
  }

  @override
  String getClassName(clazz) {
    final entry = [...this._classes.entries].where((entry) => entry.value == clazz).toList();
    return entry == null || entry.isEmpty ? null : entry[0].key;
  }

  @override
  Constructor<T> getConstructor<T extends BaseCodec>(String name, [bool withUnknown]) {
    var returnType = this._classes[name];
    // we have not already created the type, attempt it
    if (returnType == null) {
      final definition = this._definitions[name];

      Constructor<T> baseType;
      // we have a definition, so create the class now (lazily)
      if (definition != null) {
        baseType = classCreator.ClassOf(this, definition);
      } else if (withUnknown != null && withUnknown) {
        // l.warn(`Unable to resolve type ${name}, it will fail on construction`);
        this._unknownTypes[name] = true;
        baseType = DoNotConstruct.withParams(name);
      }

      if (baseType != null) {
        // NOTE If we didn't extend here, we would have strange artifacts. An example is
        // Balance, with this, new Balance() instanceof u128 is true, but Balance !== u128
        // Additionally, we now pass through the registry, which is a link to ourselves

        this._classes[name] = baseType;
        returnType = baseType;
      }
    }

    return returnType as Constructor<T>;
  }

  @override
  String getDefinition(String name) {
    // TODO: implement getDefinition
    throw UnimplementedError();
  }

  @override
  getOrThrow<T extends BaseCodec>(String name, [String msg]) {
    // TODO: implement getOrThrow
    throw UnimplementedError();
  }

  @override
  getOrUnknown<T extends BaseCodec>(String name) {
    return this.getConstructor(name, true) as Constructor<T>;
  }

  @override
  Map<String, dynamic> getSignedExtensionExtra() {
    // TODO: implement getSignedExtensionExtra
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> getSignedExtensionTypes() {
    // TODO: implement getSignedExtensionTypes
    throw UnimplementedError();
  }

  @override
  bool hasClass(String name) {
    // TODO: implement hasClass
    throw UnimplementedError();
  }

  @override
  bool hasDef(String name) {
    // TODO: implement hasDef
    throw UnimplementedError();
  }

  @override
  bool hasType(String name) {
    // TODO: implement hasType
    throw UnimplementedError();
  }

  @override
  H256 hash(Uint8List data) {
    // TODO: implement hash
    throw UnimplementedError();
  }

  @override
  Registry init() {
    this._classes = Map<String, Constructor>();
    this._definitions = new Map<String, String>();
    this._unknownTypes = new Map<String, bool>();

    // this._knownTypes = {};

    this.register(this._knownDefaults);
    this._knownDefinitions.values.forEach((defs) {
      this.register(Map<String, dynamic>.from(defs["types"]));
    });

    this._knownTypes = RegisteredTypes();
    // load balanceFormatter
    BalanceFormatter();
    return this;
  }

  @override
  // TODO: implement knownTypes
  RegisteredTypes get knownTypes => this._knownTypes;

  @override
  void register(arg1, [arg2]) {
    if (isFunction(arg1)) {
      this._classes[arg1.name] = arg1;
    } else if (isString(arg1)) {
      assert(isFunction(arg2), "Expected class definition passed to '$arg1' registration");
      this._classes[arg1.name] = arg2;
    } else {
      this._registerObject(arg1);
    }
  }

  _registerObject(Map<String, dynamic> obj) {
    obj.entries.forEach((entry) {
      if (isFunction(entry.value)) {
        // This _looks_ a bit funny, in js `typeof Clazz === 'function', not in dart
        this._classes[entry.key] = entry.value;
      } else {
        final def = isString(entry.value) ? entry.value : jsonEncode(entry.value);

        // we already have this type, remove the classes registered for it
        if (this._classes.containsKey(entry.key)) {
          this._classes.remove(entry.key);
        }

        this._definitions[entry.key] = def;
      }
    });
  }

  @override
  void setHasher(Uint8List Function(Uint8List p1) hasher) {
    // Tp1) hahap1) ha) {
    // TODO: implement setHasher
  }

  @override
  void setKnownTypes(RegisteredTypes types) {
    this._knownTypes = types;
  }

  @override
  void setMetadata(Metadata metadata, [List<String> signedExtensions]) {
    injectExtrinsics(this, metadata, this._metadataCalls);
    injectErrors(this, metadata, this._metadataErrors);
    injectEvents(this, metadata, this._metadataEvents);

    // this.setSignedExtensions(
    //   signedExtensions || (
    //     metadata.asLatest.extrinsic.version.gt(BN_ZERO)
    //       ? metadata.asLatest.extrinsic.signedExtensions.map((key) => key.toString())
    //       : defaultExtensions
    //   )
    // );
  }

  @override
  void setSignedExtensions([List<String> signedExtensions]) {
    // this.#signedExtensions = signedExtensions;

    // const unknown = findUnknownExtensions(this.#signedExtensions);

    // if (unknown.length) {
    //   l.warn(`Unknown signed extensions ${unknown.join(', ')} found, treating them as no-effect`);
    // }
  }

  @override
  // TODO: implement signedExtensions
  List<String> get signedExtensions => throw UnimplementedError();

  @override
  CallFunction findMetaCall(Uint8List callIndex) {
    final hexIndex = u8aToHex(callIndex);
    // final call = this._metadataCalls[hexIndex];
    // assert(call != null,
    //     "findMetaCall: Unable to find Call with index $hexIndex/[${callIndex.toString()}]");
    return null;
  }
}
