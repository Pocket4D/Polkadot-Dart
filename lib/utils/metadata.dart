// To parse this JSON data, do
//
//     final metadataJson = MetaDataJson.fromMap(jsonString);

import 'dart:convert';

class MetaDataJson {
  MetaDataJson({
    this.magicNumber,
    this.metadata,
  });

  int magicNumber;
  Metadata metadata;

  MetaDataJson copyWith({
    int magicNumber,
    Metadata metadata,
  }) =>
      MetaDataJson(
        magicNumber: magicNumber ?? this.magicNumber,
        metadata: metadata ?? this.metadata,
      );

  factory MetaDataJson.fromJson(String str) => MetaDataJson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaDataJson.fromMap(Map<String, dynamic> json) => MetaDataJson(
        magicNumber: json["magicNumber"],
        metadata: Metadata.fromMap(json["metadata"]),
      );

  Map<String, dynamic> toMap() => {
        "magicNumber": magicNumber,
        "metadata": metadata.toMap(),
      };
}

class Metadata {
  Metadata({this.version, this.versionKey});

  Version version;
  String versionKey;

  Metadata copyWith({Version version, String versionKey}) => Metadata(
        version: version ?? this.version,
      );

  factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Metadata.fromMap(Map<String, dynamic> json) {
    var keyIter = json.keys.where((element) {
      return element.startsWith("V") && (int.tryParse(element.substring(1)) is int);
    });

    if (keyIter.length > 0) {
      return Metadata(
          version: Version.fromMap(json["${keyIter.toList().last}"]),
          versionKey: keyIter.toList().last);
    } else {
      throw "Error: MetaData Version is not exist";
    }
  }

  Map<String, dynamic> toMap() => {
        versionKey: version.toMap(),
      };
}

class Version {
  Version({
    this.modules,
    this.extrinsic,
  });

  List<Module> modules;
  Extrinsic extrinsic;

  Version copyWith({
    List<Module> modules,
    Extrinsic extrinsic,
  }) =>
      Version(
        modules: modules ?? this.modules,
        extrinsic: extrinsic ?? this.extrinsic,
      );

  factory Version.fromJson(String str) => Version.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Version.fromMap(Map<String, dynamic> json) => Version(
        modules: List<Module>.from(json["modules"].map((x) => Module.fromMap(x))),
        extrinsic: Extrinsic.fromMap(json["extrinsic"]),
      );

  Map<String, dynamic> toMap() => {
        "modules": List<dynamic>.from(modules.map((x) => x.toMap())),
        "extrinsic": extrinsic.toMap(),
      };
}

class Extrinsic {
  Extrinsic({
    this.version,
    this.signedExtensions,
  });

  int version;
  List<String> signedExtensions;

  Extrinsic copyWith({
    int version,
    List<String> signedExtensions,
  }) =>
      Extrinsic(
        version: version ?? this.version,
        signedExtensions: signedExtensions ?? this.signedExtensions,
      );

