import 'dart:typed_data';

import 'package:polkadot_dart/metadata/decorate/storage/getHasher.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

abstract class CreateItemFn {
  StorageEntryMetadataLatest meta;
  String method;
  String prefix;
  String section;
}

class CreateItemFnImpl implements CreateItemFn {
  @override
  StorageEntryMetadataLatest meta;

  @override
  String method;

  @override
  String prefix;

  @override
  String section;

  CreateItemFnImpl(Registry registry, {this.meta, this.method, this.prefix, this.section});
  factory CreateItemFnImpl.fromMap(Registry registry, Map<String, dynamic> map) {
    return CreateItemFnImpl(registry,
        meta: map["meta"] is Map
            ? StorageEntryMetadataLatest.from(
                registry.createType("StorageEntryMetadataLatest", map["meta"]))
            : map["meta"],
        method: map["method"],
        prefix: map["prefix"],
        section: map["section"]);
  }
}

class CreateItemOptions {
  String key;
  int metaVersion;
  bool skipHashing; // We don't hash the keys defined in ./substrate.ts

  CreateItemOptions({this.key, this.metaVersion, this.skipHashing});
  factory CreateItemOptions.fromMap(Map<String, dynamic> map) {
    return CreateItemOptions(
        key: map["key"], metaVersion: map["metaVersion"], skipHashing: map["skipHashing"]);
  }
}

abstract class IterFn {
  Raw run();
  StorageEntryMetadataLatest meta;
  String method;
  String section;
}

class IterFnImpl implements IterFn {
  @override
  StorageEntryMetadataLatest meta;

  Raw Function([dynamic arg]) func;

  @override
  Raw run() {
    // TODO: implement run
    return this.func.call();
  }

  IterFnImpl({this.func, this.meta});

  @override
  String method;

  @override
  String section;
}

class StorageEntryImpl implements StorageEntry {
  @override
  StorageEntryMetadataLatest meta;

  @override
  String method;

  @override
  String prefix;

  @override
  String section;

  @override
  Map<String, dynamic> Function() toJSON;

  Uint8List Function([dynamic arg]) func;

  StorageEntryImpl(this.func,
      {this.meta,
      this.method,
      this.prefix,
      this.section,
      this.toJSON,
      this.iterKey,
      this.keyPrefix});

  Uint8List run([dynamic arg]) {
    return this.func(arg);
  }

  @override
  Uint8List call([dynamic arg]) => this.run(arg);

  @override
  Function([dynamic arg]) iterKey;

  @override
  Uint8List Function([dynamic arg]) keyPrefix;
}

final EMPTY_U8A = new Uint8List.fromList([]);
final NULL_HASHER = (Uint8List value) => value;

List<HasherFunction> getHashers(CreateItemFn createItemFn) {
  if (createItemFn.meta.type.isDoubleMap) {
    return [
      getHasher(StorageHasher.from(createItemFn.meta.type.asDoubleMap.hasher)),
      getHasher(StorageHasher.from(createItemFn.meta.type.asDoubleMap.key2Hasher))
    ];
  } else if (createItemFn.meta.type.isMap) {
    return [getHasher(StorageHasher.from(createItemFn.meta.type.asMap.hasher))];
  }

  // the default
  return [getHasher()];
}

Uint8List createPrefixedKey(CreateItemFn createItemFn) {
  return u8aConcat([
    xxhashAsU8a(createItemFn.prefix, bitLength: 128),
    xxhashAsU8a(createItemFn.method, bitLength: 128)
  ]);
}

Uint8List createKeyDoubleMap(
    Registry registry, CreateItemFn itemFn, List<dynamic> args, List<HasherFunction> hashers) {
  final name = itemFn.meta.name;
  final type = itemFn.meta.type;
  final hasher1 = hashers.first;
  final hasher2 = hashers.length == 2 ? hashers.last : null;
  // since we are passing an almost-unknown through, trust, but verify
  assert(
      (args is List) &&
          (args[0] != null) &&
          !isNull(args[0]) &&
          (args[1] != null) &&
          !isNull(args[1]),
      "${(name ?? 'unknown').toString()} is a DoubleMap and requires two arguments");

  // if this fails, we have bigger issues
  assert((hasher2 != null), '2 hashing functions should be defined for DoubleMaps');

  final key1 = args.first;
  final key2 = args.last;
  final map = type.asDoubleMap;
  final val1 = registry.createType(map.key1.toString() ?? 'Raw', key1).toU8a();
  final val2 = registry.createType(map.key2.toString() ?? 'Raw', key2).toU8a();

  // as per createKey, always add the length prefix (underlying it is Bytes)
  return compactAddLength(u8aConcat([createPrefixedKey(itemFn), hasher1(val1), hasher2(val2)]));
}

