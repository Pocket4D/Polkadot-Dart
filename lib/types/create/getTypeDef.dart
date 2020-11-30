import 'dart:convert';

import 'package:polkadot_dart/types/create/sanitize.dart';
import 'package:polkadot_dart/types/create/types.dart';

class TypeDefOptions {
  String name;
  String displayName;
  TypeDefOptions({this.name, this.displayName});
}

const MAX_NESTED = 64;

/// decode an enum of either of the following forms
///  { _enum: ['A', 'B', 'C'] }
///  { _enum: { A: AccountId, B: Balance, C: u32 } }
TypeDef _decodeEnum(TypeDef value, dynamic details, int count) {
  value.info = TypeDefInfo.Enum;

  // not as pretty, but remain compatible with oo7 for both struct and Array types
  value.sub = (details is List)
      ? details.map((name) => ({"info": TypeDefInfo.Plain, "name": name, "type": 'Null'}))
      : (details as Map<String, String>).entries.map((d) =>
          // eslint-disable-next-line @typescript-eslint/no-use-before-define
          getTypeDef(d.value ?? 'Null', TypeDefOptions(name: d.key), count));

  return value;
}

/// decode a set of the form
///   { _set: { A: 0b0001, B: 0b0010, C: 0b0100 } }
// TypeDef _decodeSet(TypeDef value, Map<String,num>details) {
//   value.info = TypeDefInfo.Set;
//   // TODO details have to be Codec
//   value.length = details._bitLength;
//   value.sub = Object
//     .entries(details)
//     .filter(([name]): boolean => !name.startsWith('_'))
//     .map(([name, index]): TypeDef =>({
//       index,
//       info: TypeDefInfo.Plain,
//       name,
//       type: name
//     }));

//   return value;
// }

/// decode a struct, set or enum
/// eslint-disable-next-line @typescript-eslint/no-unused-vars
//  TypeDef _decodeStruct(TypeDef value , String type, String _, int count) {
//   // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
//   final parsed = Map<String,dynamic>.from(jsonDecode(type));
//   final keys = parsed.keys.toList();

//   if(keys.length == 1 && keys[0] == '_enum') {
//     return _decodeEnum(value, parsed[keys[0]], count);
//   } else if(keys.length == 1 && keys[0] == '_set') {
//     return _decodeSet(value, parsed[keys[0]]);
//   }

//   value.alias = parsed._alias
//     ? new Map(Object.entries(parsed._alias))
//     : undefined;
//   value.sub = keys.filter((name) => !['_alias'].includes(name)).map((name): TypeDef =>
//     // eslint-disable-next-line @typescript-eslint/no-use-before-define
//     getTypeDef(parsed[name], { name }, count)
//   );

//   return value;
// }

/// decode a fixed vector, e.g. [u8;32]
/// eslint-disable-next-line @typescript-eslint/no-unused-vars
TypeDef _decodeFixedVec(TypeDef value, String type, String _, int count) {
  final subType = type.substring(1, type.length - 1).split(';');
  var vecType = subType[0];
  var strLength = subType[1];
  var displayName = subType[2];
  final length = int.parse(strLength.trim(), radix: 10);

  // as a first round, only u8 via u8aFixed, we can add more support
  assert(length <= 256, "$type: Only support for [Type; <length>], where length <= 256");

  value.displayName = displayName;
  value.length = length;
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  value.sub = getTypeDef(vecType, TypeDefOptions(), count);

  return value;
}

// decode a tuple
TypeDef _decodeTuple(TypeDef value, String _, String subType, int count) {
  value.sub = subType.length == 0
      ? []
      // eslint-disable-next-line @typescript-eslint/no-use-before-define
      : typeSplit(subType).map((inner) => getTypeDef(inner, TypeDefOptions(), count));

  return value;
}

