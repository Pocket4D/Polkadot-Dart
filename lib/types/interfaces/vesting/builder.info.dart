// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// VestingInfo
class VestingInfo extends Struct {
  Balance get locked => super.getCodec("locked").cast<Balance>();

  Balance get perBlock => super.getCodec("perBlock").cast<Balance>();

  BlockNumber get startingBlock =>
      super.getCodec("startingBlock").cast<BlockNumber>();

  VestingInfo(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "locked": "Balance",
              "perBlock": "Balance",
              "startingBlock": "BlockNumber"
            },
            value,
            jsonMap);

  factory VestingInfo.from(Struct origin) =>
      VestingInfo(origin.registry, origin.originValue, origin.originJsonMap);
}
