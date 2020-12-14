import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

class ExtrinsicOrHash extends Enum {
  ExtrinsicOrHash(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory ExtrinsicOrHash.from(Enum origin) =>
      ExtrinsicOrHash(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isHash => super.isKey("Hash");
  Hash get asHash => super.askey("Hash").cast<Hash>();
  bool get isExtrinsic => super.isKey("Extrinsic");
  Bytes get asExtrinsic => super.askey("Extrinsic").cast<Bytes>();
}

class ExtrinsicStatus extends Enum {
  ExtrinsicStatus(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory ExtrinsicStatus.from(Enum origin) =>
      ExtrinsicStatus(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isFuture => super.isKey("Future");
  bool get isReady => super.isKey("Ready");
  bool get isBroadcast => super.isKey("Broadcast");
  bool get isInBlock => super.isKey("InBlock");
  bool get isRetracted => super.isKey("Retracted");
  bool get isFinalityTimeout => super.isKey("FinalityTimeout");
  bool get isFinalized => super.isKey("Finalized");
  bool get isUsurped => super.isKey("Usurped");
  bool get isDropped => super.isKey("Dropped");
  bool get isInvalid => super.isKey("Invalid");

  Vec<CodecText> get asBroadcast => super.askey("Broadcast").cast<Vec<CodecText>>();
  Hash get asInBlock => super.askey("InBlock").cast<Hash>();
  Hash get asRetracted => super.askey("Retracted").cast<Hash>();
  Hash get asFinalityTimeout => super.askey("FinalityTimeout").cast<Hash>();
  Hash get asFinalized => super.askey("Finalized").cast<Hash>();
  Hash get asUsurped => super.askey("Usurped").cast<Hash>();
}

const PHANTOM_AUTHOR = 'author';
