// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// SiField
class SiField extends Struct {
  Option<CodecText> get name =>
      super.getCodec("name").cast<Option<CodecText>>();

  SiLookupTypeId get type => super.getCodec("type").cast<SiLookupTypeId>();

  SiField(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"name": "Option<Text>", "type": "SiLookupTypeId"},
            value, jsonMap);

  factory SiField.from(Struct origin) =>
      SiField(origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiLookupTypeId
class SiLookupTypeId extends u32 {
  SiLookupTypeId(Registry registry, [dynamic value]) : super(registry, value);

  factory SiLookupTypeId.from(u32 origin) =>
      SiLookupTypeId(origin.registry, origin.originValue);
}

/// SiPath
class SiPath extends Vec<CodecText> {
  SiPath(Registry registry, dynamic type, [dynamic value])
      : super(registry, type, value);

  factory SiPath.from(Vec origin) =>
      SiPath(origin.registry, origin.originType, origin.originValue);
}

/// SiType
class SiType extends Struct {
  SiPath get path => super.getCodec("path").cast<SiPath>();

  Vec<SiLookupTypeId> get params =>
      super.getCodec("params").cast<Vec<SiLookupTypeId>>();

  SiTypeDef get def => super.getCodec("def").cast<SiTypeDef>();

  SiType(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "path": "SiPath",
              "params": "Vec<SiLookupTypeId>",
              "def": "SiTypeDef"
            },
            value,
            jsonMap);

  factory SiType.from(Struct origin) =>
      SiType(origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiTypeDef
class SiTypeDef extends Enum {
  bool get isComposite => super.isKey("Composite");

  SiTypeDefComposite get asComposite =>
      super.askey("Composite").cast<SiTypeDefComposite>();

  bool get isVariant => super.isKey("Variant");

  SiTypeDefVariant get asVariant =>
      super.askey("Variant").cast<SiTypeDefVariant>();

  bool get isSequence => super.isKey("Sequence");

  SiTypeDefSequence get asSequence =>
      super.askey("Sequence").cast<SiTypeDefSequence>();

  bool get isArray => super.isKey("Array");

  SiTypeDefArray get asArray => super.askey("Array").cast<SiTypeDefArray>();

  bool get isTuple => super.isKey("Tuple");

  SiTypeDefTuple get asTuple => super.askey("Tuple").cast<SiTypeDefTuple>();

  bool get isPrimitive => super.isKey("Primitive");

  SiTypeDefPrimitive get asPrimitive =>
      super.askey("Primitive").cast<SiTypeDefPrimitive>();

  SiTypeDef(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Composite": "SiTypeDefComposite",
              "Variant": "SiTypeDefVariant",
              "Sequence": "SiTypeDefSequence",
              "Array": "SiTypeDefArray",
              "Tuple": "SiTypeDefTuple",
              "Primitive": "SiTypeDefPrimitive"
            },
            value,
            index);

  factory SiTypeDef.from(Enum origin) =>
      SiTypeDef(origin.registry, origin.originValue, origin.originIndex);
}

/// SiTypeDefArray
class SiTypeDefArray extends Struct {
  u16 get len => super.getCodec("len").cast<u16>();

  SiLookupTypeId get type => super.getCodec("type").cast<SiLookupTypeId>();

  SiTypeDefArray(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry, {"len": "u16", "type": "SiLookupTypeId"}, value, jsonMap);

  factory SiTypeDefArray.from(Struct origin) =>
      SiTypeDefArray(origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiTypeDefComposite
class SiTypeDefComposite extends Struct {
  Vec<SiField> get fields => super.getCodec("fields").cast<Vec<SiField>>();

  SiTypeDefComposite(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"fields": "Vec<SiField>"}, value, jsonMap);

  factory SiTypeDefComposite.from(Struct origin) => SiTypeDefComposite(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiTypeDefVariant
class SiTypeDefVariant extends Struct {
  Vec<SiVariant> get variants =>
      super.getCodec("variants").cast<Vec<SiVariant>>();

  SiTypeDefVariant(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"variants": "Vec<SiVariant>"}, value, jsonMap);

  factory SiTypeDefVariant.from(Struct origin) => SiTypeDefVariant(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiTypeDefPrimitive
class SiTypeDefPrimitive extends Enum {
  bool get isBool => super.isKey("Bool");

  bool get isChar => super.isKey("Char");

  bool get isStr => super.isKey("Str");

  bool get isU8 => super.isKey("U8");

  bool get isU16 => super.isKey("U16");

  bool get isU32 => super.isKey("U32");

  bool get isU64 => super.isKey("U64");

  bool get isU128 => super.isKey("U128");

  bool get isU256 => super.isKey("U256");

  bool get isI8 => super.isKey("I8");

  bool get isI16 => super.isKey("I16");

  bool get isI32 => super.isKey("I32");

  bool get isI64 => super.isKey("I64");

  bool get isI128 => super.isKey("I128");

  bool get isI256 => super.isKey("I256");

  SiTypeDefPrimitive(Registry registry, [dynamic value, int index])
      : super(
            registry,
            [
              "Bool",
              "Char",
              "Str",
              "U8",
              "U16",
              "U32",
              "U64",
              "U128",
              "U256",
              "I8",
              "I16",
              "I32",
              "I64",
              "I128",
              "I256"
            ],
            value,
            index);

  factory SiTypeDefPrimitive.from(Enum origin) => SiTypeDefPrimitive(
      origin.registry, origin.originValue, origin.originIndex);
}

/// SiTypeDefSequence
class SiTypeDefSequence extends Struct {
  SiLookupTypeId get type => super.getCodec("type").cast<SiLookupTypeId>();

  SiTypeDefSequence(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"type": "SiLookupTypeId"}, value, jsonMap);

  factory SiTypeDefSequence.from(Struct origin) => SiTypeDefSequence(
      origin.registry, origin.originValue, origin.originJsonMap);
}

/// SiTypeDefTuple
class SiTypeDefTuple extends Vec<SiLookupTypeId> {
  SiTypeDefTuple(Registry registry, dynamic type, [dynamic value])
      : super(registry, type, value);

  factory SiTypeDefTuple.from(Vec origin) =>
      SiTypeDefTuple(origin.registry, origin.originType, origin.originValue);
}

/// SiVariant
class SiVariant extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<SiField> get fields => super.getCodec("fields").cast<Vec<SiField>>();

  Option<u64> get discriminant =>
      super.getCodec("discriminant").cast<Option<u64>>();

  SiVariant(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "name": "Text",
              "fields": "Vec<SiField>",
              "discriminant": "Option<u64>"
            },
            value,
            jsonMap);

  factory SiVariant.from(Struct origin) =>
      SiVariant(origin.registry, origin.originValue, origin.originJsonMap);
}
