// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// CreatedBlock
class CreatedBlock extends Struct {
  BlockHash get hash => super.getCodec("hash").cast<BlockHash>();

  ImportedAux get aux => super.getCodec("aux").cast<ImportedAux>();

  CreatedBlock(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, {"hash": "BlockHash", "aux": "ImportedAux"}, value,
            jsonMap);

  factory CreatedBlock.from(Struct origin) =>
      CreatedBlock(origin.registry, origin.originValue, origin.originJsonMap);
}

/// ImportedAux
class ImportedAux extends Struct {
  bool get headerOnly => super.getCodec("headerOnly").cast<CodecBool>().value;

  bool get clearJustificationRequests =>
      super.getCodec("clearJustificationRequests").cast<CodecBool>().value;

  bool get needsJustification =>
      super.getCodec("needsJustification").cast<CodecBool>().value;

  bool get badJustification =>
      super.getCodec("badJustification").cast<CodecBool>().value;

  bool get needsFinalityProof =>
      super.getCodec("needsFinalityProof").cast<CodecBool>().value;

  bool get isNewBest => super.getCodec("isNewBest").cast<CodecBool>().value;

  ImportedAux(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "headerOnly": "bool",
              "clearJustificationRequests": "bool",
              "needsJustification": "bool",
              "badJustification": "bool",
              "needsFinalityProof": "bool",
              "isNewBest": "bool"
            },
            value,
            jsonMap);

  factory ImportedAux.from(Struct origin) =>
      ImportedAux(origin.registry, origin.originValue, origin.originJsonMap);
}
