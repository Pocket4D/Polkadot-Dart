import 'dart:typed_data';

abstract class CallBase {
  Uint8List callIndex;
  dynamic meta; // FunctionMetadataLatest;
  String method;
  String section;
  dynamic Function() toJSON;
}

// abstract class CallFunction extends CallBase {
//   (...args: any[]): Call;
// }

// export type Calls = Record<string, CallFunction>;
// export type ModulesWithCalls = Record<string, Calls>;
