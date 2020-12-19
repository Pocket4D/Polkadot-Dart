import 'package:type_gen/formatter.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/string.dart';

String getKeyClassExtendTypes(Registry registry, String classKey, String classExtends) {
  // final type = registry.createType(classExtends);
  // print("type.toRawType():${type.toRawType()}");
  // print("type.runtimeType :${type.runtimeType}");
  // print("getClassByType(registry, classExtends) :${getClassByType(registry, classExtends)}");
  // print(classExtends);

  switch (classExtends) {
    default:
      return "$classKey";
  }
}

String getKeyClassConstructor(Registry registry, String classKey, String classExtends,
    dynamic preset, String originClassExtends,
    [String rawClassExtends]) {
  final formatted = classExtends.split("<").first;
  final actualFrom = originClassExtends == formatted ? formatted : originClassExtends;

  switch (getClassByType(registry, formatted)) {
    case "Struct":
      if (actualFrom == "Struct") {
        return '''
      $classKey(Registry registry, [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, $preset, value, jsonMap);
      ''';
      }
      return '''
      $classKey(Registry registry, [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, value, jsonMap);
      ''';

    case "UInt":
      var bitLength = (registry.createType(classKey) as UInt).bitLength;
      return '''
      $classKey(Registry registry, [dynamic value = 0, int bitLength = $bitLength])
      : super(registry, value ?? 0, bitLength ?? $bitLength){
        this.setRawType("$classKey");
      }
      ''';
    case "Result":
      return '''
      $classKey(Registry registry, dynamic ok, dynamic error, [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);
      ''';
    case "Enum":
      if (actualFrom == "Enum") {
        return '''
      $classKey(Registry registry, [dynamic value, int index]): super(registry, $preset, value, index);
      ''';
      }
      return '''
      $classKey(Registry registry, [dynamic value, int index]): super(registry, value, index);
      ''';
    case "U8aFixed":
      var bitLength = (registry.createType(classKey) as U8aFixed).bitLength;
      return '''
      $classKey(Registry registry, [dynamic value, int bitLength = $bitLength, String typeName = "$classKey"])
      : super(registry, value, bitLength ?? $bitLength , typeName ?? "$classKey");
      ''';

    case "Vec":
      return '''
      $classKey(Registry registry, dynamic type, [dynamic value])
      : super(registry, type, value);
      ''';
    case "CodecSet":
      if (actualFrom == "CodecSet") {
        return '''
      $classKey(Registry registry, [dynamic value, int bitLength = 8]) :super(registry, $preset, value, bitLength);
      ''';
      }
      return '''
      $classKey(Registry registry, [dynamic value, int bitLength = 8]) :super(registry, value, bitLength);
      ''';
    case "StorageKey":
      return '''
      $classKey(Registry registry, [dynamic value, StorageKeyExtra override])
      :super(registry, value, override);
      ''';
    default:
      return '''
      $classKey(Registry registry, [dynamic value])
      : super(registry, value);
      ''';
  }
}

String getKeyClassFactory(
    Registry registry, String classKey, String classExtends, String originClassExtends) {
  final formatted = classExtends.split("<").first;
  final actualFrom = originClassExtends == formatted ? formatted : originClassExtends;
  // print(getClassByType(registry, formatted));
  switch (getClassByType(registry, formatted)) {
    case "Struct":
      return '''
      factory $classKey.from(Struct origin) =>
      $classKey(origin.registry, origin.originValue, origin.originJsonMap);
      ''';
    case "UInt":
      return '''
      factory $classKey.from(UInt origin) =>
      $classKey(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
      ''';
    case "Enum":
      return '''
      factory $classKey.from(Enum origin) =>
      $classKey(origin.registry, origin.originValue, origin.originIndex);
      ''';
    case "U8aFixed":
      return '''
      factory $classKey.from(U8aFixed origin) =>
      $classKey(origin.registry, origin.value, origin.bitLength, origin.typeName);
      ''';
    case "Vec":
      return '''
      factory $classKey.from(Vec origin) =>
      $classKey(origin.registry, origin.originType, origin.originValue);
      ''';
    case "StorageKey":
      return '''
      factory $classKey.from(StorageKey origin) =>
      $classKey(origin.registry, origin.originValue, origin.originOverride);
      ''';
    case "CodecSet":
      return '''
      factory $classKey.from(CodecSet origin) =>
      $classKey(origin.registry, origin.originValue, origin.originBitLength);
      ''';
    // case "Bytes":
    //   return '''

    //   ''';
    case "Result":
      return '''''';
    default:
      return '''
      factory $classKey.from($actualFrom origin) =>
      $classKey(origin.registry, origin.originValue);
      ''';
  }
}

