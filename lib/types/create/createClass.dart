// An unsafe version of the `createType` below. It's unsafe because the `type`
// argument here can be any string, which, if it cannot be parsed, it will yield
// a runtime error.
// ClassOfUnsafe<T extends BaseCodec, K extends string = string> (registry: Registry, name: K): Constructor<FromReg<T, K>> {
//   return createClass<T, K>(registry, name);
// }

// // alias for createClass
// ClassOf<K extends keyof InterfaceTypes> (registry: Registry, name: K): Constructor<InterfaceTypes[K]> {
//   // TS2589: Type instantiation is excessively deep and possibly infinite.
//   // The above happens with as Constructor<InterfaceTypes[K]>;
//   // eslint-disable-next-line @typescript-eslint/no-unsafe-return
//   return ClassOfUnsafe<BaseCodec, K>(registry, name) as any;
// }

import 'dart:convert';

import 'package:polkadot_dart/types/create/getTypeDef.dart';
import 'package:polkadot_dart/types/create/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/utils/utils.dart';

Constructor<T> createClass<T extends BaseCodec>(Registry registry, String type,
    [TypeDefOptions options]) {
  // eslint-disable-next-line @typescript-eslint/no-use-before-define

  final typeDefResult = getTypeDef(type, options);

  final result = getTypeClass<T>(registry, typeDefResult);

  return result;
}

// ignore: non_constant_identifier_names
Constructor<T> ClassOf<T extends BaseCodec>(Registry registry, String type,
    [TypeDefOptions options]) {
  return createClass(registry, type, options);
}

List<TypeDef> getSubDefArray(TypeDef value) {
  assert(value.sub != null && (value.sub is List),
      "Expected subtype as TypeDef[] in ${jsonEncode(value)}");
  var sub = value.sub;
  List<TypeDef> result;
  if (sub is List) {
    result = List<TypeDef>.from(sub.map((element) {
      if (element is TypeDef) {
        return element;
      }
      return TypeDef.fromMap(element);
    }));
  }
  return result;
}

TypeDef getSubDef(TypeDef value) {
  assert(value.sub != null && !(value.sub is List),
      "Expected subtype as TypeDef in ${jsonEncode(value)}");
  return value.sub as TypeDef;
}

String getSubType(TypeDef value) {
  return getSubDef(value).type;
}

// create a maps of type string constructors from the input
Map<String, String> getTypeClassMap(TypeDef value) {
  final Map<String, String> result = {};
  return getSubDefArray(value).fold(result, (result, sub) {
    result[sub.name] = sub.type;
    return result;
  });
}

// create an array of type string constructors from the input
List<String> getTypeClassArray(TypeDef value) {
  return getSubDefArray(value).map((def) => def.type).toList();
}

Constructor createInt<T>(TypeDef def, dynamic clazz) {
  assert(isNumber(def.length), "Expected bitLength information for ${def.displayName}<bitLength>");
  if (clazz.toString().startsWith("UInt")) {
    return UInt.withParams(def.length, def.displayName);
  } else if (clazz.toString().startsWith("CodecInt")) {
    return CodecInt.withParams(def.length, def.displayName);
  } else {
    throw "Cannot create Int";
  }
}

Constructor createHashMap<T>(TypeDef value, dynamic clazz) {
  final arr = getTypeClassArray(value);
  var keyType = arr[0];
  var valueType = arr[1];

  if (clazz.toString().startsWith("BTreeMap")) {
    return BTreeMap.withParams(keyType, valueType);
  } else if (clazz.toString().startsWith("HashMap")) {
    return HashMap.withParams(keyType, valueType);
  } else {
    throw "Cannot create HashMap";
  }
}

final Map<TypeDefInfo, Constructor Function(Registry registry, TypeDef value)> infoMapping = {
  TypeDefInfo.BTreeMap: (Registry registry, TypeDef value) => createHashMap(value, BTreeMap),

  TypeDefInfo.BTreeSet: (Registry registry, TypeDef value) =>
      BTreeSet.withParams(getSubType(value)),

  TypeDefInfo.Compact: (Registry registry, TypeDef value) => Compact.withParams(getSubType(value)),

  TypeDefInfo.DoNotConstruct: (Registry registry, TypeDef value) =>
      DoNotConstruct.withParams(value.displayName),

  TypeDefInfo.Enum: (Registry registry, TypeDef value) => Enum.withParams(getTypeClassMap(value)),

  TypeDefInfo.HashMap: (Registry registry, TypeDef value) => createHashMap(value, HashMap),

  TypeDefInfo.Int: (Registry registry, TypeDef value) => createInt(value, CodecInt),

  // We have circular deps between Linkage & Struct
  TypeDefInfo.Linkage: (Registry registry, TypeDef value) {
    final type = "Option<${getSubType(value)}>";
    // TODO: use Linkage.withParams instead
    final clazz = Linkage.linkWith(type);

    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    // Clazz.prototype.toRawType = function (): string {
    //   // eslint-disable-next-line @typescript-eslint/restrict-template-expressions,@typescript-eslint/no-unsafe-member-access,@typescript-eslint/no-unsafe-call
    //   return `Linkage<${this.next.toRawType(true)}>`;
    // };

    return clazz;
  },

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  TypeDefInfo.Null: (Registry registry, TypeDef _) => createClass(registry, 'Null'),

  TypeDefInfo.Option: (Registry registry, TypeDef value) => Option.withParams(getSubType(value)),

  TypeDefInfo.Plain: (Registry registry, TypeDef value) => registry.getOrUnknown(value.type),

  TypeDefInfo.Result: (Registry registry, TypeDef value) {
    final classArray = getTypeClassArray(value);

    // eslint-disable-next-line @typescript-eslint/no-use-before-define
    return Result.withParams({"Error": classArray[1], "Ok": classArray[0]});
  },

  TypeDefInfo.Set: (Registry registry, TypeDef value) {
    Map<String, int> initResult = {};
    return CodecSet.withParams(
        getSubDefArray(value).fold(initResult, (result, def) {
          result[def.name] = def.index;

          return result;
        }),
        value.length);
  },

  TypeDefInfo.Struct: (Registry registry, TypeDef value) =>
      Struct.withParams(getTypeClassMap(value), value.alias),

  TypeDefInfo.Tuple: (Registry registry, TypeDef value) =>
      Tuple.withParams(getTypeClassArray(value)),

  TypeDefInfo.UInt: (Registry registry, TypeDef value) => createInt(value, UInt),

  TypeDefInfo.Vec: (Registry registry, TypeDef value) {
    final subType = getSubType(value);

    return (subType == 'u8' ? createClass(registry, 'Bytes') : Vec.withParams(subType));
  },

  TypeDefInfo.VecFixed: (Registry registry, TypeDef value) {
    assert(isNumber(value.length) && (value.sub != null),
        'Expected length & type information for fixed vector');

    return ((value.sub as TypeDef).type == 'u8'
        ? U8aFixed.withParams((value.length * 8), value.displayName)
        : VecFixed.withParams((value.sub as TypeDef).type, value.length));
  }
};

Constructor<T> getTypeClass<T extends BaseCodec>(Registry registry, TypeDef value) {
  final theType = registry.getConstructor(value.type);

  if (theType != null) {
    return theType;
  }

  final getFn = infoMapping[value.info];

  assert(getFn != null, "Unable to construct class from ${jsonEncode(value)}");

  return getFn(registry, value) as Constructor<T>;
}
