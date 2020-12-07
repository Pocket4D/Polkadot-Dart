import 'package:polkadot_dart/types/types/codec.dart';
import 'dart:typed_data';

import 'package:polkadot_dart/types/types/registry.dart';

class TypeRegistry implements Registry {
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
    // TODO: implement createClass
    throw UnimplementedError();
  }

  @override
  T createType<T extends BaseCodec>(String type, [params]) {
    // TODO: implement createType
    throw UnimplementedError();
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
    // TODO: implement getConstructor
    throw UnimplementedError();
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
    // TODO: implement getOrUnknown
    throw UnimplementedError();
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
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  // TODO: implement knownTypes
  RegisteredTypes get knownTypes => throw UnimplementedError();

  @override
  void register(arg1, [arg2]) {
    // TODO: implement register
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
