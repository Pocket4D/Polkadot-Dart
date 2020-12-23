import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

abstract class CallBase {
  Uint8List callIndex;
  FunctionMetadataLatest meta; // ;
  String method;
  String section;
  dynamic Function() toJSON;
}

abstract class CallFunction extends CallBase {
  Call call; //(...args: any[]) ;
  T callFunction<T extends BaseCodec>(List<dynamic> args);
}

// export type Calls = Record<string, CallFunction>;
// export type ModulesWithCalls = Record<string, Calls>;
