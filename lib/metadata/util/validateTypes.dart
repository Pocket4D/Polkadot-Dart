import 'package:polkadot_dart/metadata/util/extractTypes.dart';
import 'package:polkadot_dart/metadata/util/fluttenUniq.dart';
import 'package:polkadot_dart/types/types.dart';

void validateTypes(Registry registry, List<String> types, bool throwError) {
  final missing =
      flattenUniq(extractTypes(types)).where((type) => !registry.hasType(type)).toList();

  if (missing.length != 0) {
    final message = "Unknown types found, no types for ${missing.join(', ')}";

    if (throwError) {
      throw message;
    } else {
      print(message);
    }
  }
}
