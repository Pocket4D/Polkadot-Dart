import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/utils/utils.dart';

CallFunction createUnchecked(
    Registry registry, String section, Uint8List callIndex, FunctionMetadataLatest callMetadata) {
  final funcName = stringCamelCase(callMetadata.name.toString());

  // final extrinsicFn = (List<dynamic> args) {
  //   assert(expectedArgs.length == args.length,
  //       "Extrinsic $section.$funcName expects ${expectedArgs.length} arguments, got ${args.length}.");

  //   return registry.createType('Call', [
  //     {"args": args, callIndex: callIndex},
  //     callMetadata
  //   ]);
  // };

  final extrinsicFn = ExtrinsicCallFunction(
      callIndex: callIndex,
      meta: callMetadata,
      method: funcName,
      section: section,
      toJSON: () => callMetadata.toJSON());

  return extrinsicFn;
}

class ExtrinsicCallFunction implements CallFunction {
  Registry registry;

  @override
  Call call;

  @override
  Uint8List callIndex;

  @override
  FunctionMetadataLatest meta;

  @override
  String method;

  @override
  String section;

  @override
  Function() toJSON;
  ExtrinsicCallFunction(
      {this.registry,
      this.call,
      this.callIndex,
      this.meta,
      this.method,
      this.section,
      this.toJSON});
  T callFunction<T extends BaseCodec>(List<dynamic> args) {
    assert(this.meta.args.length == args.length,
        "Extrinsic $section.$method expects ${this.meta.args.length} arguments, got ${args.length}.");

    return registry.createType('Call', [
      {"args": args, callIndex: callIndex},
      this.meta
    ]);
  }
}
