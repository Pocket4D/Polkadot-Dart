import 'dart:convert';

enum TypeDefInfo {
  BTreeMap,
  BTreeSet,
  Compact,
  Enum,
  Linkage,
  Option,
  Plain,
  Result,
  Set,
  Struct,
  Tuple,
  Vec,
  VecFixed,
  HashMap,
  Int,
  UInt,
  DoNotConstruct,
  // anything not fully supported(keep this as the last entry)
  Null
}

class TypeDef {
  Map<String, String> alias;
  TypeDefInfo info;
  num index;
  String displayName;
  num length;
  String name;
  String namespace;
  dynamic sub; // TypeDef | TypeDef[];
  String type;
  TypeDef(
      {this.alias,
      this.info,
      this.index,
      this.displayName,
      this.length,
      this.name,
      this.namespace,
      this.sub,
      this.type});
  factory TypeDef.fromMap(Map<String, dynamic> map) => TypeDef(
      alias: map["alias"],
      info: map["info"],
      index: map["index"],
      displayName: map["displayName"],
      length: map["length"],
      name: map["name"],
      namespace: map["namespace"],
      sub: map["sub"],
      type: map["type"]);

  Map<String, dynamic> toMap() {
    // TODO: implement toString
    return {
      "alias": this.alias,
      "info": this.info,
      "index": this.index,
      'displayName': this.displayName,
      "length": this.length,
      "namespace": this.namespace,
      "sub": this.sub,
      "type": this.type
    };
  }

  removeNull(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = Map<String, dynamic>();
    map.forEach((key, value) {
      if (value != null) {
        newMap[key] = value;
      }
    });
    return newMap;
  }
}

bool isNotNested(Iterable<int> counters) {
  return !counters.any((counter) => counter != 0);
}

// safely split a string on ', ' while taking care of any nested occurences
List<String> typeSplit(String type) {
  var cDepth = 0;
  var fDepth = 0;
  var sDepth = 0;
  var tDepth = 0;
  var start = 0;
  List<String> result = [];

  var extract = (int index) {
    if (isNotNested([cDepth, fDepth, sDepth, tDepth])) {
      result.add(type.substring(start, index).trim());
      start = index + 1;
    }
  };

  for (var index = 0; index < type.length; index++) {
    switch (type[index]) {

      // if we are not nested, add the type
      case ',':
        extract(index);
        break;

      // adjust compact/vec(and friends) depth
      case '<':
        cDepth++;
        break;
      case '>':
        cDepth--;
        break;

      // adjust fixed vec depths
      case '[':
        fDepth++;
        break;
      case ']':
        fDepth--;
        break;

      // adjust struct depth
      case '{':
        sDepth++;
        break;
      case '}':
        sDepth--;
        break;

      // adjust tuple depth
      case '(':
        tDepth++;
        break;
      case ')':
        tDepth--;
        break;
    }
  }

  var newArr = [cDepth, fDepth, sDepth, tDepth];

  assert(isNotNested(newArr), throw "Invalid definition(missing terminators) found in $type");
  // the final leg of the journey
  result.add(type.substring(start, type.length).trim());

  return result;
}
