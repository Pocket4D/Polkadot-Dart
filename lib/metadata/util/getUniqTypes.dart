import 'dart:typed_data';

import 'package:polkadot_dart/metadata/util/fluttenUniq.dart';
import 'package:polkadot_dart/metadata/util/validateTypes.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

abstract class Arg extends BaseCodec {
  CodecType get type;
}

abstract class DoubleMap {
  CodecText get key1;
  CodecText get key2;
  CodecText get thisValue;
}

abstract class AsMap {
  CodecText get key;
  CodecText get thisValue;
}

abstract class ItemType {
  bool get isDoubleMap;
  bool get isMap;
  bool get isPlain;
  DoubleMap get asDoubleMap;
  AsMap get asMap;
  CodecText get asPlain;
}

abstract class Item extends BaseCodec {
  ItemType get type;
}

abstract class Items extends BaseCodec {
  Vec<Item> get functions;
  Vec<Item> get items;
}

abstract class Call extends BaseCodec {
  Vec<Arg> get args;
}

// type Calls = Option<Vec<Call>>;

abstract class Event extends BaseCodec {
  Vec<CodecType> get args;
}

// type Events = Option<Vec<Event>>;

abstract class CallFunctions {
  Vec<Call> get functions;
}

abstract class ConstantText extends BaseCodec {
  CodecText get type;
}

abstract class ModuleCall {
  CallFunctions get call;
}

abstract class Items2 extends BaseCodec {
  Vec<Item> get functions;
  Vec<Item> get items;
}

abstract class Module extends BaseCodec {
  ModuleCall get module;
  Option<Vec<Call>> get calls;
  Vec<ConstantText> get constants;
  Option<Vec<Event>> get events;
  Option<Items2> get storage; // Option<Vec<Item> | Items
}

class OuterEvent {
  Vec<ITuple<CodecText, Vec<Event>>> events;
  OuterEvent({this.events});
  factory OuterEvent.fromMap(Map<String, dynamic> map) {
    return OuterEvent(events: map["events"]);
  }
}

// [Text, Vec<Event>] & Codec

abstract class ExtractionMetadata {
  Vec<Module> get modules;
  OuterEvent get outerEvent;
  // ExtractionMetadata({this.modules, this.outerEvent});
  // factory ExtractionMetadata.fromMap(Map<String, dynamic> map) {
  //   var _modules = map["modules"];
  //   var outerEvent = map["outerEvent"] is Map ? OuterEvent.fromMap(map["outerEvent"]) : null;
  //   return ExtractionMetadata(modules: _modules, outerEvent: outerEvent);
  // }
}

List<Call> unwrapCalls(Module mod) {
  return mod.calls != null && mod.calls.isSome
      ? mod.calls.unwrap().value
      // V0
      : mod.module != null
          ? mod.module.call.functions.value
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
  var result = extractionMetadata.modules
      .map((mod, [index, list]) => mod.constants != null
          ? mod.constants.map((constant, [index, list]) => constant.type.toString()).toList()
          : List<String>.from([]))
      .toList();

  return result;
}

// /** @internal */
List<Event> unwrapEvents(Option<Vec<Event>> events) {
  if (events == null) {
    return [];
  }

  return events.unwrap().value;
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
      .map((module, [index, list]) => unwrapEvents(module.events).map(mapArg).toList())
      .toList();
}

// /** @internal */
List<Item> unwrapStorage(dynamic storage) {
  if (storage == null || (storage is Option && storage.isEmpty)) {
    return List<Item>.from([]);
  }

  if (storage is Option<Vec<Item>>) {
    return storage.unwrapOr([]);
  } else if (storage is Option<Items2>) {
    return storage.unwrap().items.value ?? storage.unwrap().functions.value;
  }
  throw "Cannot unwrap Storage with $storage";
}

// /** @internal */
List<List<List<String>>> getStorageNames(ExtractionMetadata extractionMetadata) {
  return extractionMetadata.modules
      .map((module, [index, list]) => unwrapStorage(module.storage).map((item) {
            if (item.type.isDoubleMap == true && item.type.asDoubleMap != null) {
              return [
                item.type.asDoubleMap.key1.toString(),
                item.type.asDoubleMap.key2.toString(),
                item.type.asDoubleMap.thisValue.toString()
              ];
            } else if (item.type.isMap) {
              return [item.type.asMap.key.toString(), item.type.asMap.thisValue.toString()];
            } else {
              return [item.type.asPlain.toString()];
            }
          }).toList())
      .toList();
}

/** @internal */
List<String> getUniqTypes(Registry registry, ExtractionMetadata meta, bool throwError) {
  final types = flattenUniq(
      [getCallNames(meta), getConstantNames(meta), getEventNames(meta), getStorageNames(meta)]);

  validateTypes(registry, types, throwError);

  return types;
}
