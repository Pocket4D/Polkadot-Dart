import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

class ConstantCodec<T extends BaseCodec> extends BaseCodec {
  ModuleConstantMetadataLatest meta;
  T _value;
  ConstantCodec();
  ConstantCodec.from(T value) {
    _value = value;
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => this.value.encodedLength;

  @override
  bool eq(other) {
    // TODO: implement eq
    this.value.eq(other);
  }

  @override
  // TODO: implement hash
  H256 get hash => this.value.hash;

  @override
  // TODO: implement isEmpty
  bool get isEmpty => this.value.isEmpty;

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    return this.value.toHex(isLe);
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    return this.value.toHuman(isExtended);
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    return this.value.toJSON();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    return this.value.toRawType();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    return this.value.toU8a([isBare]);
  }

  @override
  // TODO: implement value
  T get value => _value;
}

//export type ModuleConstants = Record<string, ConstantCodec>

//export type ModuleExtrinsics = Record<string, CallFunction>;

//export type ModuleStorage = Record<string, StorageEntry>

//export type Constants = Record<string, ModuleConstants>;

//export type Extrinsics = Record<string, ModuleExtrinsics>

//export type Storage = Record<string, ModuleStorage>;

abstract class DecoratedMeta {
  Map<String, Map<String, ConstantCodec>> consts;
  Map<String, Map<String, StorageEntry>> query;
  Map<String, Map<String, CallFunction>> tx;
}