String getKeyClassGetters(
    Registry registry, String classKey, String classExtends, Map<String, dynamic> getters) {
  if (getters.isEmpty || getters == null) {
    return '';
  }

  switch (classExtends) {
    case "Struct":
      return getters.entries
          .map((entry) {
            var rawString = entry.value.toString();

            // if (getClassByType(registry, rawString).startsWith("ITuple")) {
            //   rawString = getClassByType(registry, rawString);
            // }
            rawString = getClassByType(registry, rawString);
            var toCast = !rawString.contains("CodecText")
                ? rawString.replaceAll("Text", "CodecText")
                : rawString;
            var toCastEnd = toCast;
            switch (toCast) {
              case 'bool':
                toCastEnd = "CodecBool";
                break;
              case 'Bool':
                toCastEnd = "CodecBool";
                break;
              case 'null':
                toCast = "CodecNull";
                toCastEnd = toCast;
                break;
              case 'Null':
                toCast = "CodecNull";
                toCastEnd = toCast;
                break;
            }

            var theKey = entry.key;
            // theKey = stringUpperFirst(stringCamelCase(theKey.replaceAll(' ', '_')));
            var theKeyFront = theKey;

            theKeyFront = stringCamelCase(avoidReservedWords(theKey).replaceAll(' ', '_'));

            var rest = toCastEnd == "CodecBool" ? ".value" : "";

            return '''
        $toCast get $theKeyFront => super.getCodec("$theKey").cast<$toCastEnd>()$rest;
        ''';
          })
          .toList()
          .join("\n");
    case "Enum":
      return getters.entries
          .map((entry) {
            var rawString = entry.value.toString();
            // if (getClassByType(registry, rawString).startsWith("ITuple")) {
            //   rawString = getClassByType(registry, rawString);
            // }

            rawString = getClassByType(registry, rawString);
            var toCast = !rawString.contains("CodecText")
                ? rawString.replaceAll("Text", "CodecText")
                : rawString;

            var theKey = entry.key;
            theKey =
                stringUpperFirst(stringCamelCase(avoidReservedWords(theKey).replaceAll(' ', '_')));
            var rest = ".cast<$toCast>()";

            if (toCast == "Null") {
              return '''
              bool get is$theKey => super.isKey("$theKey");
              ''';
            } else {
              return '''
              bool get is$theKey => super.isKey("$theKey");

              $toCast get as$theKey => super.askey("$theKey")$rest;
              ''';
            }
          })
          .toList()
          .join("\n");
    case "CodecSet":
      return getters.entries
          .map((entry) {
            var rawString = entry.value.toString();
            // if (getClassByType(registry, rawString).startsWith("ITuple")) {
            //   rawString = getClassByType(registry, rawString);
            // }
            rawString = getClassByType(registry, rawString);

            var toCast = !rawString.contains("CodecText")
                ? rawString.replaceAll("Text", "CodecText")
                : rawString;

            var getterType = "as";
            var getterTypeString = "askey";
            switch (toCast) {
              case 'Null':
                toCast = "bool";
                getterType = "is";
                getterTypeString = "isKey";
                break;
              default:
                getterType = "as";
                getterTypeString = "askey";
            }
            var theKey = entry.key;
            var frontKey =
                stringUpperFirst(stringCamelCase(avoidReservedWords(theKey).replaceAll(' ', '_')));

            var rest = toCast == "bool" ? "" : ".cast<$toCast>()";
            return '''
        $toCast get $getterType$frontKey => super.$getterTypeString("$theKey")$rest;
        ''';
          })
          .toList()
          .join("\n");
    default:
      return '';
  }
}