Uint8List createKey(Registry registry, CreateItemFn itemFn, dynamic arg,
    Uint8List Function(Uint8List value) hasher) {
  final name = itemFn.meta.name;
  final type = itemFn.meta.type;
  var param = EMPTY_U8A;

  if (type.isMap) {
    final map = type.asMap;

    assert((arg != null) && !isNull(arg), "${name.toString()} is a Map and requires one argument");

    param = registry.createType(map.key.toString() ?? 'Raw', arg).toU8a();
  }

  // StorageKey is a Bytes, so is length-prefixed
  return compactAddLength(
      u8aConcat([createPrefixedKey(itemFn), param.length > 0 ? hasher(param) : EMPTY_U8A]));
}

StorageEntry expandWithMeta(
    CreateItemFn createItemFn, Uint8List Function([dynamic arg]) _storageFn) {
  final storageFn = StorageEntryImpl(_storageFn);

  storageFn.meta = createItemFn.meta;
  storageFn.method = stringLowerFirst(createItemFn.method);
  storageFn.prefix = createItemFn.prefix;
  storageFn.section = createItemFn.section;

  // explicitly add the actual method in the toJSON, this gets used to determine caching and without it
  // instances (e.g. collective) will not work since it is only matched on param meta
  storageFn.toJSON = () => ({
        ...(createItemFn.meta.toJSON()),
        "storage": {
          "method": createItemFn.method,
          "prefix": createItemFn.prefix,
          "section": createItemFn.section
        }
      });

  return storageFn;
}

StorageKey Function([dynamic arg]) extendHeadMeta(Registry registry, CreateItemFn createItemFn,
    StorageEntry storageEntry, Raw Function([dynamic arg]) iterFn) {
  final outputType = createItemFn.meta.type.isMap
      ? createItemFn.meta.type.asMap.key.toString()
      : createItemFn.meta.type.asDoubleMap.key1.toString();

  // metadata with a fallback value using the type of the key, the normal
  // meta fallback only applies to actual entry values, create one for head
  final iterFnImpl = IterFnImpl(func: iterFn)
    ..meta = StorageEntryMetadataLatest.from(registry.createType('StorageEntryMetadataLatest', {
      "documentation": createItemFn.meta.documentation,
      "fallback": registry.createType('Bytes', registry.createType(outputType ?? 'Raw').toHex()),
      "modifier": registry.createType('StorageEntryModifierLatest', 1), // required
      "name": createItemFn.meta.name,
      "type": registry.createType('StorageEntryTypeLatest', [
        registry.createType(
            'Type',
            createItemFn.meta.type.isMap
                ? createItemFn.meta.type.asMap.key
                : createItemFn.meta.type.asDoubleMap.key1),
        0
      ])
    }));
  iterFnImpl.method = storageEntry.method;
  iterFnImpl.section = storageEntry.section;

  final prefixKey = registry.createType('StorageKey', [
    iterFnImpl,
    StorageKeyExtra(method: storageEntry.method, section: createItemFn.section)
  ]) as StorageKey;

  return ([dynamic arg]) => (arg != null) && !isNull(arg)
      ? registry.createType('StorageKey', [
          iterFn(arg),
          StorageKeyExtra(method: storageEntry.method, section: createItemFn.section)
        ]) as StorageKey
      : prefixKey;
}

StorageEntry extendPrefixedMap(Registry registry, CreateItemFn itemFn, StorageEntry storageFn) {
  final type = itemFn.meta.type;

  storageFn.iterKey = extendHeadMeta(registry, itemFn, storageFn, ([dynamic arg]) {
    assert(type.isDoubleMap || (arg == null),
        'Filtering arguments for keys/entries are only valid on double maps');

    return new Raw(
        registry,
        type.isDoubleMap && (arg != null) && !isNull(arg)
            ? u8aConcat([
                createPrefixedKey(itemFn),
                getHasher(type.asDoubleMap.hasher)(
                    registry.createType(type.asDoubleMap.key1.toString() ?? 'Raw', arg).toU8a())
              ])
            : createPrefixedKey(itemFn));
  });

  return storageFn;
}

StorageEntry createFunction(Registry registry, CreateItemFn itemFn, CreateItemOptions options) {
  final type = itemFn.meta.type;
  final hashers = getHashers(itemFn);
  final hasher = hashers.first;
  final key2Hasher = hashers.last;

  // Can only have zero or one argument:
  //   - storage.system.account(address)
  //   - storage.timestamp.blockPeriod()
  // For doublemap queries the params is passed in as an tuple, [key1, key2]
  final storageFn = expandWithMeta(
      itemFn,
      ([dynamic arg]) => type.isDoubleMap
          ? createKeyDoubleMap(registry, itemFn, arg as List<dynamic>, [hasher, key2Hasher])
          : createKey(registry, itemFn, arg as dynamic,
              options.skipHashing == true ? NULL_HASHER : hasher));

  if (type.isMap || type.isDoubleMap) {
    extendPrefixedMap(registry, itemFn, storageFn);
  }

  storageFn.keyPrefix = ([dynamic arg]) =>
      (storageFn.iterKey != null && storageFn.iterKey(arg)) != null ??
      compactStripLength(storageFn.call())[1];

  return storageFn;
}
