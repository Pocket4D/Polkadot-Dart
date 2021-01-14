import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

bool hasEq(dynamic o) {
  return o is BaseCodec ? isFunction((o as dynamic).eq) : false;
}

Constructor<T> typeToConstructor<T extends BaseCodec>(Registry registry, dynamic type) {
  return isString(type) ? registry.createClass(type) : type as Constructor<T>;
}

Map<String, Constructor> mapToTypeMap(Registry registry, Map<String, dynamic> input) {
  return input.entries.fold({}, (Map<String, Constructor> output, MapEntry entry) {
    output[entry.key] =
        typeToConstructor(registry, entry.value is Function ? entry.value : entry.value.toString());
    return output;
  });
}

// ignore: unused_element
@deprecated
List<BaseCodec> _decodeU8a(Registry registry, Uint8List u8a, dynamic _types) {
  final types = _types is List ? _types : (_types as Map<String, Constructor>).entries.toList();
  if (types.length == 0) {
    return [];
  }
  final constructor = types[0] as Constructor;
  final value = constructor(registry, u8a);
  final newList = [value];

  if (u8a.isEmpty) {
    u8a = Uint8List.fromList(List.filled(value.encodedLength, 0));
  }
  final subLength = value.encodedLength > u8a.length ? u8a.length : value.encodedLength;

  return flatternArray<BaseCodec>(
      [newList, _decodeU8a(registry, u8a.sublist(subLength), types.sublist(1))]);
}

List<BaseCodec> decodeU8a(Registry registry, Uint8List u8a, dynamic _types) {
  final types = _types is List ? _types : (_types as Map<String, Constructor>).entries.toList();
  if (types.length == 0) {
    return [];
  }

  List<BaseCodec> result = List<BaseCodec>.from([]);
  types.forEach((type) {
    final constructor = type as Constructor;
    final value = constructor(registry, u8a);
    if (u8a.isEmpty) {
      u8a = Uint8List.fromList(List.filled(value.encodedLength, 0));
    }
    final subLength = value.encodedLength > u8a.length ? u8a.length : value.encodedLength;
    u8a = u8a.sublist(subLength);
    result.add(value);
  });
  return result;
}

Future<List<BaseCodec>> asyncDecodeU8a(Registry registry, Uint8List u8a, dynamic _types) async {
  final types = _types is List ? _types : (_types as Map<String, Constructor>).entries.toList();
  if (types.length == 0) {
    return [];
  }
  var stream = decodeU8aStream(registry, u8a, types);
  var result = await sumU8aStream(stream);
  return result;
}

Stream<BaseCodec> decodeU8aStream(Registry registry, Uint8List u8a, List<dynamic> types) async* {
  for (int i = 0; i < types.length; i++) {
    final constructor = types[i] as Constructor;
    final value = await generateData(registry, constructor, u8a);
    if (u8a.isEmpty) {
      u8a = Uint8List.fromList(List.filled(value.encodedLength, 0));
    }
    final subLength = value.encodedLength > u8a.length ? u8a.length : value.encodedLength;
    u8a = u8a.sublist(subLength);
    yield value;
  }
}

Future<BaseCodec> generateData(Registry registry, Constructor constructor, Uint8List u8a) async =>
    constructor(registry, u8a);

Future<List<BaseCodec>> sumU8aStream(Stream<BaseCodec> stream) async {
  List<BaseCodec> sum = List<BaseCodec>.from([]);
  await for (var value in stream) {
    sum.add(value);
  }
  return sum;
}

bool compareSetArray(Set a, List<dynamic> b) {
  // equal number of entries and each entry in the array should match
  return (a.length == b.length) && !b.any((entry) => !a.contains(entry));
}

bool compareSets(Set a, Set b) {
  final setCompare = SetEquality();
  return setCompare.equals(a, b);
}

bool compareList(List a, List b) {
  final listCompare = DeepCollectionEquality.unordered();
  return listCompare.equals(a, b);
}

// NOTE These are used internally and when comparing objects, expects that
// when the second is an Set<string, Codec> that the first has to be as well
bool compareSet(Set a, [dynamic b]) {
  if ((b) is List) {
    // return compareSets(a, b.toSet());
    return compareList(a.toList(), b);
  } else if (b is Set) {
    // return compareSets(a, b);
    return compareList(a.toList(), b.toList());
  } else if (b is Map) {
    // return compareSets(a, b.values.toSet());
    return compareList(a.toList(), b.values.toList());
  }

  return false;
}

bool hasMismatch([dynamic a, dynamic b]) {
  return a == null || (hasEq(a) ? !a.eq(b) : a != b);
}

bool notEntry(value) {
  return !(value is List) || (value.length != 2);
}

bool compareMapArray(Map a, List b) {
  // equal number of entries and each entry in the array should match
  final c = b.any((entry) {
    var result = true;
    if (entry is MapEntry) {
      result = hasMismatch(a[entry.key], entry.value);
    } else if (entry is List && entry.length == 2) {
      result = hasMismatch(a[entry[0]], entry[1]);
    }
    return result;
  });

  return (a.length == b.length) && !c;
}

// NOTE These are used internally and when comparing objects, expects that
// when the second is an Map<string, Codec> that the first has to be as well
bool compareMap(Map a, [dynamic b]) {
  if (b is List) {
    return compareMapArray(a, b);
  } else if (a is Map<dynamic, BaseCodec> && b is Map<dynamic, dynamic>) {
    return compareMapArray(a, b.entries.toList());
  } else if (b is Map<String, dynamic>) {
    return compareMap2(a, b);
  }
  return false;
}

bool compareArray(List a, dynamic b) {
  if (b is List) {
    var result = a.where(
        (value) => hasEq(value) ? !value.eq(b[a.indexOf(value)]) : value != b[a.indexOf(value)]);

    return (a.length == b.length) && result.isEmpty;
  }
  return false;
}

bool compareMap2<T, U>(Map<T, U> a, Map<T, U> b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (final T key in a.keys) {
    if (!b.containsKey(key) || b[key] != a[key]) {
      return false;
    }
  }
  return true;
}
