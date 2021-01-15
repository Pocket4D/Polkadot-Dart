import 'dart:typed_data';

import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
import 'package:polkadot_dart/types/codec/Tuple.dart';
import 'package:polkadot_dart/types/interfaces/system/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
// import 'package:polkadot_dart/types/interfaces/builders.dart';
import 'package:polkadot_dart/types/types.dart' hide Event;
import 'package:polkadot_dart/types/types/registry.dart';

class GenericEventData extends Tuple {
  EventMetadataLatest _meta;

  String _method;

  String _section;

  List<TypeDef> _typeDef;
  // List<Constructor> _types;
  GenericEventData.empty() : super.empty();
  GenericEventData(Registry registry, Uint8List value,
      [List<Constructor> types,
      List<TypeDef> typeDef,
      EventMetadataLatest meta,
      String section = '<unknown>',
      String method = '<unknown>'])
      : super(registry, types ?? [], value) {
    // this._types = types ?? [];
    this._meta = meta;
    this._method = method;
    this._section = section;
    this._typeDef = typeDef ?? [];
  }

  static GenericEventData constructor(Registry registry,
          [dynamic value,
          List<Constructor> types,
          List<TypeDef> typeDef,
          Event meta,
          String section = '<unknown>',
          String method = '<unknown>']) =>
      GenericEventData(registry, value as Uint8List, types, typeDef, meta, section, method);

  /// @description The wrapped [[EventMetadata]]
  EventMetadataLatest get meta {
    return this._meta;
  }

  /// @description The method as a string
  String get method {
    return this._method;
  }

  /// @description The section as a string
  String get section {
    return this._section;
  }

  /// @description The [[TypeDef]] for this event
  List<TypeDef> get typeDef {
    return this._typeDef;
  }
}

/// @name GenericEvent
/// @description
/// A representation of a system event. These are generated via the [[Metadata]] interfaces and
/// specific to a specific Substrate runtime
class GenericEvent<S extends Map<String, dynamic>> extends Struct {
  // Currently we _only_ decode from Uint8Array, since we expect it to
  // be used via EventRecord
  GenericEvent.empty() : super.empty();
  GenericEvent(Registry registry, [dynamic _value])
      : super(
            registry,
            {
              "index": EventId,
              "data": GenericEvent.decodeEvent(registry, (_value as Uint8List))["DataType"]
            },
            GenericEvent.decodeEvent(registry, _value as Uint8List)["value"]);
  factory GenericEvent.from(Struct origin) => GenericEvent(origin.registry, origin.originValue);

  static GenericEvent constructor(Registry registry, [dynamic _value]) =>
      GenericEvent(registry, _value);

  static Map<String, dynamic> decodeEvent(Registry registry, Uint8List value) {
    if (value == null) {
      value = Uint8List.fromList([]);
    }
    if (value.length == 0) {
      return {"DataType": CodecNull.constructor};
    }

    final index = value.sublist(0, 2);

    return {
      "DataType": registry.findMetaEvent(index),
      "value": {"data": value.sublist(2), "index": index}
    };
  }

  /// @description The wrapped [[EventData]]
  GenericEventData get data {
    return this.getCodec('data').cast<GenericEventData>();
  }

  /// @description The [[EventId]], identifying the raw event
  EventId get index {
    return this.getCodec('index').cast<EventId>();
  }

  /// @description The [[EventMetadata]] with the documentation
  EventMetadataLatest get meta {
    return this.data.meta;
  }

  /// @description The method string identifying the event
  String get method {
    return this.data.method;
  }

  /// @description The section string identifying the event
  String get section {
    return this.data.section;
  }

  /// @description The [[TypeDef]] for the event
  List<TypeDef> get typeDef {
    return this.data.typeDef;
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  Map<String, dynamic> toHuman([bool isExpanded]) {
    return {
      "method": this.method,
      "section": this.section,
      ...(isExpanded
          ? {"documentation": this.meta.documentation.map((d, [i, list]) => d.toString())}
          : {}),
      ...super.toHuman(isExpanded)
    };
  }
}
