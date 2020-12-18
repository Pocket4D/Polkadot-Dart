// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// RpcMethods
class RpcMethods extends Struct {
  u32 get version => super.getCodec("version").cast<u32>();

  Vec<CodecText> get methods =>
      super.getCodec("methods").cast<Vec<CodecText>>();

  RpcMethods(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"version": "u32", "methods": "Vec<Text>"}, value,
            jsonMap);

  factory RpcMethods.from(Struct origin) =>
      RpcMethods(origin.registry, origin.originValue, origin.originJsonMap);
}
