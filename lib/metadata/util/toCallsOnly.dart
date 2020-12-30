import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

abstract class ModuleMetadataTrimmed {
  Option<Vec<FunctionMetadataLatest>> calls;
  u8 index;
  CodecText name;
}

List<String> trimDocs(Vec<CodecText> documentation) {
  final strings = documentation.map((doc, [index, list]) => doc.toString().trim()).toList();
  final firstEmpty = strings.indexWhere((doc) => doc.length == 0);

  return firstEmpty == -1 ? strings : strings.sublist(0, firstEmpty);
}

Option<Vec<FunctionMetadataLatest>> mapCalls(
    Registry registry, Option<Vec<FunctionMetadataLatest>> _calls) {
  final calls = _calls.unwrapOr(null);

  return registry.createType(
      'Option<Vec<FunctionMetadataLatest>>',
      calls != null
          ? (calls as Vec<FunctionMetadataLatest>)
              .map((metaFunction, [index, list]) => registry.createType('FunctionMetadataLatest', {
                    "args": metaFunction.args,
                    "documentation": trimDocs(metaFunction.documentation),
                    "name": metaFunction.name
                  }))
          : null) as Option<Vec<FunctionMetadataLatest>>;
}

dynamic toCallsOnly(Registry registry, MetadataLatest metadataLatest) {
  return registry.createType('MetadataLatest', {
    "extrinsic": metadataLatest.extrinsic,
    "modules": metadataLatest.modules.map((moduleTrimmed, [index, list]) => ({
          "calls": mapCalls(registry, moduleTrimmed.calls),
          "index": moduleTrimmed.index,
          "name": moduleTrimmed.name
        }))
  }).toJSON();
}
