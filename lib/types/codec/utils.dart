import 'dart:typed_data';
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

bool hasEq(dynamic o) {
  // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access

  return o is BaseCodec ? isFunction((o as dynamic).eq) : false;
}

Constructor<T> typeToConstructor<T extends BaseCodec>(Registry registry, dynamic type) {
  return (isString(type) ? registry.createClass(type) : type) as Constructor<T>;
}

Map<String, Constructor> mapToTypeMap(Registry registry, Map<String, dynamic> input) {
  return input.entries.fold({}, (Map<String, Constructor> output, MapEntry entry) {
    output[entry.key] = typeToConstructor(registry, entry.value);
    return output;
  });
}

List<BaseCodec> decodeU8a(Registry registry, Uint8List u8a, dynamic _types) {
  final types = _types is List ? _types : (_types as Map<String, Constructor>).entries.toList();

  if (types.length == 0) {
    return [];
  }
  final constructor = types[0] as Constructor;
  final value = constructor(registry, u8a);
  final newList = [value];
  newList.addAll(decodeU8a(registry, u8a.sublist(value.encodedLength), types.sublist(1)));
  return newList;
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
  return !(value is List) || value.length != 2;
}

bool compareMapArray(Map a, List b) {
  // equal number of entries and each entry in the array should match
  return (a.length == b.length) &&
      !b.any((entry) => notEntry(entry) || hasMismatch(a[entry[0]], entry[1]));
}

// NOTE These are used internally and when comparing objects, expects that
// when the second is an Map<string, Codec> that the first has to be as well
bool compareMap(Map a, [dynamic b]) {
  if (b is List) {
    return compareMapArray(a, b);
  } else if (b is Map) {
    return compareMap2(a, b);
    // return compareMapArray(a, b.entries.toList());
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
