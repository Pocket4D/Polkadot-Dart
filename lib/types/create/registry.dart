import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/create/createClass.dart' as classCreator;
import 'package:polkadot_dart/types/create/createTypes.dart' as typesCreator;
import 'package:polkadot_dart/types/create/types.dart';

import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/codec.dart';

import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/is.dart';

class TypeRegistry implements Registry {
  Map<String, dynamic> _knownDefaults;
  Map<String, String> _definitions;
  Map<String, bool> _unknownTypes;
  RegisteredTypes _registeredTypes;
  Map<String, Constructor> _classes;
  TypeRegistry() {
    this._knownDefaults = {
      'Json': Json.constructor,
      // metadata,
      ...baseTypes
    };
    init();
  }

  @override
  // TODO: implement chainDecimals
  int get chainDecimals => throw UnimplementedError();

  @override
  // TODO: implement chainSS58
  int get chainSS58 => throw UnimplementedError();

  @override
  // TODO: implement chainToken
  String get chainToken => throw UnimplementedError();

  @override
  Constructor<T> createClass<T extends BaseCodec>(String type) {
    return classCreator.createClass(this, type);
  }

  @override
  T createType<T extends BaseCodec>(String type, [params]) {
    return typesCreator.createType(this, type, params);
  }

  @override
  findMetaEvent(Uint8List eventIndex) {
    // TODO: implement findMetaEvent
    throw UnimplementedError();
  }

  @override
  String getClassName(clazz) {
    // TODO: implement getClassName
    throw UnimplementedError();
  }

  @override
  getConstructor<T extends BaseCodec>(String name, [bool withUnknown]) {
    var returnType = this._classes[name];

    // we have not already created the type, attempt it
    if (returnType == null) {
      final definition = this._definitions[name];
      Constructor<BaseCodec> baseType;

      // we have a definition, so create the class now (lazily)
      if (definition != null) {
        baseType = classCreator.ClassOf(this, definition);
      } else if (withUnknown != null && withUnknown) {
        // l.warn(`Unable to resolve type ${name}, it will fail on construction`);
        this._unknownTypes.putIfAbsent(name, () => true);
        baseType = DoNotConstruct.withParams(name);
      }

      if (baseType != null) {
        // NOTE If we didn't extend here, we would have strange artifacts. An example is
        // Balance, with this, new Balance() instanceof u128 is true, but Balance !== u128
        // Additionally, we now pass through the registry, which is a link to ourselves

        this._classes.putIfAbsent(name, () => baseType);
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

    this.register(this._definitions);
    this.register(this._knownDefaults);
    return this;
  }

  @override
  // TODO: implement knownTypes
  RegisteredTypes get knownTypes => throw UnimplementedError();

  @override
  void register(arg1, [arg2]) {
    if (isFunction(arg1)) {
      this._classes.putIfAbsent(arg1.name, () => arg1);
    } else if (isString(arg1)) {
      assert(isFunction(arg2), "Expected class definition passed to '$arg1' registration");

      this._classes.putIfAbsent(arg1, () => arg2);
    } else {
      this._registerObject(arg1);
    }
  }

  _registerObject(Map<String, dynamic> obj) {
    obj.entries.forEach((entry) {
      if (isFunction(entry.value)) {
        // This _looks_ a bit funny, in js `typeof Clazz === 'function', not in dart
        this._classes.putIfAbsent(entry.key, () => entry.value);
      } else {
        final def = isString(entry.value) ? entry.value : jsonEncode(entry.value);

        // we already have this type, remove the classes registered for it
        if (this._classes.containsKey(entry.key)) {
          this._classes.remove(entry.key);
        }

        this._definitions.putIfAbsent(entry.key, () => def);
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
    // TODO: implement setKnownTypes
  }

  @override
  void setMetadata(RegistryMetadata metadata, [List<String> signedExtensions]) {
    // TODO: implement setMetadata
  }

  @override
  void setSignedExtensions([List<String> signedExtensions]) {
    // TODO: implement setSignedExtensions
  }

  @override
  // TODO: implement signedExtensions
  List<String> get signedExtensions => throw UnimplementedError();
}
