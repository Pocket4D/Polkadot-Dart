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
  factory DoubleMapTypeLatest.from(Struct origin) => DoubleMapTypeLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory DoubleMapTypeV10.from(Struct origin) => DoubleMapTypeV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory DoubleMapTypeV11.from(Struct origin) => DoubleMapTypeV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory DoubleMapTypeV12.from(Struct origin) => DoubleMapTypeV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory DoubleMapTypeV9.from(Struct origin) => DoubleMapTypeV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV10 */
class ErrorMetadataV10 extends ErrorMetadataV9 {
  ErrorMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataV10.from(Struct origin) => ErrorMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV11 */
class ErrorMetadataV11 extends ErrorMetadataV10 {
  ErrorMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataV11.from(Struct origin) => ErrorMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV12 */
class ErrorMetadataV12 extends ErrorMetadataV11 {
  ErrorMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataV12.from(Struct origin) => ErrorMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

class ErrorMetadataLatest extends ErrorMetadataV12 {
  ErrorMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataLatest.from(Struct origin) => ErrorMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV9 */
class ErrorMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  ErrorMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ErrorMetadataV9.from(Struct origin) => ErrorMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataLatest */
class EventMetadataLatest extends EventMetadataV12 {
  EventMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataLatest.from(Struct origin) => EventMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV10 */
class EventMetadataV10 extends EventMetadataV9 {
  EventMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV10.from(Struct origin) => EventMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV11 */
class EventMetadataV11 extends EventMetadataV10 {
  EventMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV11.from(Struct origin) => EventMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV12 */
class EventMetadataV12 extends EventMetadataV11 {
  EventMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV12.from(Struct origin) => EventMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV9 */
class EventMetadataV9<S extends Map<String, dynamic>> extends Struct implements Event {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<CodecType> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return CodecType(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Type');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  EventMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory EventMetadataV9.from(Struct origin) => EventMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ExtrinsicMetadataLatest */
class ExtrinsicMetadataLatest extends ExtrinsicMetadataV12 {
  ExtrinsicMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ExtrinsicMetadataLatest.from(Struct origin) => ExtrinsicMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ExtrinsicMetadataV11 */
class ExtrinsicMetadataV11<S extends Map<String, dynamic>> extends Struct {
  u8 get version => super.getCodec("version").cast<u8>();
  Vec<CodecText> get signedExtensions {
    var data = (super.getCodec("signedExtensions") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  ExtrinsicMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ExtrinsicMetadataV11.from(Struct origin) => ExtrinsicMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ExtrinsicMetadataV12 */
class ExtrinsicMetadataV12 extends ExtrinsicMetadataV11 {
  ExtrinsicMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ExtrinsicMetadataV12.from(Struct origin) => ExtrinsicMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataLatest */
class FunctionArgumentMetadataLatest extends FunctionArgumentMetadataV12 {
  FunctionArgumentMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataLatest.from(Struct origin) => FunctionArgumentMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV10 */
class FunctionArgumentMetadataV10 extends FunctionArgumentMetadataV9 {
  FunctionArgumentMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV10.from(Struct origin) => FunctionArgumentMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV11 */
class FunctionArgumentMetadataV11 extends FunctionArgumentMetadataV10 {
  FunctionArgumentMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV11.from(Struct origin) => FunctionArgumentMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV12 */
class FunctionArgumentMetadataV12 extends FunctionArgumentMetadataV11 {
  FunctionArgumentMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV12.from(Struct origin) => FunctionArgumentMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV9 */
class FunctionArgumentMetadataV9<S extends Map<String, dynamic>> extends Struct implements Arg {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  CodecType get type => super.getCodec("type").cast<CodecText>();

  FunctionArgumentMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory FunctionArgumentMetadataV9.from(Struct origin) => FunctionArgumentMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataLatest */
class FunctionMetadataLatest extends FunctionMetadataV12 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<FunctionArgumentMetadataLatest> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return FunctionArgumentMetadataLatest.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'FunctionArgumentMetadataLatest');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  FunctionMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataLatest.from(Struct origin) => FunctionMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  Vec<FunctionArgumentMetadataV10> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return FunctionArgumentMetadataV10.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'FunctionArgumentMetadataV10');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  FunctionMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV10.from(Struct origin) => FunctionMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV11 */
class FunctionMetadataV11 extends FunctionMetadataV10 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<FunctionArgumentMetadataV11> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return FunctionArgumentMetadataV11.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'FunctionArgumentMetadataV11');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  FunctionMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV11.from(Struct origin) => FunctionMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV12 */
class FunctionMetadataV12 extends FunctionMetadataV11 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<FunctionArgumentMetadataV12> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return FunctionArgumentMetadataV12.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'FunctionArgumentMetadataV12');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  FunctionMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV12.from(Struct origin) => FunctionMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV9 */
class FunctionMetadataV9<S extends Map<String, dynamic>> extends Struct implements Call {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<FunctionArgumentMetadataV9> get args {
    var data = (super.getCodec("args") as Vec);
    var newList = data.value.map((element) {
      return FunctionArgumentMetadataV9.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'FunctionArgumentMetadataV9');
  }

  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  FunctionMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory FunctionMetadataV9.from(Struct origin) => FunctionMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MapTypeLatest */
class MapTypeLatest extends MapTypeV12 {
  MapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory MapTypeLatest.from(Struct origin) =>
      MapTypeLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory MapTypeV10.from(Struct origin) =>
      MapTypeV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory MapTypeV11.from(Struct origin) =>
      MapTypeV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MapTypeV12 */
class MapTypeV12 extends MapTypeV11 {
  MapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory MapTypeV12.from(Struct origin) =>
      MapTypeV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
  factory MapTypeV9.from(Struct origin) =>
      MapTypeV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataAll */
class MetadataAll extends Enum {
  MetadataAll(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);

  factory MetadataAll.from(Enum origin) =>
      MetadataAll(origin.registry, origin.def, origin.originValue, origin.originIndex);

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
    var data = (super.getCodec("modules") as Vec);
    var newList = data.value.map((element) {
      return ModuleMetadataLatest.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleMetadataLatest');
  }

  ExtrinsicMetadataLatest get extrinsic =>
      ExtrinsicMetadataLatest.from(super.getCodec("extrinsic"));
  OuterEvent get outerEvent => null;
  MetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory MetadataLatest.from(Struct origin) =>
      MetadataLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV10 */
class MetadataV10<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV10> get modules {
    var data = (super.getCodec("modules") as Vec);
    var newList = data.value.map((element) {
      return ModuleMetadataV10.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleMetadataV10');
  }

  OuterEvent get outerEvent => null;
  MetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV10.from(Struct origin) =>
      MetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV11 */
class MetadataV11<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV11> get modules {
    var data = (super.getCodec("modules") as Vec);
    var newList = data.value.map((element) {
      return ModuleMetadataV11.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleMetadataV11');
  }

  ExtrinsicMetadataV11 get extrinsic => ExtrinsicMetadataV11.from(super.getCodec("extrinsic"));
  OuterEvent get outerEvent => null;

  MetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV11.from(Struct origin) =>
      MetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV12 */
class MetadataV12<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV12> get modules {
    var data = (super.getCodec("modules") as Vec);
    var newList = data.value.map((element) {
      return ModuleMetadataV12.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleMetadataV12');
  }

  ExtrinsicMetadataV12 get extrinsic => ExtrinsicMetadataV12.from(super.getCodec("extrinsic"));
  OuterEvent get outerEvent => null;

  MetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV12.from(Struct origin) =>
      MetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

abstract class MetaMapped implements Struct {
  MetaMapped.from(Struct origin);
}

/// @name MetadataV9 */
class MetadataV9<S extends Map<String, dynamic>> extends Struct
    implements MetaMapped, ExtractionMetadata {
  Vec<ModuleMetadataV9> get modules {
    var data = (super.getCodec("modules") as Vec);
    var newList = data.value.map((element) {
      return ModuleMetadataV9.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleMetadataV9');
  }

  OuterEvent get outerEvent => null;
  MetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV9.from(Struct origin) =>
      MetadataV9(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataLatest */
class ModuleConstantMetadataLatest extends ModuleConstantMetadataV12 {
  ModuleConstantMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataLatest.from(Struct origin) => ModuleConstantMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV10 */
class ModuleConstantMetadataV10 extends ModuleConstantMetadataV9 {
  ModuleConstantMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV10.from(Struct origin) => ModuleConstantMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV11 */
class ModuleConstantMetadataV11 extends ModuleConstantMetadataV10 {
  ModuleConstantMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV11.from(Struct origin) => ModuleConstantMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV12 */
class ModuleConstantMetadataV12 extends ModuleConstantMetadataV11 {
  ModuleConstantMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV12.from(Struct origin) => ModuleConstantMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV9 */
class ModuleConstantMetadataV9<S extends Map<String, dynamic>> extends Struct
    implements ConstantText {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  CodecType get type => super.getCodec("type").cast<CodecType>();
  Bytes get thisValue => Bytes.from(super.getCodec("value"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  ModuleConstantMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleConstantMetadataV9.from(Struct origin) => ModuleConstantMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return FunctionMetadataLatest.from(element);
    }).toList();

    final result = Option.from(Vec.fromList(newList, data.registry, 'FunctionMetadataLatest'),
        data.registry, data.originTypeName);

    return result;
  }

  Option<Vec<EventMetadataLatest>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataLatest>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return EventMetadataLatest.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'EventMetadataLatest'), data.registry,
        data.originTypeName);
  }

  Vec<ModuleConstantMetadataLatest> get constants {
    var data = (super.getCodec("constants") as Vec);
    var newList = data.value.map((element) {
      return ModuleConstantMetadataLatest.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleConstantMetadataLatest');
  }

  Vec<ErrorMetadataLatest> get errors {
    var data = (super.getCodec("errors") as Vec);
    var newList = data.value.map((element) {
      return ErrorMetadataLatest.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ErrorMetadataLatest');
  }

  u8 get index => super.getCodec("index").cast<u8>();
  ModuleMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleMetadataLatest.from(Struct origin) => ModuleMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return FunctionMetadataV10.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'FunctionMetadataV10'), data.registry,
        data.originTypeName);
  }

  Option<Vec<EventMetadataV10>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV10>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return EventMetadataV10.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'EventMetadataV10'), data.registry,
        data.originTypeName);
  }

  Vec<ModuleConstantMetadataV10> get constants {
    var data = (super.getCodec("constants") as Vec);
    var newList = data.value.map((element) {
      return ModuleConstantMetadataV10.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleConstantMetadataV10');
  }

  Vec<ErrorMetadataV10> get errors {
    var data = (super.getCodec("errors") as Vec);
    var newList = data.value.map((element) {
      return ErrorMetadataV10.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ErrorMetadataV10');
  }

  ModuleMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV10.from(Struct origin) => ModuleMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return FunctionMetadataV11.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'FunctionMetadataV11'), data.registry,
        data.originTypeName);
  }

  Option<Vec<EventMetadataV11>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV11>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return EventMetadataV11.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'EventMetadataV11'), data.registry,
        data.originTypeName);
  }

  Vec<ModuleConstantMetadataV11> get constants {
    var data = (super.getCodec("constants") as Vec);
    var newList = data.value.map((element) {
      return ModuleConstantMetadataV11.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleConstantMetadataV11');
  }

  Vec<ErrorMetadataV11> get errors {
    var data = (super.getCodec("errors") as Vec);
    var newList = data.value.map((element) {
      return ErrorMetadataV11.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ErrorMetadataV11');
  }

  ModuleMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV11.from(Struct origin) => ModuleMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return FunctionMetadataV12.from(element);
    }).toList();

    final result = Option.from(Vec.fromList(newList, data.registry, 'FunctionMetadataV12'),
        data.registry, data.originTypeName);

    return result;
  }

  Option<Vec<EventMetadataV12>> get events {
    // super.getCodec("events").cast<Option<Vec<EventMetadataV12>>>();
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null; //Option.from(data.value, data.registry, data.originTypeName);
    }
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return EventMetadataV12.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'EventMetadataV12'), data.registry,
        data.originTypeName);
  }

  Vec<ModuleConstantMetadataV12> get constants {
    var data = (super.getCodec("constants") as Vec);
    var newList = data.value.map((element) {
      return ModuleConstantMetadataV12.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ModuleConstantMetadataV12');
  }

  Vec<ErrorMetadataV12> get errors {
    var data = (super.getCodec("errors") as Vec);
    var newList = data.value.map((element) {
      return ErrorMetadataV12.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'ErrorMetadataV12');
  }

  u8 get index => super.getCodec("index").cast<u8>();

  ModuleMetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV12.from(Struct origin) => ModuleMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
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
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return FunctionMetadataV9.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'FunctionMetadataV9'), data.registry,
        data.originTypeName);
  }

  Option<Vec<EventMetadataV9>> get events {
    var data = (super.getCodec("events") as Option);
    if (data.value is CodecNull) {
      return null;
      // Option.from(data.value, data.registry, data.originTypeName);
    }
    var vecData = (data.value as Vec);
    var newList = vecData.value.map((element) {
      return EventMetadataV9.from(element);
    }).toList();
    return Option.from(Vec.fromList(newList, data.registry, 'EventMetadataV9'), data.registry,
        data.originTypeName);
  }

  Vec<ModuleConstantMetadataV9> get constants {
    var vecData = (super.getCodec("constants") as Vec);
    var newList = vecData.value.map((element) {
      return ModuleConstantMetadataV9.from(element);
    }).toList();
    return Vec.fromList(newList, vecData.registry, 'ModuleConstantMetadataV9');
  }

  Vec<ErrorMetadataV9> get errors {
    var vecData = (super.getCodec("errors") as Vec);
    var newList = vecData.value.map((element) {
      return ErrorMetadataV9.from(element);
    }).toList();
    return Vec.fromList(newList, vecData.registry, 'ErrorMetadataV9');
  }

  ModuleMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV9.from(Struct origin) => ModuleMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataLatest */
class StorageEntryMetadataLatest extends StorageEntryMetadataV12 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierLatest get modifier =>
      StorageEntryModifierLatest.from(super.getCodec("modifier"));
  StorageEntryTypeLatest get type => StorageEntryTypeLatest.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  StorageEntryMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageEntryMetadataLatest.from(Struct origin) => StorageEntryMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV10 */
class StorageEntryMetadataV10<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV10 get modifier => StorageEntryModifierV10.from(super.getCodec("modifier"));
  StorageEntryTypeV10 get type => StorageEntryTypeV10.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  StorageEntryMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageEntryMetadataV10.from(Struct origin) => StorageEntryMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV11 */
class StorageEntryMetadataV11<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV11 get modifier => StorageEntryModifierV11.from(super.getCodec("modifier"));
  StorageEntryTypeV11 get type => StorageEntryTypeV11.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  StorageEntryMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageEntryMetadataV11.from(Struct origin) => StorageEntryMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV12 */
class StorageEntryMetadataV12 extends StorageEntryMetadataV11 {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV12 get modifier => StorageEntryModifierV12.from(super.getCodec("modifier"));
  StorageEntryTypeV12 get type => StorageEntryTypeV12.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  StorageEntryMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageEntryMetadataV12.from(Struct origin) => StorageEntryMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV9 */
class StorageEntryMetadataV9<S extends Map<String, dynamic>> extends Struct implements Item {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV9 get modifier => StorageEntryModifierV9.from(super.getCodec("modifier"));
  StorageEntryTypeV9 get type => StorageEntryTypeV9.from(super.getCodec("type"));
  Bytes get fallback => Bytes.from(super.getCodec("fallback"));
  Vec<CodecText> get documentation {
    var data = (super.getCodec("documentation") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    return Vec.fromList(newList, data.registry, 'Text');
  }

  StorageEntryMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageEntryMetadataV9.from(Struct origin) => StorageEntryMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryModifierLatest */
class StorageEntryModifierLatest extends StorageEntryModifierV12 {
  StorageEntryModifierLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryModifierLatest.from(Enum origin) => StorageEntryModifierLatest(
      origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageEntryModifierV10 */
class StorageEntryModifierV10 extends StorageEntryModifierV9 {
  StorageEntryModifierV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryModifierV10.from(Enum origin) =>
      StorageEntryModifierV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageEntryModifierV11 */
class StorageEntryModifierV11 extends StorageEntryModifierV10 {
  StorageEntryModifierV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryModifierV11.from(Enum origin) =>
      StorageEntryModifierV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

// /** @name StorageEntryModifierV12 */
class StorageEntryModifierV12 extends StorageEntryModifierV11 {
  StorageEntryModifierV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryModifierV12.from(Enum origin) =>
      StorageEntryModifierV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageEntryModifierV9 */
class StorageEntryModifierV9 extends Enum {
  StorageEntryModifierV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryModifierV9.from(Enum origin) =>
      StorageEntryModifierV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isOptional => super.isKey("Optional");
  bool get isDefault => super.isKey("Default");
  bool get isRequired => super.isKey("Required");
}

/// @name StorageEntryTypeLatest */
class StorageEntryTypeLatest extends StorageEntryTypeV12 {
  StorageEntryTypeLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeLatest.from(Enum origin) =>
      StorageEntryTypeLatest(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageEntryTypeV10.from(Enum origin) =>
      StorageEntryTypeV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageEntryTypeV11.from(Enum origin) =>
      StorageEntryTypeV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

// /** @name StorageEntryTypeV12 */
class StorageEntryTypeV12 extends StorageEntryTypeV11 {
  StorageEntryTypeV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeV12.from(Enum origin) =>
      StorageEntryTypeV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageEntryTypeV9.from(Enum origin) =>
      StorageEntryTypeV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageHasher */
class StorageHasher extends StorageHasherV12 {
  StorageHasher(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageHasher.from(Enum origin) =>
      StorageHasher(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageHasherV10.from(Enum origin) =>
      StorageHasherV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageHasherV11.from(Enum origin) =>
      StorageHasherV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageHasherV12 */
class StorageHasherV12 extends StorageHasherV11 {
  StorageHasherV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageHasherV12.from(Enum origin) =>
      StorageHasherV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
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
  factory StorageHasherV9.from(Enum origin) =>
      StorageHasherV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

// /** @name StorageMetadataLatest */
class StorageMetadataLatest extends StorageMetadataV12 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataLatest> get items {
    var data = (super.getCodec("items") as Vec);
    var newList = data.value.map((element) {
      return StorageEntryMetadataLatest.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'StorageEntryMetadataLatest');
  }

  StorageMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataLatest.from(Struct origin) => StorageMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV10 */
class StorageMetadataV10<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV10> get items {
    var data = (super.getCodec("items") as Vec);
    var newList = data.value.map((element) {
      return StorageEntryMetadataV10.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'StorageEntryMetadataV10');
  }

  StorageMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageMetadataV10.from(Struct origin) => StorageMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV11 */
class StorageMetadataV11<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV11> get items {
    var data = (super.getCodec("items") as Vec);
    var newList = data.value.map((element) {
      return StorageEntryMetadataV11.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'StorageEntryMetadataV11');
  }

  StorageMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV11.from(Struct origin) => StorageMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV12 */
class StorageMetadataV12 extends StorageMetadataV11 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV12> get items {
    var data = (super.getCodec("items") as Vec);
    var newList = data.value.map((element) {
      return StorageEntryMetadataV12.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'StorageEntryMetadataV12');
  }

  StorageMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV12.from(Struct origin) => StorageMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV9 */
class StorageMetadataV9<S extends Map<String, dynamic>> extends Struct implements Items2 {
  Vec<Item> get functions => null;
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV9> get items {
    var data = (super.getCodec("items") as Vec);
    var newList = data.value.map((element) {
      return StorageEntryMetadataV9.from(element);
    }).toList();
    return Vec.fromList(newList, data.registry, 'StorageEntryMetadataV9');
  }

  StorageMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV9.from(Struct origin) => StorageMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// export type PHANTOM_METADATA = 'metadata';
