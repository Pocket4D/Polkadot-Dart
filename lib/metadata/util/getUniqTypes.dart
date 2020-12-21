import 'package:polkadot_dart/metadata/util/fluttenUniq.dart';
import 'package:polkadot_dart/metadata/util/validateTypes.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

abstract class Arg extends BaseCodec {
  CodecType type;
}

abstract class DoubleMap {
  CodecText key1;
  CodecText key2;
  CodecText value;
}

abstract class AsMap {
  CodecText key;
  CodecText value;
}

abstract class ItemType {
  bool isDoubleMap;
  bool isMap;
  bool isPlain;
  DoubleMap asDoubleMap;
  AsMap asMap;
  CodecText asPlain;
}

abstract class Item extends BaseCodec {
  ItemType type;
}

abstract class Items extends BaseCodec {
  Vec<Item> functions;
  Vec<Item> items;
}

abstract class Call extends BaseCodec {
  Vec<Arg> args;
}

// type Calls = Option<Vec<Call>>;

abstract class Event extends BaseCodec {
  Vec<Arg> args;
}

// type Events = Option<Vec<Event>>;

abstract class CallFunctions {
  Vec<Call> functions;
}

abstract class ConstantText extends BaseCodec {
  CodecText type;
}

abstract class ModuleCall {
  CallFunctions call;
}

abstract class Module extends BaseCodec {
  ModuleCall module;
  Option<Vec<Call>> calls;
  Vec<ConstantText> constants;
  Option<Vec<Event>> events;
  dynamic storage; // Option<Vec<Item> | Items
}

abstract class OuterEvent {
  Vec<ITuple<CodecText, Vec<Event>>> events;
}

// [Text, Vec<Event>] & Codec

abstract class ExtractionMetadata {
  Vec<Module> modules;
  OuterEvent outerEvent;
}

List<Call> unwrapCalls(Module mod) {
  return mod.calls != null
      ? mod.calls.unwrapOr([])
      // V0
      : mod.module != null
          ? mod.module.call.functions
          : [];
}

// /** @internal */
List<List<List<String>>> getCallNames(ExtractionMetadata extractionMetadata) {
  return extractionMetadata.modules
      .map((mod, [index, list]) => unwrapCalls(mod)
          .map((call) => call.args.map((arg, [index, list]) => arg.type.toString()).toList())
          .toList())
      .toList();
}

// /** @internal */
List<List<String>> getConstantNames(ExtractionMetadata extractionMetadata) {
  return extractionMetadata.modules
      .map((mod, [index, list]) => mod.constants != null
          ? mod.constants.map((constant, [index, list]) => constant.type.toString()).toList()
          : [])
      .toList();
}

// /** @internal */
List<Event> unwrapEvents(Option<Vec<Event>> events) {
  if (events == null) {
    return [];
  }

  return events.unwrapOr([]);
}

// /** @internal */
List<List<List<String>>> getEventNames(ExtractionMetadata extractionMetadata) {
  final mapArg = (Event event, [int i, List<Event> all]) =>
      event.args.map((arg, [index, list]) => arg.toString()).toList();

  // V0
  if (extractionMetadata.outerEvent != null) {
    return extractionMetadata.outerEvent.events
        .map((tuple, [index, list]) => tuple.item2.map(mapArg))
        .toList();
  }

  // V1+
  return extractionMetadata.modules
      .map((module, [index, list]) => unwrapEvents(module.events).map(mapArg))
      .toList();
}

// /** @internal */
List<Item> unwrapStorage(dynamic storage) {
  if (storage == null) {
    return [];
  }

  if (storage is Option<Vec<Item>>) {
    return storage.unwrapOr([]);
  } else if (storage is Items) {
    return storage.items.value ?? storage.functions.value;
  }
  throw "Cannot unwrap Storage with $storage";
}

// /** @internal */
List<List<List<String>>> getStorageNames(ExtractionMetadata extractionMetadata) {
  return extractionMetadata.modules
      .map((module, [index, list]) => unwrapStorage(module.storage).map((item) {
            if (item.type.isDoubleMap != null && item.type.asDoubleMap != null) {
              return [
                item.type.asDoubleMap.key1.toString(),
                item.type.asDoubleMap.key2.toString(),
                item.type.asDoubleMap.value.toString()
              ];
            } else if (item.type.isMap) {
              return [item.type.asMap.key.toString(), item.type.asMap.value.toString()];
            } else {
              return [item.type.asPlain.toString()];
            }
          }));
}

/** @internal */
List<String> getUniqTypes(Registry registry, ExtractionMetadata meta, bool throwError) {
  final types = flattenUniq(
      [getCallNames(meta), getConstantNames(meta), getEventNames(meta), getStorageNames(meta)]);

  validateTypes(registry, types, throwError);

  return types;
}
