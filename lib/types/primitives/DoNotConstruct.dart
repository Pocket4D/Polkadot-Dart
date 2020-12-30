import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

DoNotConstruct Function(Registry, [dynamic]) doNotConstructWith([String typeName]) {
  return (Registry registry, [dynamic nullVal]) => DoNotConstruct(registry, typeName);
}

class DoNotConstruct extends CodecNull {
  DoNotConstruct(Registry registry, [String typeName = 'DoNotConstruct']) : super(registry) {
    // print("Cannot construct unknown type $encodedLength");
    throw "Cannot construct unknown type $typeName";
  }
  static DoNotConstruct constructor(Registry registry, [dynamic typeName = 'DoNotConstruct']) =>
      DoNotConstruct(registry, typeName);
  static Constructor withParams<T extends DoNotConstruct>([String typeName]) =>
      doNotConstructWith(typeName);
}
