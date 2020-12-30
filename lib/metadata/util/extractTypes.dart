import 'package:polkadot_dart/types/types.dart';

List<dynamic> extractTypes(List<String> types) {
  return types.map((type) {
    final decoded = getTypeDef(type);

    switch (decoded.info) {
      case TypeDefInfo.Plain:
        return decoded.type;

      case TypeDefInfo.BTreeSet:
      case TypeDefInfo.Compact:
      case TypeDefInfo.Option:
      case TypeDefInfo.Vec:
      case TypeDefInfo.VecFixed:
        return extractTypes(
            [(decoded.sub is TypeDef ? decoded.sub : TypeDef.fromMap(decoded.sub)).type]);

      case TypeDefInfo.BTreeMap:
      case TypeDefInfo.HashMap:
      case TypeDefInfo.Result:
      case TypeDefInfo.Tuple:
        return extractTypes((decoded.sub as List)
            .map((e) => (e is TypeDef ? e : TypeDef.fromMap(e)).type)
            .toList());

      default:
        throw "Unhandled: Unable to create and validate type from $type";
    }
  }).toList();
}
