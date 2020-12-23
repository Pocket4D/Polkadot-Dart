import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';

abstract class ConstantCodec extends BaseCodec {
  ModuleConstantMetadataLatest meta;
}

//export type ModuleConstants = Record<string, ConstantCodec>

//export type ModuleExtrinsics = Record<string, CallFunction>;

//export type ModuleStorage = Record<string, StorageEntry>

//export type Constants = Record<string, ModuleConstants>;

//export type Extrinsics = Record<string, ModuleExtrinsics>

//export type Storage = Record<string, ModuleStorage>;

abstract class  DecoratedMeta {
  Map<String,Map<String,ConstantCodec>>consts;
  Map<String,Map<String,StorageEntry>>query;
  Map<String,Map<String,CallFunction>>tx;
}