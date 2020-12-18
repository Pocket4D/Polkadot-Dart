// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// RuntimeDispatchInfo
class RuntimeDispatchInfo extends Struct {
  Weight get weight => super.getCodec("weight").cast<Weight>();

  DispatchClass get classOf => super.getCodec("class").cast<DispatchClass>();

  Balance get partialFee => super.getCodec("partialFee").cast<Balance>();

  RuntimeDispatchInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "weight": "Weight",
              "class": "DispatchClass",
              "partialFee": "Balance"
            },
            value,
            jsonMap);

  factory RuntimeDispatchInfo.from(Struct origin) => RuntimeDispatchInfo(
      origin.registry, origin.originValue, origin.originJsonMap);
}
