import 'package:polkadot_dart/types/primitives/Null.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

DoNotConstruct Function(Registry) doNotConstructWith([String typeName]) {
  return (Registry registry) => DoNotConstruct(registry, typeName);
}

class DoNotConstruct extends CodecNull {
  DoNotConstruct(Registry registry, [String typeName = 'DoNotConstruct']) : super(registry) {
    throw "Cannot construct unknown type $encodedLength";
  }
  static Constructor<DoNotConstruct> withParams([String typeName]) => doNotConstructWith(typeName);
}