String getClassExtends(Registry registry, String rtType) {
  if (rtType.startsWith("Struct")) {
    return "Struct";
  } else if (rtType.startsWith("Enum")) {
    return "Enum";
  } else {
    return rtType;
  }
}

String avoidReservedWords(String word) {
  bool add = true;
  switch (word) {
    case 'bool':
      break;
    case 'get':
      break;
    case 'value':
      break;
    case 'hash':
      break;
    case 'return':
      break;
    case 'class':
      break;
    case 'String':
      break;
    case 'int':
      break;
    case 'double':
      break;
    default:
      add = false;
      break;
  }
  if (add) {
    return "this${stringUpperFirst(word)}";
  }
  return word;
}

String getClassByType(Registry registry, String value) {
  var def = getTypeDef(value);
  var defInfo = def.info;
  print(def.toMap());

  switch (defInfo) {
    case TypeDefInfo.BTreeMap:
      return formatBTreeMap(
          getClassByType(
              registry, def.sub[0] is TypeDef ? def.sub[0].type : TypeDef.fromMap(def.sub[0]).type),
          getClassByType(registry,
              def.sub[1] is TypeDef ? def.sub[1].type : TypeDef.fromMap(def.sub[1]).type));
    case TypeDefInfo.BTreeSet:
      return formatBTreeSet(getClassByType(registry, def.sub));

    case TypeDefInfo.Compact:
      return formatCompact(getClassByType(
          registry, def.sub is TypeDef ? def.sub.type : TypeDef.fromMap(def.sub).type));

    case TypeDefInfo.Enum:
      return "Enum";
    case TypeDefInfo.Linkage:
      final type = def.sub is TypeDef ? def.sub.type : TypeDef.fromMap(def.sub).type;
      return formatLinkage(getClassByType(registry, type));
    case TypeDefInfo.Option:
      return formatOption(getClassByType(
          registry, def.sub is TypeDef ? def.sub.type : TypeDef.fromMap(def.sub).type));

    case TypeDefInfo.Plain:
      return def.type;

    case TypeDefInfo.Result:
      final listSub = (def.sub);

      if (listSub is List) {
        final okDef = listSub[0] is TypeDef ? listSub[0] : TypeDef.fromMap(listSub[0]);
        final errorDef = listSub[1] is TypeDef ? listSub[1] : TypeDef.fromMap(listSub[1]);
        return formatResult(
            getClassByType(registry, okDef.type), getClassByType(registry, errorDef.type));
      }
      break;

    case TypeDefInfo.Set:
      return "CodecSet";

    case TypeDefInfo.Struct:
      return "Struct";

    case TypeDefInfo.Tuple:
      return formatTuple((def.sub as List).map((sub) {
        return getClassByType(registry, (TypeDef.fromMap(sub)).type);
      }).toList());
      break;
    case TypeDefInfo.Vec:
      return formatVec(getClassByType(
          registry, def.sub is TypeDef ? def.sub.type : TypeDef.fromMap(def.sub).type));

    case TypeDefInfo.VecFixed:
      final type = def.sub is TypeDef ? def.sub.type : TypeDef.fromMap(def.sub).type;

      if (type == 'u8') {
        return 'U8aFixed';
      }
      return formatVec(getClassByType(registry, type));

    case TypeDefInfo.HashMap:
      final listSub = (def.sub);
      if (listSub is List) {
        final keyDef = listSub[0] is TypeDef ? listSub[0] as TypeDef : TypeDef.fromMap(listSub[0]);
        final valDef = listSub[1] is TypeDef ? listSub[1] as TypeDef : TypeDef.fromMap(listSub[1]);
        return formatHashMap(
            getClassByType(registry, keyDef.type), getClassByType(registry, valDef.type));
      }
      break;

    case TypeDefInfo.Int:
      return "CodecInt";
    case TypeDefInfo.UInt:
      return "Uint";

    case TypeDefInfo.DoNotConstruct:
      return formatDoNoConstruct();

    case TypeDefInfo.Null:
      return "CodecNull";
  }
}
