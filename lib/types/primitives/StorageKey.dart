import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadot_dart/metadata/decorate/storage/createFunction.dart';
import 'package:polkadot_dart/types/codec/Raw.dart';
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/primitives/Bytes.dart';
import 'package:polkadot_dart/types/primitives/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

class DecodedStorageKey {
  dynamic key;
  String method;
  String section;
  DecodedStorageKey({this.key, this.method, this.section});
}

class StorageKeyExtra {
  String method;
  String section;
  StorageKeyExtra({this.method, this.section});
}

const HASHER_MAP = {
  // opaque
  "Blake2_128": [16, false], // eslint-disable-line camelcase
  "Blake2_128Concat": [16, true], // eslint-disable-line camelcase
  "Blake2_256": [32, false], // eslint-disable-line camelcase
  "Identity": [0, true],
  "Twox128": [16, false],
  "Twox256": [32, false],
  "Twox64Concat": [8, true]
};

/// [bool, String]
List<dynamic> getStorageType(StorageEntryTypeLatest type) {
  if (type.isPlain) {
    return [false, type.asPlain.toString()];
  } else if (type.isDoubleMap) {
    var map = type.asDoubleMap.toJSON();
    var rewrap = map.map((key, val) {
      return MapEntry(key, val is bool ? 'Bool' : val);
    });
    return [false, jsonEncode(rewrap)];
  }
  var map = type.asMap.toJSON();
  var rewrap = map.map((key, val) {
    return MapEntry(key, val is bool ? 'Bool' : val);
  });
  return [false, jsonEncode(rewrap)];
}

// we unwrap the type here, turning into an output usable for createType
/// @internal */
///
String unwrapStorageType(StorageEntryTypeLatest type, [bool isOptional]) {
  final arr = getStorageType(type);
  final hasWrapper = arr[0] as bool;
  final outputType = arr[1] as String;

  return isOptional != null && isOptional == true && !hasWrapper
      ? "Option<$outputType>"
      : outputType;
}

/// @internal */
DecodedStorageKey decodeStorageKey([dynamic value]) {
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  if (value is StorageKey) {
    return DecodedStorageKey(key: value, method: value.method, section: value.section);
  } else if (value == null || isString(value) || isU8a(value)) {
    // let Bytes handle these inputs
    return DecodedStorageKey(key: value);
  } else if (isFunction(value)) {
    return DecodedStorageKey(key: value(), method: null, section: null);
  } else if (value is IterFnImpl) {
    return DecodedStorageKey(key: value, method: value.method, section: value.section);
  } else if ((value is List)) {
    final fn = value[0] as StorageEntry;
    final args = value.sublist(1);

    assert(isFunction(fn), 'Expected function input for key construction');

    return DecodedStorageKey(key: fn.call([...args]), method: fn.method, section: fn.section);
  }

  throw "Unable to convert input $value to StorageKey";
}

// hasher: [StorageHasher, string]
List<BaseCodec> decodeHashers(Registry registry, Uint8List value, List<dynamic> hashers) {
  // the storage entry is xxhashAsU8a(prefix, 128) + xxhashAsU8a(method, 128), 256 bits total
  var offset = 32;
  final decodedList = hashers.fold<List<BaseCodec>>(List<BaseCodec>.from([]), (result, hArray) {
    final hasher = StorageHasher.from(hArray[0]);
    final type = hArray[1] as String;
    final hashMap = HASHER_MAP[hasher.type ?? 'Identity'];
    final hashLen = hashMap[0] as int;
    final canDecode = hashMap[1] as bool;
    final decoded = canDecode
        ? registry.createType(type ?? 'Raw', value.sublist(offset + hashLen))
        : registry.createType('Raw', value.sublist(offset, offset + hashLen));

    offset += hashLen + (canDecode ? decoded.encodedLength : 0);
    result.add(decoded);

    return result;
  });
  return decodedList;
}

/// @internal */
List<BaseCodec> decodeArgsFromMeta(Registry registry, Uint8List value,
    [StorageEntryMetadataLatest thisMeta]) {
  if (thisMeta == null || !(thisMeta.type.isDoubleMap || thisMeta.type.isMap)) {
    return [];
  }

  if (thisMeta.type.isMap) {
    final mapInfo = thisMeta.type.asMap;

    return decodeHashers(registry, value, [
      [mapInfo.hasher, mapInfo.key.toString()]
    ]);
  }

  final mapInfo = thisMeta.type.asDoubleMap;

  return decodeHashers(registry, value, [
    [mapInfo.hasher, mapInfo.key1.toString()],
    [mapInfo.key2Hasher, mapInfo.key2.toString()]
  ]);
}

class StorageKey extends Bytes {
  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore This is assigned via this.decodeArgsFromMeta()
  List<BaseCodec> _args;

  StorageEntryMetadataLatest _meta;

  StorageEntryMetadataLatest get meta => _meta;

  String _outputType;

  String _method;

  String _section;

  dynamic originValue;

  StorageKeyExtra originOverride;

  StorageKey.empty() : super.empty();

  StorageKey(Registry registry, [dynamic value, StorageKeyExtra override])
      : super(registry, decodeStorageKey(value).key) {
    originValue = value;
    originOverride = override;
    if (override == null) {
      override = StorageKeyExtra();
    }
    final decodedVal = decodeStorageKey(value);

    // super(registry, key);

    this._outputType = StorageKey.getType(value);

    // decode the args(as applicable based on the key and the hashers, after all init)
    this.setMeta(StorageKey.getMeta(value), override?.section ?? decodedVal.section,
        override?.method ?? decodedVal.method);
  }

  static StorageKey constructor(Registry registry, [dynamic value, dynamic override]) =>
      StorageKey(registry, value, override);

  static StorageEntryMetadataLatest getMeta(dynamic value) {
    if (value is StorageKey) {
      return value.meta;
    } else if (isFunction(value)) {
      return value.meta;
    } else if ((value is List)) {
      final fn = value[0] as StorageEntry;
      return fn.meta;
    }

    return null;
  }

  static String getType(dynamic value) {
    if (value is StorageKey) {
      return value.outputType;
    } else if (isFunction(value)) {
      return unwrapStorageType((value).meta.type);
    } else if ((value is List)) {
      final fn = value[0] as StorageEntry;
      if (fn.meta != null) {
        return unwrapStorageType(fn.meta.type);
      }
    }

    // If we have no type set, default to Raw
    return 'Raw';
  }

  /// @description Return the decoded arguments(applicable to map/doublemap with decodable values)
  List<BaseCodec> get args {
    return this._args;
  }

  /// @description The key method or `undefined` when not specified
  String get method {
    return this._method;
  }

  /// @description The output type
  String get outputType {
    return this._outputType;
  }

  /// @description The key section or `undefined` when not specified
  String get section {
    return this._section;
  }

  /// @description Sets the meta for this key
  void setMeta([StorageEntryMetadataLatest metaData, String sectionData, String methodData]) {
    try {
      this._meta = metaData;
      this._args = decodeArgsFromMeta(this.registry, this.toU8a(true), this.meta);
    } catch (e) {}

    this._method = sectionData ?? this._method;
    this._section = methodData ?? this._section;

    if (metaData != null) {
      this._outputType = unwrapStorageType(metaData.type);
    }
  }

  /// @description Returns the Human representation for this type
  dynamic toHuman([bool isExtended]) {
    return this._args.length != 0
        ? this._args.map((arg) => arg.toHuman()).toList()
        : super.toHuman();
  }

  /// @description Returns the raw type for this
  String toRawType() {
    return 'StorageKey';
  }
}