  factory Extrinsic.fromJson(String str) => Extrinsic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extrinsic.fromMap(Map<String, dynamic> json) => Extrinsic(
        version: json["version"],
        signedExtensions: List<String>.from(json["signedExtensions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "version": version,
        "signedExtensions": List<dynamic>.from(signedExtensions.map((x) => x)),
      };
}

class Module {
  Module({
    this.name,
    this.storage,
    this.calls,
    this.events,
    this.constants,
    this.errors,
    this.index,
  });

  String name;
  Storage storage;
  List<Call> calls;
  List<Event> events;
  List<Constant> constants;
  List<Error> errors;
  int index;

  Module copyWith({
    String name,
    Storage storage,
    List<Call> calls,
    List<Event> events,
    List<Constant> constants,
    List<Error> errors,
    int index,
  }) =>
      Module(
        name: name ?? this.name,
        storage: storage ?? this.storage,
        calls: calls ?? this.calls,
        events: events ?? this.events,
        constants: constants ?? this.constants,
        errors: errors ?? this.errors,
        index: index ?? this.index,
      );

  factory Module.fromJson(String str) => Module.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Module.fromMap(Map<String, dynamic> json) => Module(
        name: json["name"],
        storage: json["storage"] == null ? null : Storage.fromMap(json["storage"]),
        calls: json["calls"] == null
            ? null
            : List<Call>.from(json["calls"].map((x) => Call.fromMap(x))),
        events: json["events"] == null
            ? null
            : List<Event>.from(json["events"].map((x) => Event.fromMap(x))),
        constants: List<Constant>.from(json["constants"].map((x) => Constant.fromMap(x))),
        errors: List<Error>.from(json["errors"].map((x) => Error.fromMap(x))),
        index: json["index"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "storage": storage == null ? null : storage.toMap(),
        "calls": calls == null ? null : List<dynamic>.from(calls.map((x) => x.toMap())),
        "events": events == null ? null : List<dynamic>.from(events.map((x) => x.toMap())),
        "constants": List<dynamic>.from(constants.map((x) => x.toMap())),
        "errors": List<dynamic>.from(errors.map((x) => x.toMap())),
        "index": index,
      };
}

class Call {
  Call({
    this.name,
    this.args,
    this.documentation,
  });

  String name;
  List<Arg> args;
  List<String> documentation;

  Call copyWith({
    String name,
    List<Arg> args,
    List<String> documentation,
  }) =>
      Call(
        name: name ?? this.name,
        args: args ?? this.args,
        documentation: documentation ?? this.documentation,
      );

  factory Call.fromJson(String str) => Call.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Call.fromMap(Map<String, dynamic> json) => Call(
        name: json["name"],
        args: List<Arg>.from(json["args"].map((x) => Arg.fromMap(x))),
        documentation: List<String>.from(json["documentation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "args": List<dynamic>.from(args.map((x) => x.toMap())),
        "documentation": List<dynamic>.from(documentation.map((x) => x)),
      };
}

class Arg {
  Arg({
    this.name,
    this.type,
  });

  String name;
  String type;

  Arg copyWith({
    String name,
    String type,
  }) =>
      Arg(
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory Arg.fromJson(String str) => Arg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Arg.fromMap(Map<String, dynamic> json) => Arg(
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
      };
}

class Constant {
  Constant({
    this.name,
    this.type,
    this.value,
    this.documentation,
  });

  String name;
  String type;
  String value;
  List<String> documentation;

  Constant copyWith({
    String name,
    String type,
    String value,
    List<String> documentation,
  }) =>
      Constant(
        name: name ?? this.name,
        type: type ?? this.type,
        value: value ?? this.value,
        documentation: documentation ?? this.documentation,
      );

  factory Constant.fromJson(String str) => Constant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Constant.fromMap(Map<String, dynamic> json) => Constant(
        name: json["name"],
        type: json["type"],
        value: json["value"],
        documentation: List<String>.from(json["documentation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "value": value,
        "documentation": List<dynamic>.from(documentation.map((x) => x)),
      };
}

class Error {
  Error({
    this.name,
    this.documentation,
  });

  String name;
  List<String> documentation;

  Error copyWith({
    String name,
    List<String> documentation,
  }) =>
      Error(
        name: name ?? this.name,
        documentation: documentation ?? this.documentation,
      );

  factory Error.fromJson(String str) => Error.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Error.fromMap(Map<String, dynamic> json) => Error(
        name: json["name"],
        documentation: List<String>.from(json["documentation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "documentation": List<dynamic>.from(documentation.map((x) => x)),
      };
}

class Event {
  Event({
    this.name,
    this.args,
    this.documentation,
  });

  String name;
  List<String> args;
  List<String> documentation;

  Event copyWith({
    String name,
    List<String> args,
    List<String> documentation,
  }) =>
      Event(
        name: name ?? this.name,
        args: args ?? this.args,
        documentation: documentation ?? this.documentation,
      );

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        name: json["name"],
        args: List<String>.from(json["args"].map((x) => x)),
        documentation: List<String>.from(json["documentation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "args": List<dynamic>.from(args.map((x) => x)),
        "documentation": List<dynamic>.from(documentation.map((x) => x)),
      };
}

class Storage {
  Storage({
    this.prefix,
    this.items,
  });

  String prefix;
  List<Item> items;

  Storage copyWith({
    String prefix,
    List<Item> items,
  }) =>
      Storage(
        prefix: prefix ?? this.prefix,
        items: items ?? this.items,
      );

  factory Storage.fromJson(String str) => Storage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Storage.fromMap(Map<String, dynamic> json) => Storage(
        prefix: json["prefix"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "prefix": prefix,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Item {
  Item({
    this.name,
    this.modifier,
    this.type,
    this.fallback,
    this.documentation,
  });

  String name;
  Modifier modifier;
  Type type;
  String fallback;
  List<String> documentation;

  Item copyWith({
    String name,
    Modifier modifier,
    Type type,
    String fallback,
    List<String> documentation,
  }) =>
      Item(
        name: name ?? this.name,
        modifier: modifier ?? this.modifier,
        type: type ?? this.type,
        fallback: fallback ?? this.fallback,
        documentation: documentation ?? this.documentation,
      );

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        name: json["name"],
        modifier: modifierValues.map[json["modifier"]],
        type: Type.fromMap(json["type"]),
        fallback: json["fallback"],
        documentation: List<String>.from(json["documentation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "modifier": modifierValues.reverse[modifier],
        "type": type.toMap(),
        "fallback": fallback,
        "documentation": List<dynamic>.from(documentation.map((x) => x)),
      };
}

enum Modifier { DEFAULT, OPTIONAL }

final modifierValues = EnumValues({"Default": Modifier.DEFAULT, "Optional": Modifier.OPTIONAL});

class Type {
  Type({
    this.map,
    this.plain,
    this.doubleMap,
  });

  MapClass map;
  String plain;
  DoubleMap doubleMap;

  Type copyWith({
    MapClass map,
    String plain,
    DoubleMap doubleMap,
  }) =>
      Type(
        map: map ?? this.map,
        plain: plain ?? this.plain,
        doubleMap: doubleMap ?? this.doubleMap,
      );

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        map: json["Map"] == null ? null : MapClass.fromMap(json["Map"]),
        plain: json["Plain"] == null ? null : json["Plain"],
        doubleMap: json["DoubleMap"] == null ? null : DoubleMap.fromMap(json["DoubleMap"]),
      );

  Map<String, dynamic> toMap() => {
        "Map": map == null ? null : map.toMap(),
        "Plain": plain == null ? null : plain,
        "DoubleMap": doubleMap == null ? null : doubleMap.toMap(),
      };
}

class DoubleMap {
  DoubleMap({
    this.hasher,
    this.key1,
    this.key2,
    this.value,
    this.key2Hasher,
  });

  Hasher hasher;
  String key1;
  String key2;
  String value;
  Hasher key2Hasher;

  DoubleMap copyWith({
    Hasher hasher,
    String key1,
    String key2,
    String value,
    Hasher key2Hasher,
  }) =>
      DoubleMap(
        hasher: hasher ?? this.hasher,
        key1: key1 ?? this.key1,
        key2: key2 ?? this.key2,
        value: value ?? this.value,
        key2Hasher: key2Hasher ?? this.key2Hasher,
      );

  factory DoubleMap.fromJson(String str) => DoubleMap.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoubleMap.fromMap(Map<String, dynamic> json) => DoubleMap(
        hasher: hasherValues.map[json["hasher"]],
        key1: json["key1"],
        key2: json["key2"],
        value: json["value"],
        key2Hasher: hasherValues.map[json["key2Hasher"]],
      );

  Map<String, dynamic> toMap() => {
        "hasher": hasherValues.reverse[hasher],
        "key1": key1,
        "key2": key2,
        "value": value,
        "key2Hasher": hasherValues.reverse[key2Hasher],
      };
}

enum Hasher { BLAKE2_128_CONCAT, TWOX64_CONCAT, IDENTITY }

final hasherValues = EnumValues({
  "Blake2_128Concat": Hasher.BLAKE2_128_CONCAT,
  "Identity": Hasher.IDENTITY,
  "Twox64Concat": Hasher.TWOX64_CONCAT
});

class MapClass {
  MapClass({
    this.hasher,
    this.key,
    this.value,
    this.linked,
  });

  Hasher hasher;
  String key;
  String value;
  bool linked;

  MapClass copyWith({
    Hasher hasher,
    String key,
    String value,
    bool linked,
  }) =>
      MapClass(
        hasher: hasher ?? this.hasher,
        key: key ?? this.key,
        value: value ?? this.value,
        linked: linked ?? this.linked,
      );

  factory MapClass.fromJson(String str) => MapClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapClass.fromMap(Map<String, dynamic> json) => MapClass(
        hasher: hasherValues.map[json["hasher"]],
        key: json["key"],
        value: json["value"],
        linked: json["linked"],
      );

  Map<String, dynamic> toMap() => {
        "hasher": hasherValues.reverse[hasher],
        "key": key,
        "value": value,
        "linked": linked,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
