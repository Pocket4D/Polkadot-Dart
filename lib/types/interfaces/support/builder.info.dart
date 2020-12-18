// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// WeightToFeeCoefficient
class WeightToFeeCoefficient extends Struct {
  Balance get coeffInteger => super.getCodec("coeffInteger").cast<Balance>();

  Perbill get coeffFrac => super.getCodec("coeffFrac").cast<Perbill>();

  bool get negative => super.getCodec("negative").cast<CodecBool>().value;

  u8 get degree => super.getCodec("degree").cast<u8>();

  WeightToFeeCoefficient(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "coeffInteger": "Balance",
              "coeffFrac": "Perbill",
              "negative": "bool",
              "degree": "u8"
            },
            value,
            jsonMap);

  factory WeightToFeeCoefficient.from(Struct origin) => WeightToFeeCoefficient(
      origin.registry, origin.originValue, origin.originJsonMap);
}
