import 'dart:convert';

import 'package:polkadot_dart/metadata/MagicNumber.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/extrinsic/ExtrinsicUnknown.dart';
import 'package:polkadot_dart/types/extrinsic/index.dart';
import 'package:polkadot_dart/types/generic/AccountId.dart';
import 'package:polkadot_dart/types/generic/AccountIndex.dart';
import 'package:polkadot_dart/types/generic/ConsensusEngineId.dart';
import 'package:polkadot_dart/types/generic/Event.dart';
import 'package:polkadot_dart/types/generic/LookupSource.dart';
import 'package:polkadot_dart/types/generic/MultiAddress.dart';
import 'package:polkadot_dart/types/generic/Vote.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata;

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
  factory TypeDef.fromMap(Map<String, dynamic> map) {
    var sub;
    var mapSub = map["sub"];
    if (mapSub is Map<String, dynamic>) {
      sub = TypeDef.fromMap(map["sub"]);
    } else if (mapSub is List) {
      sub = mapSub.map((e) {
        if (e is Map<String, dynamic>) {
          return TypeDef.fromMap(e);
        } else if (e is TypeDef) {
          return e;
        }
      }).toList();
    } else if (mapSub is TypeDef) {
      sub = mapSub;
    }

    return TypeDef(
        alias: map["alias"],
        info: map["info"],
        index: map["index"],
        displayName: map["displayName"],
        length: map["length"],
        name: map["name"],
        namespace: map["namespace"],
        sub: sub,
        type: map["type"]);
  }

  Map<String, dynamic> toMap() {
    var subMap;
    if (this.sub is TypeDef) {
      subMap = this.sub.toMap();
    } else if (this.sub is List<TypeDef>) {
      subMap = this.sub.map((e) => e.toMap()).toList();
    } else {
      subMap = this.sub;
    }
    // TODO: implement toString
    return removeNull({
      "alias": this.alias,
      "info": this.info,
      "index": this.index,
      "name": this.name,
      'displayName': this.displayName,
      "length": this.length,
      "namespace": this.namespace,
      "sub": subMap,
      "type": this.type
    });
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

Map<String, Constructor> baseTypes = {
  'BitVec': BitVec.constructor,
  'bool': CodecBool.constructor,
  'Bool': CodecBool.constructor,
  'Bytes': Bytes.constructor,
  'Data': Data.constructor,
  'DoNotConstruct': DoNotConstruct.constructor,
  'i8': i8.constructor,
  'I8': i8.constructor,
  'i16': i16.constructor,
  'I16': i16.constructor,
  'i32': i32.constructor,
  'I32': i32.constructor,
  'i64': i64.constructor,
  'I64': i64.constructor,
  'i128': i128.constructor,
  'I128': i128.constructor,
  'i256': i256.constructor,
  'I256': i256.constructor,
  'Null': CodecNull.constructor,
  'StorageKey': StorageKey.constructor,
  'Text': CodecText.constructor,
  'Type': CodecType.constructor,
  'u8': u8.constructor,
  'U8': u8.constructor,
  'u16': u16.constructor,
  'U16': u16.constructor,
  'u32': u32.constructor,
  'U32': u32.constructor,
  'u64': u64.constructor,
  'U64': u64.constructor,
  'u128': u128.constructor,
  'U128': u128.constructor,
  'u256': u256.constructor,
  'U256': u256.constructor,
  'usize': usize.constructor,
  'USize': usize.constructor,
  'Raw': Raw.constructor,
  'GenericAccountId': GenericAccountId.constructor,
  'GenericAccountIndex': GenericAccountIndex.constructor,
  'GenericCall': GenericCall.constructor,
  'GenericEventData': GenericEventData.constructor,
  'GenericEvent': GenericEvent.constructor,
  'GenericExtrinsic': GenericExtrinsic.constructor,
  'GenericMortalEra': MortalEra.constructor,
  'GenericImmortalEra': ImmortalEra.constructor,
  'GenericExtrinsicPayload': GenericExtrinsicPayload.constructor,
  'GenericExtrinsicPayloadUnknown': GenericExtrinsicPayloadUnknown.constructor,
  'GenericExtrinsicUnknown': GenericExtrinsicUnknown.constructor,
  'GenericSignerPayload': GenericSignerPayload.constructor,
  'GenericExtrinsicV4': GenericExtrinsicV4.constructor,
  'GenericExtrinsicPayloadV4': GenericExtrinsicPayloadV4.constructor,
  'GenericExtrinsicSignatureV4': GenericExtrinsicSignatureV4.constructor,
  'GenericLookupSource': GenericLookupSource.constructor,
  'GenericMultiAddress': GenericMultiAddress.constructor,
  'GenericVote': GenericVote.constructor,
  'Metadata': Metadata.constructor,
  'MagicNumber': MagicNumber.constructor
};