/// decode a Int/UInt<bitLength[, name]>
/// eslint-disable-next-line @typescript-eslint/no-unused-vars
// clazz= 'Int' | 'UInt'
TypeDef _decodeAnyInt(TypeDef value, String type, String _, [String clazz]) {
  final subType = type.substring(clazz.length + 1, type.length - 1).split(',');
  var strLength = subType[0];
  var displayName = subType[1];

  final length = int.parse(strLength.trim(), radix: 10);

  // as a first round, only u8 via u8aFixed, we can add more support
  assert(length <= 8192 && (length % 8) == 0,
      "$type: Only support for $clazz<bitLength>, where length <= 8192 and a power of 8, found $length");

  value.displayName = displayName;
  value.length = length;

  return value;
}

TypeDef _decodeInt(TypeDef value, String type, String subType) {
  return _decodeAnyInt(value, type, subType, 'Int');
}

TypeDef _decodeUInt(TypeDef value, String type, String subType) {
  return _decodeAnyInt(value, type, subType, 'UInt');
}

TypeDef _decodeDoNotConstruct(TypeDef value, String type, String _) {
  const NAME_LENGTH = 'DoNotConstruct'.length;

  value.displayName = type.substring(NAME_LENGTH + 1, type.length - 1);
  return value;
}

bool hasWrapper(String type, List wrapper) {
  return (type.substring(0, (wrapper[0] as String).length) == (wrapper[0] as String)) &&
      (type.substring(type.length - 1 * (wrapper[1] as String).length) == (wrapper[1] as String));
}

final nestedExtraction = [
  ['[', ']', TypeDefInfo.VecFixed, _decodeFixedVec],
  // ['{', '}', TypeDefInfo.Struct, _decodeStruct],
  ['(', ')', TypeDefInfo.Tuple, _decodeTuple],
  // the inner for these are the same as tuple, multiple values
  ['BTreeMap<', '>', TypeDefInfo.BTreeMap, _decodeTuple],
  ['HashMap<', '>', TypeDefInfo.HashMap, _decodeTuple],
  ['Int<', '>', TypeDefInfo.Int, _decodeInt],
  ['Result<', '>', TypeDefInfo.Result, _decodeTuple],
  ['UInt<', '>', TypeDefInfo.UInt, _decodeUInt],
  ['DoNotConstruct<', '>', TypeDefInfo.DoNotConstruct, _decodeDoNotConstruct]
];

final wrappedExtraction = [
  ['BTreeSet<', '>', TypeDefInfo.BTreeSet],
  ['Compact<', '>', TypeDefInfo.Compact],
  ['Linkage<', '>', TypeDefInfo.Linkage],
  ['Option<', '>', TypeDefInfo.Option],
  ['Vec<', '>', TypeDefInfo.Vec]
];

String extractSubType(String type, List wrapper) {
  return type.substring((wrapper[0] as String).length, type.length - (wrapper[1] as String).length);
}

/// eslint-disable-next-line @typescript-eslint/ban-types
TypeDef getTypeDef(String _type, TypeDefOptions options, [count = 0]) {
  // create the type via Type, allowing types to be sanitized
  var type = sanitize(_type);
  final value = TypeDef.fromMap({
    "displayName": options.displayName,
    "info": TypeDefInfo.Plain,
    "name": options.name,
    "type": type
  });

  assert(++count != MAX_NESTED, 'getTypeDef: Maximum nested limit reached');

  final nested = nestedExtraction.where((nested) => hasWrapper(type, nested)).toList();

  if (nested != null) {
    value.info = nested[2] as TypeDefInfo;

    return (nested[3] as Function)(value, type, extractSubType(type, nested), count);
  }

  final wrapped = wrappedExtraction.where((wrapped) => hasWrapper(type, wrapped)).toList();

  if (wrapped != null) {
    value.info = wrapped[2] as TypeDefInfo;
    value.sub = getTypeDef(extractSubType(type, wrapped), TypeDefOptions(), count);
  }

  return value;
}
