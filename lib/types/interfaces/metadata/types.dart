import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// /** @name DoubleMapTypeLatest */
abstract class DoubleMapTypeLatest extends DoubleMapTypeV12 {
  DoubleMapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

// /** @name DoubleMapTypeV10 */
abstract class DoubleMapTypeV10 extends Struct {
  StorageHasherV10 hasher;
  CodecType key1;
  CodecType key2;
  CodecType thisValue;
  StorageHasherV10 key2Hasher;

  DoubleMapTypeV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name DoubleMapTypeV11 */
abstract class DoubleMapTypeV11 extends Struct {
  StorageHasherV11 hasher;
  CodecType key1;
  CodecType key2;
  CodecType thisValue;
  StorageHasherV11 key2Hasher;

  DoubleMapTypeV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name DoubleMapTypeV12 */
abstract class DoubleMapTypeV12 extends DoubleMapTypeV11 {
  DoubleMapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name DoubleMapTypeV9 */
abstract class DoubleMapTypeV9 extends Struct {
  StorageHasherV9 hasher;
  CodecType key1;
  CodecType key2;
  CodecType thisValue;
  StorageHasherV9 key2Hasher;

  DoubleMapTypeV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ErrorMetadataV10 */
abstract class ErrorMetadataV10 extends ErrorMetadataV9 {
  ErrorMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ErrorMetadataV11 */
abstract class ErrorMetadataV11 extends ErrorMetadataV10 {
  ErrorMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ErrorMetadataV12 */
abstract class ErrorMetadataV12 extends ErrorMetadataV11 {
  ErrorMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ErrorMetadataV9 */
abstract class ErrorMetadataV9 extends Struct {
  CodecText name;
  Vec<CodecText> documentation;

  ErrorMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name EventMetadataLatest */
abstract class EventMetadataLatest extends EventMetadataV12 {
  EventMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name EventMetadataV10 */
abstract class EventMetadataV10 extends EventMetadataV9 {
  EventMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name EventMetadataV11 */
abstract class EventMetadataV11 extends EventMetadataV10 {
  EventMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name EventMetadataV12 */
abstract class EventMetadataV12 extends EventMetadataV11 {
  EventMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name EventMetadataV9 */
abstract class EventMetadataV9 extends Struct {
  CodecText name;
  Vec<CodecType> args;
  Vec<CodecText> documentation;

  EventMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ExtrinsicMetadataLatest */
abstract class ExtrinsicMetadataLatest extends ExtrinsicMetadataV12 {
  ExtrinsicMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ExtrinsicMetadataV11 */
abstract class ExtrinsicMetadataV11 extends Struct {
  u8 version;
  Vec<CodecText> signedExtensions;

  ExtrinsicMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ExtrinsicMetadataV12 */
abstract class ExtrinsicMetadataV12 extends ExtrinsicMetadataV11 {
  ExtrinsicMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionArgumentMetadataLatest */
abstract class FunctionArgumentMetadataLatest extends FunctionArgumentMetadataV12 {
  FunctionArgumentMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionArgumentMetadataV10 */
abstract class FunctionArgumentMetadataV10 extends FunctionArgumentMetadataV9 {
  FunctionArgumentMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionArgumentMetadataV11 */
abstract class FunctionArgumentMetadataV11 extends FunctionArgumentMetadataV10 {
  FunctionArgumentMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionArgumentMetadataV12 */
abstract class FunctionArgumentMetadataV12 extends FunctionArgumentMetadataV11 {
  FunctionArgumentMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionArgumentMetadataV9 */
abstract class FunctionArgumentMetadataV9 extends Struct {
  CodecText name;
  CodecType type;

  FunctionArgumentMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionMetadataLatest */
abstract class FunctionMetadataLatest extends FunctionMetadataV12 {
  FunctionMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionMetadataV10 */
abstract class FunctionMetadataV10 extends FunctionMetadataV9 {
  FunctionMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionMetadataV11 */
abstract class FunctionMetadataV11 extends FunctionMetadataV10 {
  FunctionMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionMetadataV12 */
abstract class FunctionMetadataV12 extends FunctionMetadataV11 {
  FunctionMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name FunctionMetadataV9 */
abstract class FunctionMetadataV9 extends Struct {
  CodecText name;
  Vec<FunctionArgumentMetadataV9> args;
  Vec<CodecText> documentation;

  FunctionMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MapTypeLatest */
abstract class MapTypeLatest extends MapTypeV12 {
  MapTypeLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MapTypeV10 */
abstract class MapTypeV10 extends Struct {
  StorageHasherV10 hasher;
  CodecType key;
  CodecType thisValue;
  bool linked;

