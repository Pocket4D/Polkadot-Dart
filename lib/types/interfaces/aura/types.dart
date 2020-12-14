import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types.dart';

class RawAuraPreDigest<S extends Map<String, dynamic>> extends Struct {
  u64 get slotNumber => super.getCodec("slotNumber") as u64;

  RawAuraPreDigest(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory RawAuraPreDigest.from(Struct origin) => RawAuraPreDigest(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}
