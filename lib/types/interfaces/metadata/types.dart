import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// /** @name DoubleMapTypeLatest */
class DoubleMapTypeLatest extends DoubleMapTypeV12 {
  DoubleMapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory DoubleMapTypeLatest.from(DoubleMapTypeV12 origin) => DoubleMapTypeLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

class DoubleMapTypeV10<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV10 get hasher => super.getCodec("hasher").cast<StorageHasherV10>();
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV10 get key2Hasher => super.getCodec("key2Hasher").cast<StorageHasherV10>();

  DoubleMapTypeV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DoubleMapTypeV10.from(Struct origin) => DoubleMapTypeV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name DoubleMapTypeV11 */
class DoubleMapTypeV11<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV11 get hasher => super.getCodec("hasher").cast<StorageHasherV11>();
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV11 get key2Hasher => super.getCodec("key2Hasher").cast<StorageHasherV11>();

  DoubleMapTypeV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory DoubleMapTypeV11.from(Struct origin) => DoubleMapTypeV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name DoubleMapTypeV12 */
class DoubleMapTypeV12 extends DoubleMapTypeV11 {
  DoubleMapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory DoubleMapTypeV12.from(DoubleMapTypeV11 origin) => DoubleMapTypeV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name DoubleMapTypeV9 */
class DoubleMapTypeV9<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV9 get hasher => super.getCodec("hasher").cast<StorageHasherV9>();
  CodecType get key1 => super.getCodec("key1").cast<CodecType>();
  CodecType get key2 => super.getCodec("key2").cast<CodecType>();
  CodecType get thisValue => super.getCodec("value").cast<CodecType>();
  StorageHasherV9 get key2Hasher => super.getCodec("key2Hasher").cast<StorageHasherV9>();

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
  factory ErrorMetadataV10.from(ErrorMetadataV10 origin) => ErrorMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV11 */
class ErrorMetadataV11 extends ErrorMetadataV10 {
  ErrorMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataV11.from(ErrorMetadataV10 origin) => ErrorMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV12 */
class ErrorMetadataV12 extends ErrorMetadataV11 {
  ErrorMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ErrorMetadataV12.from(ErrorMetadataV11 origin) => ErrorMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ErrorMetadataV9 */
class ErrorMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get hasher => super.getCodec("hasher").cast<CodecText>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

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
  factory EventMetadataLatest.from(EventMetadataV12 origin) => EventMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV10 */
class EventMetadataV10 extends EventMetadataV9 {
  EventMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV10.from(EventMetadataV9 origin) => EventMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV11 */
class EventMetadataV11 extends EventMetadataV10 {
  EventMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV11.from(EventMetadataV10 origin) => EventMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV12 */
class EventMetadataV12 extends EventMetadataV11 {
  EventMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory EventMetadataV12.from(EventMetadataV11 origin) => EventMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name EventMetadataV9 */
class EventMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<CodecType> get args => super.getCodec("args").cast<Vec<CodecType>>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

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
  factory ExtrinsicMetadataLatest.from(ExtrinsicMetadataV12 origin) => ExtrinsicMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ExtrinsicMetadataV11 */
class ExtrinsicMetadataV11<S extends Map<String, dynamic>> extends Struct {
  u8 get version => super.getCodec("version").cast<u8>();
  Vec<CodecText> get signedExtensions => super.getCodec("signedExtensions").cast<Vec<CodecText>>();

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
  factory ExtrinsicMetadataV12.from(ExtrinsicMetadataV11 origin) => ExtrinsicMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataLatest */
class FunctionArgumentMetadataLatest extends FunctionArgumentMetadataV12 {
  FunctionArgumentMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataLatest.from(FunctionArgumentMetadataV12 origin) =>
      FunctionArgumentMetadataLatest(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV10 */
class FunctionArgumentMetadataV10 extends FunctionArgumentMetadataV9 {
  FunctionArgumentMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV10.from(FunctionArgumentMetadataV9 origin) =>
      FunctionArgumentMetadataV10(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV11 */
class FunctionArgumentMetadataV11 extends FunctionArgumentMetadataV10 {
  FunctionArgumentMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV11.from(FunctionArgumentMetadataV10 origin) =>
      FunctionArgumentMetadataV11(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV12 */
class FunctionArgumentMetadataV12 extends FunctionArgumentMetadataV11 {
  FunctionArgumentMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionArgumentMetadataV12.from(FunctionArgumentMetadataV11 origin) =>
      FunctionArgumentMetadataV12(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionArgumentMetadataV9 */
class FunctionArgumentMetadataV9<S extends Map<String, dynamic>> extends Struct {
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
  FunctionMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataLatest.from(FunctionMetadataV12 origin) => FunctionMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV10 */
class FunctionMetadataV10 extends FunctionMetadataV9 {
  FunctionMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV10.from(FunctionMetadataV9 origin) => FunctionMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV11 */
class FunctionMetadataV11 extends FunctionMetadataV10 {
  FunctionMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV11.from(FunctionMetadataV10 origin) => FunctionMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV12 */
class FunctionMetadataV12 extends FunctionMetadataV11 {
  FunctionMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory FunctionMetadataV12.from(FunctionMetadataV11 origin) => FunctionMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name FunctionMetadataV9 */
class FunctionMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Vec<FunctionArgumentMetadataV9> get args =>
      super.getCodec("args").cast<Vec<FunctionArgumentMetadataV9>>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

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
  factory MapTypeLatest.from(MapTypeV12 origin) =>
      MapTypeLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MapTypeV10 */
class MapTypeV10<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV10 get hasher => super.getCodec("hasher").cast<StorageHasherV10>();
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
class MapTypeV11<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV11 get hasher => super.getCodec("hasher").cast<StorageHasherV11>();
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
  factory MapTypeV12.from(MapTypeV11 origin) =>
      MapTypeV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MapTypeV9 */
class MapTypeV9<S extends Map<String, dynamic>> extends Struct {
  StorageHasherV9 get hasher => super.getCodec("hasher").cast<StorageHasherV9>();
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
  MetadataV9 get asV9 => super.askey("V9").cast<MetadataV9>();
  bool get isV10 => super.isKey("V10");
  MetadataV10 get asV10 => super.askey("V10").cast<MetadataV10>();
  bool get isV11 => super.isKey("V11");
  MetadataV11 get asV11 => super.askey("V11").cast<MetadataV11>();
  bool get isV12 => super.isKey("V12");
  MetadataV12 get asV12 => super.askey("V12").cast<MetadataV12>();
}

/// @name MetadataLatest */
class MetadataLatest extends MetadataV12 {
  MetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory MetadataLatest.from(MetadataV12 origin) =>
      MetadataLatest(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV10 */
class MetadataV10<S extends Map<String, dynamic>> extends Struct {
  Vec<ModuleMetadataV10> get modules => super.getCodec("modules").cast<Vec<ModuleMetadataV10>>();

  MetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV10.from(Struct origin) =>
      MetadataV10(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV11 */
class MetadataV11<S extends Map<String, dynamic>> extends Struct {
  Vec<ModuleMetadataV11> get modules => super.getCodec("modules").cast<Vec<ModuleMetadataV11>>();
  ExtrinsicMetadataV11 get extrinsic => super.getCodec("extrinsic").cast<ExtrinsicMetadataV11>();

  MetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV11.from(Struct origin) =>
      MetadataV11(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV12 */
class MetadataV12<S extends Map<String, dynamic>> extends Struct {
  Vec<ModuleMetadataV12> get modules => super.getCodec("modules").cast<Vec<ModuleMetadataV12>>();
  ExtrinsicMetadataV12 get extrinsic => super.getCodec("extrinsic").cast<ExtrinsicMetadataV12>();

  MetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MetadataV12.from(Struct origin) =>
      MetadataV12(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name MetadataV9 */
class MetadataV9<S extends Map<String, dynamic>> extends Struct {
  Vec<ModuleMetadataV9> get modules => super.getCodec("modules").cast<Vec<ModuleMetadataV9>>();

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
  factory ModuleConstantMetadataLatest.from(ModuleConstantMetadataV12 origin) =>
      ModuleConstantMetadataLatest(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV10 */
class ModuleConstantMetadataV10 extends ModuleConstantMetadataV9 {
  ModuleConstantMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV10.from(ModuleConstantMetadataV9 origin) =>
      ModuleConstantMetadataV10(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV11 */
class ModuleConstantMetadataV11 extends ModuleConstantMetadataV10 {
  ModuleConstantMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV11.from(ModuleConstantMetadataV10 origin) =>
      ModuleConstantMetadataV11(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV12 */
class ModuleConstantMetadataV12 extends ModuleConstantMetadataV11 {
  ModuleConstantMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleConstantMetadataV12.from(ModuleConstantMetadataV11 origin) =>
      ModuleConstantMetadataV12(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleConstantMetadataV9 */
class ModuleConstantMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  CodecType get type => super.getCodec("type").cast<CodecType>();
  Bytes get thisValue => super.getCodec("value").cast<Bytes>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

  ModuleConstantMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleConstantMetadataV9.from(Struct origin) => ModuleConstantMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleMetadataLatest */
class ModuleMetadataLatest extends ModuleMetadataV12 {
  ModuleMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory ModuleMetadataLatest.from(ModuleMetadataV12 origin) => ModuleMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleMetadataV10 */
class ModuleMetadataV10<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Option<StorageMetadataV10> get storage =>
      super.getCodec("storage").cast<Option<StorageMetadataV10>>();
  Option<Vec<FunctionMetadataV10>> get calls =>
      super.getCodec("calls").cast<Option<Vec<FunctionMetadataV10>>>();
  Option<Vec<EventMetadataV10>> get events =>
      super.getCodec("events").cast<Option<Vec<EventMetadataV10>>>();
  Vec<ModuleConstantMetadataV10> get constants =>
      super.getCodec("constants").cast<Vec<ModuleConstantMetadataV10>>();
  Vec<ErrorMetadataV10> get errors => super.getCodec("errors").cast<Vec<ErrorMetadataV10>>();

  ModuleMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV10.from(Struct origin) => ModuleMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleMetadataV11 */
class ModuleMetadataV11<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Option<StorageMetadataV11> get storage =>
      super.getCodec("storage").cast<Option<StorageMetadataV11>>();
  Option<Vec<FunctionMetadataV11>> get calls =>
      super.getCodec("calls").cast<Option<Vec<FunctionMetadataV11>>>();
  Option<Vec<EventMetadataV11>> get events =>
      super.getCodec("events").cast<Option<Vec<EventMetadataV11>>>();
  Vec<ModuleConstantMetadataV11> get constants =>
      super.getCodec("constants").cast<Vec<ModuleConstantMetadataV11>>();
  Vec<ErrorMetadataV11> get errors => super.getCodec("errors").cast<Vec<ErrorMetadataV11>>();

  ModuleMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV11.from(Struct origin) => ModuleMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleMetadataV12 */
class ModuleMetadataV12<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Option<StorageMetadataV12> get storage =>
      super.getCodec("storage").cast<Option<StorageMetadataV12>>();
  Option<Vec<FunctionMetadataV12>> get calls =>
      super.getCodec("calls").cast<Option<Vec<FunctionMetadataV12>>>();
  Option<Vec<EventMetadataV12>> get events =>
      super.getCodec("events").cast<Option<Vec<EventMetadataV12>>>();
  Vec<ModuleConstantMetadataV12> get constants =>
      super.getCodec("constants").cast<Vec<ModuleConstantMetadataV12>>();
  Vec<ErrorMetadataV12> get errors => super.getCodec("errors").cast<Vec<ErrorMetadataV12>>();
  u8 get index => super.getCodec("index").cast<u8>();

  ModuleMetadataV12(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV12.from(Struct origin) => ModuleMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name ModuleMetadataV9 */
class ModuleMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  Option<StorageMetadataV9> get storage =>
      super.getCodec("storage").cast<Option<StorageMetadataV9>>();
  Option<Vec<FunctionMetadataV9>> get calls =>
      super.getCodec("calls").cast<Option<Vec<FunctionMetadataV9>>>();
  Option<Vec<EventMetadataV9>> get events =>
      super.getCodec("events").cast<Option<Vec<EventMetadataV9>>>();
  Vec<ModuleConstantMetadataV9> get constants =>
      super.getCodec("constants").cast<Vec<ModuleConstantMetadataV9>>();
  Vec<ErrorMetadataV9> get errors => super.getCodec("errors").cast<Vec<ErrorMetadataV9>>();

  ModuleMetadataV9(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ModuleMetadataV9.from(Struct origin) => ModuleMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataLatest */
class StorageEntryMetadataLatest extends StorageEntryMetadataV12 {
  StorageEntryMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageEntryMetadataLatest.from(StorageEntryMetadataV12 origin) =>
      StorageEntryMetadataLatest(
          origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV10 */
class StorageEntryMetadataV10<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV10 get modifier =>
      super.getCodec("modifier").cast<StorageEntryModifierV10>();
  StorageEntryTypeV10 get type => super.getCodec("type").cast<StorageEntryTypeV10>();
  Bytes get fallback => super.getCodec("fallback").cast<Bytes>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

  StorageEntryMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageEntryMetadataV10.from(Struct origin) => StorageEntryMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV11 */
class StorageEntryMetadataV11<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV11 get modifier =>
      super.getCodec("modifier").cast<StorageEntryModifierV11>();
  StorageEntryTypeV11 get type => super.getCodec("type").cast<StorageEntryTypeV11>();
  Bytes get fallback => super.getCodec("fallback").cast<Bytes>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

  StorageEntryMetadataV11(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageEntryMetadataV11.from(Struct origin) => StorageEntryMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV12 */
class StorageEntryMetadataV12 extends StorageEntryMetadataV11 {
  StorageEntryMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageEntryMetadataV12.from(StorageEntryMetadataV11 origin) => StorageEntryMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageEntryMetadataV9 */
class StorageEntryMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get name => super.getCodec("name").cast<CodecText>();
  StorageEntryModifierV9 get modifier => super.getCodec("modifier").cast<StorageEntryModifierV9>();
  StorageEntryTypeV9 get type => super.getCodec("type").cast<StorageEntryTypeV9>();
  Bytes get fallback => super.getCodec("fallback").cast<Bytes>();
  Vec<CodecText> get documentation => super.getCodec("documentation").cast<Vec<CodecText>>();

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
}

/// @name StorageEntryModifierV10 */
class StorageEntryModifierV10 extends StorageEntryModifierV9 {
  StorageEntryModifierV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryModifierV11 */
class StorageEntryModifierV11 extends StorageEntryModifierV10 {
  StorageEntryModifierV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageEntryModifierV12 */
class StorageEntryModifierV12 extends StorageEntryModifierV11 {
  StorageEntryModifierV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
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
  factory StorageEntryTypeLatest.from(StorageEntryTypeV12 origin) =>
      StorageEntryTypeLatest(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageEntryTypeV10 */
class StorageEntryTypeV10 extends Enum {
  StorageEntryTypeV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeV10.from(Enum origin) =>
      StorageEntryTypeV10(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV10 get asMap => super.askey("Map").cast<MapTypeV10>();
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV10 get asDoubleMap => super.askey("DoubleMap").cast<DoubleMapTypeV10>();
}

// /** @name StorageEntryTypeV11 */
class StorageEntryTypeV11 extends Enum {
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV11 get asMap => super.askey("Map").cast<MapTypeV11>();
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV11 get asDoubleMap => super.askey("DoubleMap").cast<DoubleMapTypeV11>();

  StorageEntryTypeV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeV11.from(Enum origin) =>
      StorageEntryTypeV11(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

// /** @name StorageEntryTypeV12 */
class StorageEntryTypeV12 extends StorageEntryTypeV11 {
  StorageEntryTypeV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeV12.from(StorageEntryTypeV11 origin) =>
      StorageEntryTypeV12(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageEntryTypeV9 */
class StorageEntryTypeV9 extends Enum {
  bool get isPlain => super.isKey("Plain");
  CodecType get asPlain => super.askey("Plain").cast<CodecType>();
  bool get isMap => super.isKey("Map");
  MapTypeV9 get asMap => super.askey("Map").cast<MapTypeV9>();
  bool get isDoubleMap => super.isKey("DoubleMap");
  DoubleMapTypeV9 get asDoubleMap => super.askey("DoubleMap").cast<DoubleMapTypeV9>();

  StorageEntryTypeV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageEntryTypeV9.from(Enum origin) =>
      StorageEntryTypeV9(origin.registry, origin.def, origin.originValue, origin.originIndex);
}

/// @name StorageHasher */
class StorageHasher extends StorageHasherV12 {
  StorageHasher(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
  factory StorageHasher.from(StorageHasherV12 origin) =>
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
  factory StorageHasherV12.from(StorageHasherV11 origin) =>
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
  StorageMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataLatest.from(StorageMetadataV12 origin) => StorageMetadataLatest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV10 */
class StorageMetadataV10<S extends Map<String, dynamic>> extends Struct {
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV10> get items =>
      super.getCodec("items").cast<Vec<StorageEntryMetadataV10>>();

  StorageMetadataV10(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory StorageMetadataV10.from(Struct origin) => StorageMetadataV10(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV11 */
class StorageMetadataV11<S extends Map<String, dynamic>> extends Struct {
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV11> get items =>
      super.getCodec("items").cast<Vec<StorageEntryMetadataV11>>();

  StorageMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV11.from(Struct origin) => StorageMetadataV11(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV12 */
class StorageMetadataV12 extends StorageMetadataV11 {
  StorageMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV12.from(StorageMetadataV11 origin) => StorageMetadataV12(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/// @name StorageMetadataV9 */
class StorageMetadataV9<S extends Map<String, dynamic>> extends Struct {
  CodecText get prefix => super.getCodec("prefix").cast<CodecText>();
  Vec<StorageEntryMetadataV9> get items =>
      super.getCodec("items").cast<Vec<StorageEntryMetadataV9>>();

  StorageMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
  factory StorageMetadataV9.from(Struct origin) => StorageMetadataV9(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// export type PHANTOM_METADATA = 'metadata';
