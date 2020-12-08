import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

DoNotConstruct Function(Registry, [dynamic]) doNotConstructWith([String typeName]) {
  return (Registry registry, [dynamic nullVal]) => DoNotConstruct(registry, typeName);
}

class DoNotConstruct extends CodecNull {
  DoNotConstruct(Registry registry, [String typeName = 'DoNotConstruct']) : super(registry) {
    throw "Cannot construct unknown type $encodedLength";
  }
  static DoNotConstruct constructor(Registry registry, [dynamic typeName = 'DoNotConstruct']) =>
      DoNotConstruct(registry, typeName);
  static Constructor<DoNotConstruct> withParams([String typeName]) => doNotConstructWith(typeName);
}
