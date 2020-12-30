// import 'package:polkadot_dart/types/interfaces/types.dart';
// import 'package:polkadot_dart/types/types.dart';

// /** @name BlockAttestations */
// class BlockAttestations<S extends Map<String, dynamic>> extends Struct {
//   CandidateReceipt get receipt => super.getCodec("receipt").cast<CandidateReceipt>();
//   Vec<AccountId> get valid => super.getCodec("valid").cast<Vec<AccountId>>();
//   Vec<AccountId> get invalid => super.getCodec("invalid").cast<Vec<AccountId>>();
//   BlockAttestations(Registry registry, S types,
//       [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
//       : super(registry, types, value, jsonMap);
//   factory BlockAttestations.from(Struct origin) => BlockAttestations(
//       origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
// }

// /** @name IncludedBlocks */
// class IncludedBlocks<S extends Map<String, dynamic>> extends Struct {
//   BlockNumber get actualNumber => super.getCodec("actualNumber").cast<BlockNumber>();
//   SessionIndex get session => super.getCodec("session").cast<SessionIndex>();
//   H256 get randomSeed => super.getCodec("randomSeed").cast<H256>();
//   Vec<ParaId> get activeParachains => super.getCodec("activeParachains").cast<Vec<ParaId>>();
//   Vec<Hash> get paraBlocks => super.getCodec("paraBlocks").cast<Vec<Hash>>();

//   IncludedBlocks(Registry registry, S types,
//       [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
//       : super(registry, types, value, jsonMap);
//   factory IncludedBlocks.from(Struct origin) =>
//       IncludedBlocks(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
// }

// /** @name MoreAttestations */
// class MoreAttestations<S extends Map<String, dynamic>> extends Struct {
//   MoreAttestations(Registry registry, S types,
//       [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
//       : super(registry, types, value, jsonMap);
//   factory MoreAttestations.from(Struct origin) => MoreAttestations(
//       origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
// }

// const PHANTOM_ATTESTATIONS = 'attestations';
