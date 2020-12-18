import 'dart:convert';

import 'package:polkadot_dart/types/create/types.dart';
import 'package:polkadot_dart/utils/utils.dart';
// final stringIdentity = <T extends { toString:() => string }>(value: T): string => value.toString();

abstract class WithToStringClass {
  String toString();
}

String stringIdentity(dynamic value) => value.toString();

// ignore: non_constant_identifier_names
final INFO_WRAP = ['BTreeMap', 'BTreeSet', 'Compact', 'HashMap', 'Option', 'Result', 'Vec'];

String paramsNotation<T extends WithToStringClass>(String outer, dynamic inner,
    [String Function(T) transform]) {
  return "$outer${inner != null ? "<${((inner is List<T>) ? inner : [
      inner
    ]).map<String>(transform ?? stringIdentity).join(', ')}>" : ''}";
}

String encodeWithParams(TypeDef typeDef, String outer) {
  final info = typeDef.info;
  final sub = typeDef.sub;
  switch (info) {
    case TypeDefInfo.BTreeMap:
      break;
    case TypeDefInfo.BTreeSet:
      break;
    case TypeDefInfo.Compact:
      break;
    case TypeDefInfo.HashMap:
      break;
    case TypeDefInfo.Linkage:
      break;
    case TypeDefInfo.Option:
      break;
    case TypeDefInfo.Result:
      break;
    case TypeDefInfo.Vec:
      return paramsNotation(outer, sub, (param) => encodeTypeDef(param));
    case TypeDefInfo.Enum:
      break;
    case TypeDefInfo.Plain:
      break;
    case TypeDefInfo.Set:
      break;
    case TypeDefInfo.Struct:
      break;
    case TypeDefInfo.Tuple:
      break;
    case TypeDefInfo.VecFixed:
      break;
    case TypeDefInfo.Int:
      break;
    case TypeDefInfo.UInt:
      break;
    case TypeDefInfo.DoNotConstruct:
      break;
    case TypeDefInfo.Null:
      break;
  }
  throw "Unable to encode ${jsonEncode(typeDef)} with params";
}

String encodeDoNotConstruct(TypeDef def) {
  return "DoNotConstruct<${def.displayName ?? 'Unknown'}>";
}

String encodeSubTypes(List<TypeDef> sub, [bool asEnum]) {
  final names = sub.map((def) => def.name);

  assert(names.every((n) => n != null),
      "Subtypes does not have consistent names, ${names.join(', ')}");

  final inner = sub.fold<Map<String, String>>({} as Map<String, String>,
      (Map<String, String> result, TypeDef type) {
    return {...result, type.name: encodeTypeDef(type)};
  });

  return jsonEncode(asEnum ? {"_enum": inner} : inner);
}

String encodeEnum(TypeDef typeDef) {
  assert(typeDef.sub != null && (typeDef.sub is List), 'Unable to encode Enum type');

  final sub = typeDef.sub as List;

  List<String> mapper(List<dynamic> arr) {
    List<String> enumList = List<String>(arr.length);
    for (var index = 0; index < arr.length; index += 1) {
      enumList.add("${arr[index].name}" ?? "Empty$index");
    }
    return enumList;
  }

  // c-like enums have all Null entries
  // TODO We need to take the disciminant into account and auto-add empty entries
  return sub.every((def) => def.type == 'Null')
      ? jsonEncode({"_enum": mapper(sub)})
      : encodeSubTypes(sub, true);
}

String encodeStruct(TypeDef typeDef) {
  assert(typeDef.sub && (typeDef.sub is List), 'Unable to encode Struct type');

  return encodeSubTypes(typeDef.sub);
}

String encodeTuple(TypeDef typeDef) {
  assert(typeDef.sub && (typeDef.sub is List), 'Unable to encode Tuple type');

  return "(${typeDef.sub.map((type) => encodeTypeDef(type)).join(', ')})";
}

String encodeUInt(TypeDef def, String type) {
  assert(isNumber(def.length), 'Unable to encode VecFixed type');

  return "$type<${def.length}>";
}

String encodeVecFixed(TypeDef def) {
  assert(isNumber(def.length) && (def.sub != null) && !(def.sub is List),
      'Unable to encode VecFixed type');

  return "[${def.sub.type};${def.length}]";
}

// // We setup a record here to ensure we have comprehensive coverage(any item not covered will result
// // in a compile-time error with the missing index)
final encoders = {
  TypeDefInfo.BTreeMap: (TypeDef typeDef) => encodeWithParams(typeDef, 'BTreeMap'),
  TypeDefInfo.BTreeSet: (TypeDef typeDef) => encodeWithParams(typeDef, 'BTreeSet'),
  TypeDefInfo.Compact: (TypeDef typeDef) => encodeWithParams(typeDef, 'Compact'),
  TypeDefInfo.DoNotConstruct: (TypeDef typeDef) => encodeDoNotConstruct(typeDef),
  TypeDefInfo.Enum: (TypeDef typeDef) => encodeEnum(typeDef),
  TypeDefInfo.HashMap: (TypeDef typeDef) => encodeWithParams(typeDef, 'HashMap'),
  TypeDefInfo.Int: (TypeDef typeDef) => encodeUInt(typeDef, 'Int'),
  TypeDefInfo.Linkage: (TypeDef typeDef) => encodeWithParams(typeDef, 'Linkage'),
  TypeDefInfo.Null: (TypeDef typeDef) => 'Null',
  TypeDefInfo.Option: (TypeDef typeDef) => encodeWithParams(typeDef, 'Option'),
  TypeDefInfo.Plain: (TypeDef typeDef) => typeDef.displayName ?? typeDef.type,
  TypeDefInfo.Result: (TypeDef typeDef) => encodeWithParams(typeDef, 'Result'),
  TypeDefInfo.Set: (TypeDef typeDef) => typeDef.type,
  TypeDefInfo.Struct: (TypeDef typeDef) => encodeStruct(typeDef),
  TypeDefInfo.Tuple: (TypeDef typeDef) => encodeTuple(typeDef),
  TypeDefInfo.UInt: (TypeDef typeDef) => encodeUInt(typeDef, 'UInt'),
  TypeDefInfo.Vec: (TypeDef typeDef) => encodeWithParams(typeDef, 'Vec'),
  TypeDefInfo.VecFixed: (TypeDef typeDef) => encodeVecFixed(typeDef)
};

String encodeType(TypeDef typeDef) {
  final encoder = encoders[typeDef.info];

  assert(encoder != null, "Cannot encode type: ${jsonEncode(typeDef)}");

  return encoder(typeDef);
}

String encodeTypeDef(TypeDef typeDef) {
  assert((typeDef.info != null),
      "Invalid type definition with no instance info, ${jsonEncode(typeDef)}");

  // In the case of contracts we do have the unfortunate situation where the displayName would
  // refer to "Option" when it is an option. For these, string it out, only using when actually
  // not a top-level element to be used
  if (typeDef.displayName != null && !INFO_WRAP.any((i) => typeDef.displayName == i)) {
    return typeDef.displayName;
  }

  return encodeType(typeDef);
}

TypeDef withTypeString(TypeDef typeDef) {
  var map = {...(typeDef.toMap()), "type": encodeType(typeDef)};
  return TypeDef.fromMap(map);
}
