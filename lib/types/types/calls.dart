import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';

abstract class CallBase {
  Uint8List callIndex;
  FunctionMetadataLatest meta; // ;
  String method;
  String section;
  dynamic Function() toJSON;
  Call call; //(...args: any[]) ;
  bool isCall(Call tx);
}

abstract class CallFunction extends CallBase {
  Call callFunction(List<dynamic> args);
}

// export type Calls = Record<string, CallFunction>;
// export type ModulesWithCalls = Record<string, Calls>;
