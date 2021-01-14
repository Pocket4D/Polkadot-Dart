import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/types/types/types.dart';

// /** @name DoubleMapTypeLatest */
class DoubleMapTypeLatest extends DoubleMapTypeV12 {
  DoubleMapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  DoubleMapTypeLatest.empty() : super.empty();
  static DoubleMapTypeLatest transform(Struct origin) => DoubleMapTypeLatest.from(origin);
  factory DoubleMapTypeLatest.from(Struct origin) {
    // DoubleMapTypeLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return DoubleMapTypeLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

class DoubleMapTypeV10<S extends Map<String, dynamic>> extends Struct implements DoubleMap {
  StorageHasherV10 get hasher => StorageHasherV10.from(super.getCodec("hasher"));
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV10 get key2Hasher => StorageHasherV10.from(super.getCodec("key2Hasher"));

  DoubleMapTypeV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  DoubleMapTypeV10.empty() : super.empty();
  static DoubleMapTypeV10 transform(Struct origin) => DoubleMapTypeV10.from(origin);
  factory DoubleMapTypeV10.from(Struct origin) {
    // DoubleMapTypeV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return DoubleMapTypeV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name DoubleMapTypeV11 */
class DoubleMapTypeV11<S extends Map<String, dynamic>> extends Struct implements DoubleMap {
  StorageHasherV11 get hasher => StorageHasherV11.from(super.getCodec("hasher"));
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV11 get key2Hasher => StorageHasherV11.from(super.getCodec("key2Hasher"));

  DoubleMapTypeV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  DoubleMapTypeV11.empty() : super.empty();
  static DoubleMapTypeV11 transform(Struct origin) => DoubleMapTypeV11.from(origin);
  factory DoubleMapTypeV11.from(Struct origin) {
    // DoubleMapTypeV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return DoubleMapTypeV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name DoubleMapTypeV12 */
class DoubleMapTypeV12 extends DoubleMapTypeV11 {
  StorageHasherV12 get hasher => StorageHasherV12.from(super.getCodec("hasher"));
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV12 get key2Hasher => StorageHasherV12.from(super.getCodec("key2Hasher"));
  DoubleMapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  DoubleMapTypeV12.empty() : super.empty();
  static DoubleMapTypeV12 transform(Struct origin) => DoubleMapTypeV12.from(origin);
  factory DoubleMapTypeV12.from(Struct origin) {
    // DoubleMapTypeV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return DoubleMapTypeV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name DoubleMapTypeV9 */
class DoubleMapTypeV9<S extends Map<String, dynamic>> extends Struct implements DoubleMap {
  StorageHasherV9 get hasher => StorageHasherV9.from(super.getCodec("hasher"));
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV9 get key2Hasher => StorageHasherV9.from(super.getCodec("key2Hasher"));

  DoubleMapTypeV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  DoubleMapTypeV9.empty() : super.empty();
  static DoubleMapTypeV9 transform(Struct origin) => DoubleMapTypeV9.from(origin);
  factory DoubleMapTypeV9.from(Struct origin) {
    // DoubleMapTypeV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return DoubleMapTypeV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ErrorMetadataV10 */
class ErrorMetadataV10 extends ErrorMetadataV9 {
  ErrorMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ErrorMetadataV10.empty() : super.empty();
  static ErrorMetadataV10 transform(Struct origin) => ErrorMetadataV10.from(origin);
  factory ErrorMetadataV10.from(Struct origin) {
    // ErrorMetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ErrorMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ErrorMetadataV11 */
class ErrorMetadataV11 extends ErrorMetadataV10 {
  ErrorMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ErrorMetadataV11.empty() : super.empty();
  static ErrorMetadataV11 transform(Struct origin) => ErrorMetadataV11.from(origin);
  factory ErrorMetadataV11.from(Struct origin) {
    // ErrorMetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ErrorMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ErrorMetadataV12 */
class ErrorMetadataV12 extends ErrorMetadataV11 {
  ErrorMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ErrorMetadataV12.empty() : super.empty();
  static ErrorMetadataV12 transform(Struct origin) => ErrorMetadataV12.from(origin);
  factory ErrorMetadataV12.from(Struct origin) {
    // ErrorMetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ErrorMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

class ErrorMetadataLatest extends ErrorMetadataV12 {
  ErrorMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ErrorMetadataLatest.empty() : super.empty();
  static ErrorMetadataLatest transform(Struct origin) => ErrorMetadataLatest.from(origin);
  factory ErrorMetadataLatest.from(Struct origin) {
    // ErrorMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ErrorMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ErrorMetadataV9 */
class ErrorMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  ErrorMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  ErrorMetadataV9.empty() : super.empty();
  static ErrorMetadataV9 transform(Struct origin) => ErrorMetadataV9.from(origin);
  factory ErrorMetadataV9.from(Struct origin) {
    // ErrorMetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ErrorMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name EventMetadataLatest */
class EventMetadataLatest extends EventMetadataV12 {
  EventMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  EventMetadataLatest.empty() : super.empty();
  static EventMetadataLatest transform(Struct origin) => EventMetadataLatest.from(origin);
  factory EventMetadataLatest.from(Struct origin) {
    // EventMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return EventMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name EventMetadataV10 */
class EventMetadataV10 extends EventMetadataV9 {
  EventMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  EventMetadataV10.empty() : super.empty();
  static EventMetadataV10 transform(Struct origin) => EventMetadataV10.from(origin);
  factory EventMetadataV10.from(Struct origin) {
    // EventMetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return EventMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name EventMetadataV11 */
class EventMetadataV11 extends EventMetadataV10 {
  EventMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  EventMetadataV11.empty() : super.empty();
  static EventMetadataV11 transform(Struct origin) => EventMetadataV11.from(origin);
  factory EventMetadataV11.from(Struct origin) {
    // EventMetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return EventMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name EventMetadataV12 */
class EventMetadataV12 extends EventMetadataV11 {
  EventMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  EventMetadataV12.empty() : super.empty();
  static EventMetadataV12 transform(Struct origin) => EventMetadataV12.from(origin);
  factory EventMetadataV12.from(Struct origin) {
    // EventMetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return EventMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name EventMetadataV9 */
class EventMetadataV9<S extends Map<String, dynamic>> extends Struct implements Event {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<CodecType> get args =>
      Vec.withTransformer((super.getCodec("args") as Vec), CodecType.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  EventMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  EventMetadataV9.empty() : super.empty();
  static EventMetadataV9 transform(Struct origin) => EventMetadataV9.from(origin);
  factory EventMetadataV9.from(Struct origin) {
    // EventMetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return EventMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ExtrinsicMetadataLatest */
class ExtrinsicMetadataLatest extends ExtrinsicMetadataV12 {
  ExtrinsicMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ExtrinsicMetadataLatest.empty() : super.empty();
  static ExtrinsicMetadataLatest transform(Struct origin) => ExtrinsicMetadataLatest.from(origin);
  factory ExtrinsicMetadataLatest.from(Struct origin) {
    // ExtrinsicMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ExtrinsicMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ExtrinsicMetadataV11 */
class ExtrinsicMetadataV11<S extends Map<String, dynamic>> extends Struct {
  u8 get version => super.getCodec("version").cast<u8>();

  Vec<CodecText> get signedExtensions =>
      Vec.withTransformer((super.getCodec("signedExtensions") as Vec), CodecText.transform);

  ExtrinsicMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  ExtrinsicMetadataV11.empty() : super.empty();
  static ExtrinsicMetadataV11 transform(Struct origin) => ExtrinsicMetadataV11.from(origin);
  factory ExtrinsicMetadataV11.from(Struct origin) {
    // ExtrinsicMetadataV11(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ExtrinsicMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ExtrinsicMetadataV12 */
class ExtrinsicMetadataV12 extends ExtrinsicMetadataV11 {
  ExtrinsicMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ExtrinsicMetadataV12.empty() : super.empty();
  static ExtrinsicMetadataV12 transform(Struct origin) => ExtrinsicMetadataV12.from(origin);
  factory ExtrinsicMetadataV12.from(Struct origin) {
    // ExtrinsicMetadataV12(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ExtrinsicMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionArgumentMetadataLatest */
class FunctionArgumentMetadataLatest extends FunctionArgumentMetadataV12 {
  FunctionArgumentMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionArgumentMetadataLatest.empty() : super.empty();
  static FunctionArgumentMetadataLatest transform(Struct origin) =>
      FunctionArgumentMetadataLatest.from(origin);
  factory FunctionArgumentMetadataLatest.from(Struct origin) {
    // FunctionArgumentMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionArgumentMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionArgumentMetadataV10 */
class FunctionArgumentMetadataV10 extends FunctionArgumentMetadataV9 {
  FunctionArgumentMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionArgumentMetadataV10.empty() : super.empty();
  static FunctionArgumentMetadataV10 transform(Struct origin) =>
      FunctionArgumentMetadataV10.from(origin);
  factory FunctionArgumentMetadataV10.from(Struct origin) {
    // FunctionArgumentMetadataV10(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionArgumentMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionArgumentMetadataV11 */
class FunctionArgumentMetadataV11 extends FunctionArgumentMetadataV10 {
  FunctionArgumentMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionArgumentMetadataV11.empty() : super.empty();
  static FunctionArgumentMetadataV11 transform(Struct origin) =>
      FunctionArgumentMetadataV11.from(origin);
  factory FunctionArgumentMetadataV11.from(Struct origin) {
    // FunctionArgumentMetadataV11(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionArgumentMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionArgumentMetadataV12 */
class FunctionArgumentMetadataV12 extends FunctionArgumentMetadataV11 {
  FunctionArgumentMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionArgumentMetadataV12.empty() : super.empty();
  static FunctionArgumentMetadataV12 transform(Struct origin) =>
      FunctionArgumentMetadataV12.from(origin);
  factory FunctionArgumentMetadataV12.from(Struct origin) {
    // FunctionArgumentMetadataV12(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionArgumentMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionArgumentMetadataV9 */
class FunctionArgumentMetadataV9<S extends Map<String, dynamic>> extends Struct implements Arg {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  CodecType get type => super.getCodec("type").cast<CodecText>();

  FunctionArgumentMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  FunctionArgumentMetadataV9.empty() : super.empty();
  static FunctionArgumentMetadataV9 transform(Struct origin) =>
      FunctionArgumentMetadataV9.from(origin);
  factory FunctionArgumentMetadataV9.from(Struct origin) {
    // FunctionArgumentMetadataV9(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionArgumentMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionMetadataLatest */
class FunctionMetadataLatest extends FunctionMetadataV12 {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<FunctionArgumentMetadataLatest> get args => Vec.withTransformer(
      (super.getCodec("args") as Vec), FunctionArgumentMetadataLatest.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  FunctionMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionMetadataLatest.empty() : super.empty();
  static FunctionMetadataLatest transform(Struct origin) => FunctionMetadataLatest.from(origin);
  factory FunctionMetadataLatest.from(Struct origin) {
    // FunctionMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
  factory FunctionMetadataLatest.create(
    Registry registry,
    Map<String, dynamic> types,
  ) {
    return FunctionMetadataLatest.from(registry.createType("FunctionMetadataLatest", types));
  }
}

/// @name FunctionMetadataV10 */
class FunctionMetadataV10 extends FunctionMetadataV9 {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<FunctionArgumentMetadataV10> get args =>
      Vec.withTransformer((super.getCodec("args") as Vec), FunctionArgumentMetadataV10.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  FunctionMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionMetadataV10.empty() : super.empty();
  static FunctionMetadataV10 transform(Struct origin) => FunctionMetadataV10.from(origin);
  factory FunctionMetadataV10.from(Struct origin) {
    // FunctionMetadataV10(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionMetadataV11 */
class FunctionMetadataV11 extends FunctionMetadataV10 {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<FunctionArgumentMetadataV11> get args =>
      Vec.withTransformer((super.getCodec("args") as Vec), FunctionArgumentMetadataV11.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  FunctionMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionMetadataV11.empty() : super.empty();
  static FunctionMetadataV11 transform(Struct origin) => FunctionMetadataV11.from(origin);
  factory FunctionMetadataV11.from(Struct origin) {
    // FunctionMetadataV11(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionMetadataV12 */
class FunctionMetadataV12 extends FunctionMetadataV11 {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<FunctionArgumentMetadataV12> get args =>
      Vec.withTransformer((super.getCodec("args") as Vec), FunctionArgumentMetadataV12.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  FunctionMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  FunctionMetadataV12.empty() : super.empty();
  static FunctionMetadataV12 transform(Struct origin) => FunctionMetadataV12.from(origin);
  factory FunctionMetadataV12.from(Struct origin) {
    // FunctionMetadataV12(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name FunctionMetadataV9 */
class FunctionMetadataV9<S extends Map<String, dynamic>> extends Struct implements Call {
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Vec<FunctionArgumentMetadataV9> get args =>
      Vec.withTransformer((super.getCodec("args") as Vec), FunctionArgumentMetadataV9.transform);

  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  FunctionMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  FunctionMetadataV9.empty() : super.empty();
  static FunctionMetadataV9 transform(Struct origin) => FunctionMetadataV9.from(origin);
  factory FunctionMetadataV9.from(Struct origin) {
    // FunctionMetadataV9(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return FunctionMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MapTypeLatest */
class MapTypeLatest extends MapTypeV12 {
  MapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  MapTypeLatest.empty() : super.empty();
  static MapTypeLatest transform(Struct origin) => MapTypeLatest.from(origin);
  factory MapTypeLatest.from(Struct origin) {
    // MapTypeLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MapTypeLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MapTypeV10 */
class MapTypeV10<S extends Map<String, dynamic>> extends Struct implements AsMap {
  StorageHasherV10 get hasher => StorageHasherV10.from(super.getCodec("hasher"));
  CodecType get key => super.getCodec("key").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  bool get linked => super.getCodec("linked").cast<CodecBool>().value;

  MapTypeV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  MapTypeV10.empty() : super.empty();
  static MapTypeV10 transform(Struct origin) => MapTypeV10.from(origin);
  factory MapTypeV10.from(Struct origin) {
    // MapTypeV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MapTypeV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MapTypeV11 */
class MapTypeV11<S extends Map<String, dynamic>> extends Struct implements AsMap {
  StorageHasherV11 get hasher => StorageHasherV11.from(super.getCodec("hasher"));
  CodecType get key => super.getCodec("key").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  bool get linked => super.getCodec("linked").cast<CodecBool>().value;

  MapTypeV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  MapTypeV11.empty() : super.empty();
  static MapTypeV11 transform(Struct origin) => MapTypeV11.from(origin);
  factory MapTypeV11.from(Struct origin) {
    // MapTypeV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MapTypeV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MapTypeV12 */
class MapTypeV12 extends MapTypeV11 {
  MapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  MapTypeV12.empty() : super.empty();
  static MapTypeV12 transform(Struct origin) => MapTypeV12.from(origin);
  factory MapTypeV12.from(Struct origin) {
    // MapTypeV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MapTypeV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MapTypeV9 */
class MapTypeV9<S extends Map<String, dynamic>> extends Struct implements AsMap {
  StorageHasherV9 get hasher => StorageHasherV9.from(super.getCodec("hasher"));
  CodecType get key => super.getCodec("key").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  bool get linked => super.getCodec("linked").cast<CodecBool>().value;

  MapTypeV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  MapTypeV9.empty() : super.empty();
  static MapTypeV9 transform(Struct origin) => MapTypeV9.from(origin);
  factory MapTypeV9.from(Struct origin) {
    // MapTypeV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MapTypeV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MetadataAll */
class MetadataAll extends Enum {
  MetadataAll(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  MetadataAll.empty() : super.empty();
  static MetadataAll transform(Enum origin) => MetadataAll.from(origin);
  factory MetadataAll.from(Enum origin) {
    // MetadataAll(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return MetadataAll.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }

  bool get isV9 => super.isKey("V9");
  MetadataV9 get asV9 => MetadataV9.from(super.askey("V9"));
  bool get isV10 => super.isKey("V10");
  MetadataV10 get asV10 => MetadataV10.from(super.askey("V10"));
  bool get isV11 => super.isKey("V11");
  MetadataV11 get asV11 => MetadataV11.from(super.askey("V11"));
  bool get isV12 => super.isKey("V12");
  MetadataV12 get asV12 => MetadataV12.from(super.askey("V12"));
}

/// @name MetadataLatest */
class MetadataLatest extends MetadataV12 implements MetaMapped {
  Vec<ModuleMetadataLatest> get modules {
    return Vec.withTransformer((super.getCodec("modules") as Vec), ModuleMetadataLatest.transform);
  }

  ExtrinsicMetadataLatest get extrinsic =>
      ExtrinsicMetadataLatest.from(super.getCodec("extrinsic"));

  OuterEvent get outerEvent => null;
  MetadataLatest.empty() : super.empty();
  MetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static MetadataLatest transform(Struct origin) => MetadataLatest.from(origin);
  factory MetadataLatest.from(Struct origin) {
    // MetadataLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MetadataV10 */
class MetadataV10<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV10> get modules =>
      Vec.withTransformer((super.getCodec("modules") as Vec), ModuleMetadataV10.transform);

  OuterEvent get outerEvent => null;
  MetadataV10.empty() : super.empty();
  MetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static MetadataV10 transform(Struct origin) => MetadataV10.from(origin);
  factory MetadataV10.from(Struct origin) {
    // MetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MetadataV11 */
class MetadataV11<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV11> get modules =>
      Vec.withTransformer((super.getCodec("modules") as Vec), ModuleMetadataV11.transform);

  ExtrinsicMetadataV11 get extrinsic => ExtrinsicMetadataV11.from(super.getCodec("extrinsic"));
  OuterEvent get outerEvent => null;
  MetadataV11.empty() : super.empty();
  MetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static MetadataV11 transform(Struct origin) => MetadataV11.from(origin);
  factory MetadataV11.from(Struct origin) {
    // MetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name MetadataV12 */
class MetadataV12<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV12> get modules =>
      Vec.withTransformer((super.getCodec("modules") as Vec), ModuleMetadataV12.transform);

  ExtrinsicMetadataV12 get extrinsic => ExtrinsicMetadataV12.from(super.getCodec("extrinsic"));
  OuterEvent get outerEvent => null;

  MetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  MetadataV12.empty() : super.empty();
  static MetadataV12 transform(Struct origin) => MetadataV12.from(origin);
  factory MetadataV12.from(Struct origin) {
    // MetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

abstract class MetaMapped implements Struct {
  MetaMapped.from(Struct origin);
}

/// @name MetadataV9 */
class MetadataV9<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV9> get modules =>
      Vec.withTransformer((super.getCodec("modules") as Vec), ModuleMetadataV9.transform);

  OuterEvent get outerEvent => null;
  MetadataV9.empty() : super.empty();
  MetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static MetadataV9 transform(Struct origin) => MetadataV9.from(origin);
  factory MetadataV9.from(Struct origin) {
    // MetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return MetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleConstantMetadataLatest */
class ModuleConstantMetadataLatest extends ModuleConstantMetadataV12 {
  ModuleConstantMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ModuleConstantMetadataLatest.empty() : super.empty();
  static ModuleConstantMetadataLatest transform(Struct origin) =>
      ModuleConstantMetadataLatest.from(origin);
  factory ModuleConstantMetadataLatest.from(Struct origin) {
    // ModuleConstantMetadataLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleConstantMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleConstantMetadataV10 */
class ModuleConstantMetadataV10 extends ModuleConstantMetadataV9 {
  ModuleConstantMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ModuleConstantMetadataV10.empty() : super.empty();
  static ModuleConstantMetadataV10 transform(Struct origin) =>
      ModuleConstantMetadataV10.from(origin);
  factory ModuleConstantMetadataV10.from(Struct origin) {
    // ModuleConstantMetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleConstantMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleConstantMetadataV11 */
class ModuleConstantMetadataV11 extends ModuleConstantMetadataV10 {
  ModuleConstantMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ModuleConstantMetadataV11.empty() : super.empty();
  static ModuleConstantMetadataV11 transform(Struct origin) =>
      ModuleConstantMetadataV11.from(origin);
  factory ModuleConstantMetadataV11.from(Struct origin) {
    // ModuleConstantMetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleConstantMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleConstantMetadataV12 */
class ModuleConstantMetadataV12 extends ModuleConstantMetadataV11 {
  ModuleConstantMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ModuleConstantMetadataV12.empty() : super.empty();
  static ModuleConstantMetadataV12 transform(Struct origin) =>
      ModuleConstantMetadataV12.from(origin);
  factory ModuleConstantMetadataV12.from(Struct origin) {
    // ModuleConstantMetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleConstantMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleConstantMetadataV9 */
class ModuleConstantMetadataV9<S extends Map<String, dynamic>> extends Struct
    implements ConstantText {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  CodecType get type => super.getCodec("type").cast<CodecType>();
  Bytes get thisValue => Bytes.from(super.getCodec("value"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  ModuleConstantMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  ModuleConstantMetadataV9.empty() : super.empty();
  static ModuleConstantMetadataV9 transform(Struct origin) => ModuleConstantMetadataV9.from(origin);
  factory ModuleConstantMetadataV9.from(Struct origin) {
    // ModuleConstantMetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleConstantMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleMetadataLatest */
class ModuleMetadataLatest extends ModuleMetadataV12 {
  ModuleCall get module => null;
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Option<StorageMetadataLatest> get storage {
    var data = (super.getCodec("storage") as Option);
    return data.value is CodecNull
        ? null //Option.from(data.value, data.registry, data.originTypeName)
        : Option.from(StorageMetadataLatest.from(data.value), data.registry, data.originTypeName);
  }

  Option<Vec<FunctionMetadataLatest>> get calls {
    var data = (super.getCodec("calls") as Option);

    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }

    return Option.from(Vec.withTransformer((data.value as Vec), FunctionMetadataLatest.transform),
        data.registry, data.originTypeName);
  }

  Option<Vec<EventMetadataLatest>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataLatest>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    return Option.from(Vec.withTransformer((data.value as Vec), EventMetadataLatest.transform),
        data.registry, data.originTypeName);
  }

  Vec<ModuleConstantMetadataLatest> get constants => Vec.withTransformer(
      (super.getCodec("constants") as Vec), ModuleConstantMetadataLatest.transform);

  Vec<ErrorMetadataLatest> get errors =>
      Vec.withTransformer((super.getCodec("errors") as Vec), ErrorMetadataLatest.transform);

  u8 get index => super.getCodec("index").cast<u8>();
  ModuleMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  ModuleMetadataLatest.empty() : super.empty();

  static ModuleMetadataLatest transform(Struct origin) => ModuleMetadataLatest.from(origin);

  factory ModuleMetadataLatest.from(Struct origin) {
    // ModuleMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleMetadataV10 */
class ModuleMetadataV10<S extends Map<String, dynamic>> extends Struct implements Module {
  ModuleCall get module => null;
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Option<StorageMetadataV10> get storage {
    var data = (super.getCodec("storage") as Option);
    return data.value is CodecNull
        ? null // Option.from(data.value, data.registry, data.originTypeName)
        : Option.from(StorageMetadataV10.from(data.value), data.registry, data.originTypeName);
  }

  Option<Vec<FunctionMetadataV10>> get calls {
    var data = (super.getCodec("calls") as Option);

    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }

    return Option.from(Vec.withTransformer((data.value as Vec), FunctionMetadataV10.transform),
        data.registry, data.originTypeName);
  }

  Option<Vec<EventMetadataV10>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV10>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    return Option.from(Vec.withTransformer((data.value as Vec), EventMetadataV10.transform),
        data.registry, data.originTypeName);
  }

  Vec<ModuleConstantMetadataV10> get constants => Vec.withTransformer(
      (super.getCodec("constants") as Vec), ModuleConstantMetadataV10.transform);

  Vec<ErrorMetadataV10> get errors =>
      Vec.withTransformer((super.getCodec("errors") as Vec), ErrorMetadataV10.transform);

  ModuleMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  ModuleMetadataV10.empty() : super.empty();
  static ModuleMetadataV10 transform(Struct origin) => ModuleMetadataV10.from(origin);
  factory ModuleMetadataV10.from(Struct origin) {
    // ModuleMetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleMetadataV11 */
class ModuleMetadataV11<S extends Map<String, dynamic>> extends Struct implements Module {
  ModuleCall get module => null;
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Option<StorageMetadataV11> get storage {
    var data = (super.getCodec("storage") as Option);
    return data.value is CodecNull
        ? null // Option.from(data.value, data.registry, data.originTypeName)
        : Option.from(StorageMetadataV11.from(data.value), data.registry, data.originTypeName);
  }

  Option<Vec<FunctionMetadataV11>> get calls {
    var data = (super.getCodec("calls") as Option);

    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }

    return Option.from(Vec.withTransformer((data.value as Vec), FunctionMetadataV11.transform),
        data.registry, data.originTypeName);
  }

  Option<Vec<EventMetadataV11>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV11>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    return Option.from(Vec.withTransformer((data.value as Vec), EventMetadataV11.transform),
        data.registry, data.originTypeName);
  }

  Vec<ModuleConstantMetadataV11> get constants => Vec.withTransformer(
      (super.getCodec("constants") as Vec), ModuleConstantMetadataV11.transform);

  Vec<ErrorMetadataV11> get errors =>
      Vec.withTransformer((super.getCodec("errors") as Vec), ErrorMetadataV11.transform);

  ModuleMetadataV11.empty() : super.empty();
  ModuleMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static ModuleMetadataV11 transform(Struct origin) => ModuleMetadataV11.from(origin);
  factory ModuleMetadataV11.from(Struct origin) {
    // ModuleMetadataV11(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleMetadataV12 */
class ModuleMetadataV12<S extends Map<String, dynamic>> extends Struct implements Module {
  ModuleCall get module => null;
  CodecText get name => super.getCodec("name").cast<CodecText>();

  Option<StorageMetadataV12> get storage {
    var data = (super.getCodec("storage") as Option);
    return data.value is CodecNull
        ? null //Option.from(data.value, data.registry, data.originTypeName)
        : Option.from(StorageMetadataV12.from(data.value), data.registry, data.originTypeName);
  }

  Option<Vec<FunctionMetadataV12>> get calls {
    var data = (super.getCodec("calls") as Option);

    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }

    return Option.from(Vec.withTransformer((data.value as Vec), FunctionMetadataV12.transform),
        data.registry, data.originTypeName);
  }

  Option<Vec<EventMetadataV12>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV12>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    return Option.from(Vec.withTransformer((data.value as Vec), EventMetadataV12.transform),
        data.registry, data.originTypeName);
  }

  Vec<ModuleConstantMetadataV12> get constants => Vec.withTransformer(
      (super.getCodec("constants") as Vec), ModuleConstantMetadataV12.transform);

  Vec<ErrorMetadataV12> get errors =>
      Vec.withTransformer((super.getCodec("errors") as Vec), ErrorMetadataV12.transform);

  u8 get index => super.getCodec("index").cast<u8>();
  ModuleMetadataV12.empty() : super.empty();
  ModuleMetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);

  static ModuleMetadataV12 transform(Struct origin) => ModuleMetadataV12.from(origin);
  factory ModuleMetadataV12.from(Struct origin) {
    // ModuleMetadataV12(
    //   origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name ModuleMetadataV9 */
class ModuleMetadataV9<S extends Map<String, dynamic>> extends Struct implements Module, Castable {
  ModuleCall get module => null;
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Option<StorageMetadataV9> get storage {
    var data = (super.getCodec("storage") as Option);
    return data.value is CodecNull
        ? null //Option.from(data.value, data.registry, data.originTypeName)
        : Option.from(StorageMetadataV9.from(data.value), data.registry, data.originTypeName);
  }

  Option<Vec<FunctionMetadataV9>> get calls {
    var data = (super.getCodec("calls") as Option);

    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }

    return Option.from(Vec.withTransformer((data.value as Vec), FunctionMetadataV9.transform),
        data.registry, data.originTypeName);
  }

  Option<Vec<EventMetadataV9>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV9>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    return Option.from(Vec.withTransformer((data.value as Vec), EventMetadataV9.transform),
        data.registry, data.originTypeName);
  }

  Vec<ModuleConstantMetadataV9> get constants =>
      Vec.withTransformer((super.getCodec("constants") as Vec), ModuleConstantMetadataV9.transform);

  Vec<ErrorMetadataV9> get errors =>
      Vec.withTransformer((super.getCodec("errors") as Vec), ErrorMetadataV9.transform);

  ModuleMetadataV9.empty() : super.empty();
  ModuleMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static ModuleMetadataV9 transform(Struct origin) => ModuleMetadataV9.from(origin);
  factory ModuleMetadataV9.from(Struct origin) {
    // ModuleMetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return ModuleMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryMetadataLatest */
class StorageEntryMetadataLatest extends StorageEntryMetadataV12 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierLatest get modifier =>
      StorageEntryModifierLatest.from(super.getCodec("modifier"));
  StorageEntryTypeLatest get type => StorageEntryTypeLatest.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  StorageEntryMetadataLatest.empty() : super.empty();
  StorageEntryMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageEntryMetadataLatest transform(Struct origin) =>
      StorageEntryMetadataLatest.from(origin);
  factory StorageEntryMetadataLatest.from(Struct origin) {
    // StorageEntryMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageEntryMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryMetadataV10 */
class StorageEntryMetadataV10<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV10 get modifier => StorageEntryModifierV10.from(super.getCodec("modifier"));
  StorageEntryTypeV10 get type => StorageEntryTypeV10.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  StorageEntryMetadataV10.empty() : super.empty();
  StorageEntryMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static StorageEntryMetadataV10 transform(Struct origin) => StorageEntryMetadataV10.from(origin);
  factory StorageEntryMetadataV10.from(Struct origin) {
    // StorageEntryMetadataV10(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageEntryMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryMetadataV11 */
class StorageEntryMetadataV11<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV11 get modifier => StorageEntryModifierV11.from(super.getCodec("modifier"));
  StorageEntryTypeV11 get type => StorageEntryTypeV11.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  StorageEntryMetadataV11.empty() : super.empty();
  StorageEntryMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static StorageEntryMetadataV11 transform(Struct origin) => StorageEntryMetadataV11.from(origin);
  factory StorageEntryMetadataV11.from(Struct origin) {
    // StorageEntryMetadataV11(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageEntryMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryMetadataV12 */
class StorageEntryMetadataV12 extends StorageEntryMetadataV11 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV12 get modifier => StorageEntryModifierV12.from(super.getCodec("modifier"));
  StorageEntryTypeV12 get type => StorageEntryTypeV12.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  StorageEntryMetadataV12.empty() : super.empty();
  StorageEntryMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageEntryMetadataV12 transform(Struct origin) => StorageEntryMetadataV12.from(origin);
  factory StorageEntryMetadataV12.from(Struct origin) {
    // StorageEntryMetadataV12(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageEntryMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryMetadataV9 */
class StorageEntryMetadataV9<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV9 get modifier => StorageEntryModifierV9.from(super.getCodec("modifier"));
  StorageEntryTypeV9 get type => StorageEntryTypeV9.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation =>
      Vec.withTransformer((super.getCodec("documentation") as Vec), CodecText.transform);

  StorageEntryMetadataV9.empty() : super.empty();
  StorageEntryMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static StorageEntryMetadataV9 transform(Struct origin) => StorageEntryMetadataV9.from(origin);
  factory StorageEntryMetadataV9.from(Struct origin) {
    // StorageEntryMetadataV9(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageEntryMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageEntryModifierLatest */
class StorageEntryModifierLatest extends StorageEntryModifierV12 {
  StorageEntryModifierLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryModifierLatest.empty() : super.empty();
  static StorageEntryModifierLatest transform(Enum origin) =>
      StorageEntryModifierLatest.from(origin);
  factory StorageEntryModifierLatest.from(Enum origin) {
    // StorageEntryModifierLatest(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryModifierLatest.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageEntryModifierV10 */
class StorageEntryModifierV10 extends StorageEntryModifierV9 {
  StorageEntryModifierV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryModifierV10.empty() : super.empty();
  static StorageEntryModifierV10 transform(Enum origin) => StorageEntryModifierV10.from(origin);
  factory StorageEntryModifierV10.from(Enum origin) {
    // StorageEntryModifierV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryModifierV10.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageEntryModifierV11 */
class StorageEntryModifierV11 extends StorageEntryModifierV10 {
  StorageEntryModifierV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryModifierV11.empty() : super.empty();
  static StorageEntryModifierV11 transform(Enum origin) => StorageEntryModifierV11.from(origin);
  factory StorageEntryModifierV11.from(Enum origin) {
    // StorageEntryModifierV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryModifierV11.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

// /** @name StorageEntryModifierV12 */
class StorageEntryModifierV12 extends StorageEntryModifierV11 {
  StorageEntryModifierV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryModifierV12.empty() : super.empty();
  static StorageEntryModifierV12 transform(Enum origin) => StorageEntryModifierV12.from(origin);
  factory StorageEntryModifierV12.from(Enum origin) {
    // StorageEntryModifierV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryModifierV12.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageEntryModifierV9 */
class StorageEntryModifierV9 extends Enum {
  StorageEntryModifierV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryModifierV9.empty() : super.empty();
  static StorageEntryModifierV9 transform(Enum origin) => StorageEntryModifierV9.from(origin);
  factory StorageEntryModifierV9.from(Enum origin) {
    // StorageEntryModifierV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryModifierV9.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }

  bool get isOptional => super.isKey("Optional");
  bool get isDefault => super.isKey("Default");
  bool get isRequired => super.isKey("Required");
}

/// @name StorageEntryTypeLatest */
class StorageEntryTypeLatest extends StorageEntryTypeV12 {
  StorageEntryTypeLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryTypeLatest.empty() : super.empty();
  static StorageEntryTypeLatest transform(Enum origin) => StorageEntryTypeLatest.from(origin);
  factory StorageEntryTypeLatest.from(Enum origin) {
    // StorageEntryTypeLatest(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryTypeLatest.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeLatest get asMap => MapTypeLatest.from(super.askey("Map"));
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeLatest get asDoubleMap => DoubleMapTypeLatest.from(super.askey("DoubleMap"));
}

/// @name StorageEntryTypeV10 */
class StorageEntryTypeV10 extends Enum implements ItemType {
  StorageEntryTypeV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryTypeV10.empty() : super.empty();
  static StorageEntryTypeV10 transform(Enum origin) => StorageEntryTypeV10.from(origin);
  factory StorageEntryTypeV10.from(Enum origin) {
    // StorageEntryTypeV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryTypeV10.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV10 get asMap => MapTypeV10.from(super.askey("Map"));
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV10 get asDoubleMap => DoubleMapTypeV10.from(super.askey("DoubleMap"));
}

// /** @name StorageEntryTypeV11 */
class StorageEntryTypeV11 extends Enum implements ItemType {
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV11 get asMap => MapTypeV11.from(super.askey("Map"));
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV11 get asDoubleMap => DoubleMapTypeV11.from(super.askey("DoubleMap"));

  StorageEntryTypeV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryTypeV11.empty() : super.empty();
  static StorageEntryTypeV11 transform(Enum origin) => StorageEntryTypeV11.from(origin);
  factory StorageEntryTypeV11.from(Enum origin) {
    // StorageEntryTypeV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryTypeV11.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

// /** @name StorageEntryTypeV12 */
class StorageEntryTypeV12 extends StorageEntryTypeV11 {
  StorageEntryTypeV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryTypeV12.empty() : super.empty();
  static StorageEntryTypeV12 transform(Enum origin) => StorageEntryTypeV12.from(origin);
  factory StorageEntryTypeV12.from(Enum origin) {
    //  StorageEntryTypeV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryTypeV12.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV12 get asMap => MapTypeV12.from(super.askey("Map"));
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV12 get asDoubleMap => DoubleMapTypeV12.from(super.askey("DoubleMap"));
}

/// @name StorageEntryTypeV9 */
class StorageEntryTypeV9 extends Enum implements ItemType {
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV9 get asMap => MapTypeV9.from(super.askey("Map"));
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV9 get asDoubleMap => DoubleMapTypeV9.from(super.askey("DoubleMap"));

  StorageEntryTypeV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageEntryTypeV9.empty() : super.empty();
  static StorageEntryTypeV9 transform(Enum origin) => StorageEntryTypeV9.from(origin);
  factory StorageEntryTypeV9.from(Enum origin) {
    // StorageEntryTypeV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageEntryTypeV9.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageHasher */
class StorageHasher extends StorageHasherV12 {
  StorageHasher(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageHasher.empty() : super.empty();
  static StorageHasher transform(Enum origin) => StorageHasher.from(origin);
  factory StorageHasher.from(Enum origin) {
    // StorageHasher(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageHasher.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

// /** @name StorageHasherV10 */
class StorageHasherV10 extends Enum {
  bool get isBlake2128 => super.isKey("Blake2128");
  bool get isBlake2256 => super.isKey("Blake2256");
  bool get isBlake2128Concat => super.isKey("Blake2128Concat");
  bool get isTwox128 => super.isKey("Twox128");
  bool get isTwox256 => super.isKey("Twox256");
  bool get isTwox64Concat => super.isKey("Twox64Concat");

  StorageHasherV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageHasherV10.empty() : super.empty();
  static StorageHasherV10 transform(Enum origin) => StorageHasherV10.from(origin);
  factory StorageHasherV10.from(Enum origin) {
    // StorageHasherV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageHasherV10.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageHasherV11 */
class StorageHasherV11 extends Enum {
  bool get isBlake2128 => super.isKey("Blake2128");
  bool get isBlake2256 => super.isKey("Blake2256");
  bool get isBlake2128Concat => super.isKey("Blake2128Concat");
  bool get isTwox128 => super.isKey("Twox128");
  bool get isTwox256 => super.isKey("Twox256");
  bool get isTwox64Concat => super.isKey("Twox64Concat");
  bool get isIdentity => super.isKey("Identity");

  StorageHasherV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageHasherV11.empty() : super.empty();
  static StorageHasherV11 transform(Enum origin) => StorageHasherV11.from(origin);
  factory StorageHasherV11.from(Enum origin) {
    // StorageHasherV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageHasherV11.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageHasherV12 */
class StorageHasherV12 extends StorageHasherV11 {
  StorageHasherV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageHasherV12.empty() : super.empty();
  static StorageHasherV12 transform(Enum origin) => StorageHasherV12.from(origin);
  factory StorageHasherV12.from(Enum origin) {
    // StorageHasherV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageHasherV12.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

/// @name StorageHasherV9 */
class StorageHasherV9 extends Enum {
  bool get isBlake2128 => super.isKey("Blake2128");
  bool get isBlake2256 => super.isKey("Blake2256");
  bool get isTwox128 => super.isKey("Twox128");
  bool get isTwox256 => super.isKey("Twox256");
  bool get isTwox64Concat => super.isKey("Twox64Concat");

  StorageHasherV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  StorageHasherV9.empty() : super.empty();
  static StorageHasherV9 transform(Enum origin) => StorageHasherV9.from(origin);
  factory StorageHasherV9.from(Enum origin) {
    // StorageHasherV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
    return StorageHasherV9.empty()
      ..registry = origin.registry
      ..originDef = origin.def
      ..originIndex = origin.originIndex
      ..originValue = origin.originValue
      ..setBasic(origin.isBasic)
      ..setIndexes(origin.indexes)
      ..setIndex(origin.index)
      ..setDef(origin.def)
      ..setRaw(origin.value)
      ..genKeys();
  }
}

// /** @name StorageMetadataLatest */
class StorageMetadataLatest extends StorageMetadataV12 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();

  Vec<StorageEntryMetadataLatest> get items =>
      Vec.withTransformer((super.getCodec("items") as Vec), StorageEntryMetadataLatest.transform);

  StorageMetadataLatest.empty() : super.empty();
  StorageMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageMetadataLatest transform(Struct origin) => StorageMetadataLatest.from(origin);
  factory StorageMetadataLatest.from(Struct origin) {
    // StorageMetadataLatest(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageMetadataLatest.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageMetadataV10 */
class StorageMetadataV10<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();

  Vec<StorageEntryMetadataV10> get items =>
      Vec.withTransformer((super.getCodec("items") as Vec), StorageEntryMetadataV10.transform);

  StorageMetadataV10.empty() : super.empty();
  StorageMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  static StorageMetadataV10 transform(Struct origin) => StorageMetadataV10.from(origin);
  factory StorageMetadataV10.from(Struct origin) {
    // StorageMetadataV10(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageMetadataV10.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageMetadataV11 */
class StorageMetadataV11<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();

  Vec<StorageEntryMetadataV11> get items =>
      Vec.withTransformer((super.getCodec("items") as Vec), StorageEntryMetadataV11.transform);

  StorageMetadataV11.empty() : super.empty();
  StorageMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageMetadataV11 transform(Struct origin) => StorageMetadataV11.from(origin);
  factory StorageMetadataV11.from(Struct origin) {
    return StorageMetadataV11.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageMetadataV12 */
class StorageMetadataV12 extends StorageMetadataV11 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();

  Vec<StorageEntryMetadataV12> get items =>
      Vec.withTransformer((super.getCodec("items") as Vec), StorageEntryMetadataV12.transform);

  StorageMetadataV12.empty() : super.empty();
  StorageMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageMetadataV12 transform(Struct origin) => StorageMetadataV12.from(origin);
  factory StorageMetadataV12.from(Struct origin) {
    // StorageMetadataV12(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageMetadataV12.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

/// @name StorageMetadataV9 */
class StorageMetadataV9<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV9> get items =>
      Vec.withTransformer((super.getCodec("items") as Vec), StorageEntryMetadataV9.transform);

  StorageMetadataV9.empty() : super.empty();
  StorageMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  static StorageMetadataV9 transform(Struct origin) => StorageMetadataV9.from(origin);
  factory StorageMetadataV9.from(Struct origin) {
    // StorageMetadataV9(
    //     origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
    return StorageMetadataV9.empty()
      ..setValue(origin.value)
      ..setJsonMap(origin.constructorJsonMap)
      ..setTypes(origin.constructorTypes)
      ..originJsonMap = origin.originJsonMap
      ..originTypes = origin.originTypes
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }
}

// export type PHANTOM_METADATA = 'metadata';