  MapTypeV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MapTypeV11 */
abstract class MapTypeV11 extends Struct {
  StorageHasherV11 hasher;
  CodecType key;
  CodecType thisValue;
  bool linked;

  MapTypeV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MapTypeV12 */
abstract class MapTypeV12 extends MapTypeV11 {
  MapTypeV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MapTypeV9 */
abstract class MapTypeV9 extends Struct {
  StorageHasherV9 hasher;
  CodecType key;
  CodecType thisValue;
  bool linked;

  MapTypeV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MetadataAll */
abstract class MetadataAll extends Enum {
  bool isV9;
  MetadataV9 asV9;
  bool isV10;
  MetadataV10 asV10;
  bool isV11;
  MetadataV11 asV11;
  bool isV12;
  MetadataV12 asV12;

  MetadataAll(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name MetadataLatest */
abstract class MetadataLatest extends MetadataV12 {
  MetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MetadataV10 */
abstract class MetadataV10 extends Struct {
  Vec<ModuleMetadataV10> modules;

  MetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MetadataV11 */
abstract class MetadataV11 extends Struct {
  Vec<ModuleMetadataV11> modules;
  ExtrinsicMetadataV11 extrinsic;

  MetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MetadataV12 */
abstract class MetadataV12 extends Struct {
  Vec<ModuleMetadataV12> modules;
  ExtrinsicMetadataV12 extrinsic;

  MetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name MetadataV9 */
abstract class MetadataV9 extends Struct {
  Vec<ModuleMetadataV9> modules;

  MetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleConstantMetadataLatest */
abstract class ModuleConstantMetadataLatest extends ModuleConstantMetadataV12 {
  ModuleConstantMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleConstantMetadataV10 */
abstract class ModuleConstantMetadataV10 extends ModuleConstantMetadataV9 {
  ModuleConstantMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleConstantMetadataV11 */
abstract class ModuleConstantMetadataV11 extends ModuleConstantMetadataV10 {
  ModuleConstantMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleConstantMetadataV12 */
abstract class ModuleConstantMetadataV12 extends ModuleConstantMetadataV11 {
  ModuleConstantMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleConstantMetadataV9 */
abstract class ModuleConstantMetadataV9 extends Struct {
  CodecText name;
  CodecType type;
  Bytes thisValue;
  Vec<CodecText> documentation;

  ModuleConstantMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleMetadataLatest */
abstract class ModuleMetadataLatest extends ModuleMetadataV12 {
  ModuleMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleMetadataV10 */
abstract class ModuleMetadataV10 extends Struct {
  CodecText name;
  Option<StorageMetadataV10> storage;
  Option<Vec<FunctionMetadataV10>> calls;
  Option<Vec<EventMetadataV10>> events;
  Vec<ModuleConstantMetadataV10> constants;
  Vec<ErrorMetadataV10> errors;

  ModuleMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleMetadataV11 */
abstract class ModuleMetadataV11 extends Struct {
  CodecText name;
  Option<StorageMetadataV11> storage;
  Option<Vec<FunctionMetadataV11>> calls;
  Option<Vec<EventMetadataV11>> events;
  Vec<ModuleConstantMetadataV11> constants;
  Vec<ErrorMetadataV11> errors;

  ModuleMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleMetadataV12 */
abstract class ModuleMetadataV12 extends Struct {
  CodecText name;
  Option<StorageMetadataV12> storage;
  Option<Vec<FunctionMetadataV12>> calls;
  Option<Vec<EventMetadataV12>> events;
  Vec<ModuleConstantMetadataV12> constants;
  Vec<ErrorMetadataV12> errors;
  u8 index;

  ModuleMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name ModuleMetadataV9 */
abstract class ModuleMetadataV9 extends Struct {
  CodecText name;
  Option<StorageMetadataV9> storage;
  Option<Vec<FunctionMetadataV9>> calls;
  Option<Vec<EventMetadataV9>> events;
  Vec<ModuleConstantMetadataV9> constants;
  Vec<ErrorMetadataV9> errors;

  ModuleMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryMetadataLatest */
abstract class StorageEntryMetadataLatest extends StorageEntryMetadataV12 {
  StorageEntryMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryMetadataV10 */
abstract class StorageEntryMetadataV10 extends Struct {
  CodecText name;
  StorageEntryModifierV10 modifier;
  StorageEntryTypeV10 type;
  Bytes fallback;
  Vec<CodecText> documentation;

  StorageEntryMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryMetadataV11 */
abstract class StorageEntryMetadataV11 extends Struct {
  CodecText name;
  StorageEntryModifierV11 modifier;
  StorageEntryTypeV11 type;
  Bytes fallback;
  Vec<CodecText> documentation;

  StorageEntryMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryMetadataV12 */
abstract class StorageEntryMetadataV12 extends StorageEntryMetadataV11 {
  StorageEntryMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryMetadataV9 */
abstract class StorageEntryMetadataV9 extends Struct {
  CodecText name;
  StorageEntryModifierV9 modifier;
  StorageEntryTypeV9 type;
  Bytes fallback;
  Vec<CodecText> documentation;

  StorageEntryMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageEntryModifierLatest */
abstract class StorageEntryModifierLatest extends StorageEntryModifierV12 {
  StorageEntryModifierLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryModifierV10 */
abstract class StorageEntryModifierV10 extends StorageEntryModifierV9 {
  StorageEntryModifierV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryModifierV11 */
abstract class StorageEntryModifierV11 extends StorageEntryModifierV10 {
  StorageEntryModifierV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageEntryModifierV12 */
abstract class StorageEntryModifierV12 extends StorageEntryModifierV11 {
  StorageEntryModifierV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryModifierV9 */
abstract class StorageEntryModifierV9 extends Enum {
  bool isOptional;
  bool isDefault;
  bool isRequired;

  StorageEntryModifierV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryTypeLatest */
abstract class StorageEntryTypeLatest extends StorageEntryTypeV12 {
  StorageEntryTypeLatest(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryTypeV10 */
abstract class StorageEntryTypeV10 extends Enum {
  bool isPlain;
  CodecType asPlain;
  bool isMap;
  MapTypeV10 asMap;
  bool isDoubleMap;
  DoubleMapTypeV10 asDoubleMap;

  StorageEntryTypeV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageEntryTypeV11 */
abstract class StorageEntryTypeV11 extends Enum {
  bool isPlain;
  CodecType asPlain;
  bool isMap;
  MapTypeV11 asMap;
  bool isDoubleMap;
  DoubleMapTypeV11 asDoubleMap;

  StorageEntryTypeV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageEntryTypeV12 */
abstract class StorageEntryTypeV12 extends StorageEntryTypeV11 {
  StorageEntryTypeV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageEntryTypeV9 */
abstract class StorageEntryTypeV9 extends Enum {
  bool isPlain;
  CodecType asPlain;
  bool isMap;
  MapTypeV9 asMap;
  bool isDoubleMap;
  DoubleMapTypeV9 asDoubleMap;

  StorageEntryTypeV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageHasher */
abstract class StorageHasher extends StorageHasherV12 {
  StorageHasher(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageHasherV10 */
abstract class StorageHasherV10 extends Enum {
  bool isBlake2128;
  bool isBlake2256;
  bool isBlake2128Concat;
  bool isTwox128;
  bool isTwox256;
  bool isTwox64Concat;

  StorageHasherV10(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageHasherV11 */
abstract class StorageHasherV11 extends Enum {
  bool isBlake2128;
  bool isBlake2256;
  bool isBlake2128Concat;
  bool isTwox128;
  bool isTwox256;
  bool isTwox64Concat;
  bool isIdentity;

  StorageHasherV11(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageHasherV12 */
abstract class StorageHasherV12 extends StorageHasherV11 {
  StorageHasherV12(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

/// @name StorageHasherV9 */
abstract class StorageHasherV9 extends Enum {
  bool isBlake2128;
  bool isBlake2256;
  bool isTwox128;
  bool isTwox256;
  bool isTwox64Concat;

  StorageHasherV9(Registry registry, def, [dynamic thisValue, int index])
      : super(registry, def, thisValue, index);
}

// /** @name StorageMetadataLatest */
abstract class StorageMetadataLatest extends StorageMetadataV12 {
  StorageMetadataLatest(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageMetadataV10 */
abstract class StorageMetadataV10 extends Struct {
  CodecText prefix;
  Vec<StorageEntryMetadataV10> items;

  StorageMetadataV10(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageMetadataV11 */
abstract class StorageMetadataV11 extends Struct {
  CodecText prefix;
  Vec<StorageEntryMetadataV11> items;

  StorageMetadataV11(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageMetadataV12 */
abstract class StorageMetadataV12 extends StorageMetadataV11 {
  StorageMetadataV12(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

/// @name StorageMetadataV9 */
abstract class StorageMetadataV9 extends Struct {
  CodecText prefix;
  Vec<StorageEntryMetadataV9> items;

  StorageMetadataV9(Registry registry, Map<String, dynamic> types,
      [dynamic thisValue, Map<dynamic, String> jsonMap])
      : super(registry, types, thisValue, jsonMap);
}

// export type PHANTOM_METADATA = 'metadata';
