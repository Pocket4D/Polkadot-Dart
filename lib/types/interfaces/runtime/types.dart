import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/generic/generic.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:tuple/tuple.dart';

class AccountId extends GenericAccountId {
  AccountId(Registry registry, [dynamic value]) : super(registry, value);
  factory AccountId.from(GenericAccountId origin) {
    return AccountId(origin.registry, origin.value);
  }
}

class AccountIdOf extends AccountId {
  AccountIdOf(Registry registry, [dynamic value]) : super(registry, value);
  factory AccountIdOf.from(AccountId origin) {
    return AccountIdOf(origin.registry, origin.value);
  }
}

class AccountIndex extends GenericAccountIndex {
  AccountIndex(Registry registry, [dynamic value]) : super(registry, value);
  factory AccountIndex.from(GenericAccountIndex origin) {
    return AccountIndex(origin.registry, origin.value);
  }
}

// /** @name Address */
// class Address extends LookupSource {}

class AssetId extends u32 {
  AssetId(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory AssetId.from(u32 origin) {
    return AssetId(origin.registry, origin.value);
  }
}

class Balance extends UInt {
  Balance(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory Balance.from(UInt origin) {
    return Balance(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class BalanceOf extends Balance {
  BalanceOf(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory BalanceOf.from(Balance origin) {
    return BalanceOf(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

// /** @name Block */
// class Block extends GenericBlock {}

class BlockNumber extends u32 {
  BlockNumber(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory BlockNumber.from(u32 origin) {
    return BlockNumber(origin.registry, origin.value);
  }
}

// /** @name Call */
// class Call extends GenericCall {}

class CallHash extends Hash {
  CallHash(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory CallHash.from(H256 origin) {
    return CallHash(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

// /** @name CallHashOf */
class CallHashOf extends CallHash {
  CallHashOf(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory CallHashOf.from(H256 origin) {
    return CallHashOf(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

class ChangesTrieConfiguration<S extends Map<String, dynamic>> extends Struct {
  u32 get digestInterval => super.getCodec("digestInterval").cast<u32>();
  u32 get digestLevels => super.getCodec("digestLevels").cast<u32>();
  ChangesTrieConfiguration(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ChangesTrieConfiguration.from(Struct origin) => ChangesTrieConfiguration(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

class Consensus extends Tuple2<Bytes, Bytes> {
  Consensus(Bytes item1, Bytes item2) : super(item1, item2);
}

// /** @name ConsensusEngineId */
// class ConsensusEngineId extends GenericConsensusEngineId {}

// /** @name Digest */
// class Digest extends Struct {
//   Vec<DigestItem> get logs;
// }

// class DigestItem extends Enum {
//   bool get isOther;
//   Bytes get asOther;
//   bool get isAuthoritiesChange;
//   Vec<AuthorityId> get asAuthoritiesChange;
//   bool get isChangesTrieRoot;
//   Hash get asChangesTrieRoot;
//   bool get isSealV0;
//   SealV0 get asSealV0;
//   bool get isConsensus;
//   Consensus get asConsensus;
//   bool get isSeal;
//   Seal get asSeal;
//   bool get isPreRuntime;
//   PreRuntime get asPreRuntime;
// }

// class DigestItem extends Enum {
//   DigestItem(Registry registry, dynamic def, [dynamic value, int index])
//       : super(registry, def, value, index);
//   factory DigestItem.from(Enum origin) =>
//       DigestItem(origin.registry, origin.def, origin.originValue, origin.originIndex);
//   bool get isOther => super.isKey("Other");
//   Bytes get asOther => super.askey("Other").cast<Bytes>();
//   bool get isAuthoritiesChange => super.isKey("AuthoritiesChange");
//   Vec<AuthorityId> get asAuthoritiesChange => super.askey("AuthoritiesChange").cast<Vec<AuthorityId>>();
//   bool get isSealV0 => super.isKey("SealV0");
//   SealV0 get asSealV0 => super.askey("SealV0").cast<SealV0>();
//   bool get isConsensus => super.isKey("Consensus");
//   Consensus get asConsensus => super.askey("Consensus").cast<Consensus>();
//   bool get isSeal => super.isKey("Seal");
//   Seal get asSeal => super.askey("Seal").cast<Seal>();
//   bool get isPreRuntime => super.isKey("PreRuntime");
//   PreRuntime get asPreRuntime => super.askey("PreRuntime").cast<PreRuntime>();
// }

class ExtrinsicsWeight<S extends Map<String, dynamic>> extends Struct {
  Weight get normal => super.getCodec("normal").cast<Weight>();
  Weight get operational => super.getCodec("operational").cast<Weight>();
  ExtrinsicsWeight(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory ExtrinsicsWeight.from(Struct origin) => ExtrinsicsWeight(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

class Fixed128 extends CodecInt {
  Fixed128(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory Fixed128.from(CodecInt origin) =>
      Fixed128(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class Fixed64 extends CodecInt {
  Fixed64(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory Fixed64.from(CodecInt origin) =>
      Fixed64(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class FixedI128 extends CodecInt {
  FixedI128(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory FixedI128.from(CodecInt origin) =>
      FixedI128(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class FixedI64 extends CodecInt {
  FixedI64(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory FixedI64.from(CodecInt origin) =>
      FixedI64(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class FixedU128 extends UInt {
  FixedU128(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory FixedU128.from(UInt origin) {
    return FixedU128(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class FixedU64 extends UInt {
  FixedU64(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory FixedU64.from(UInt origin) {
    return FixedU64(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class H160 extends U8aFixed {
  H160(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory H160.from(U8aFixed origin) {
    return H160(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

class H256 extends U8aFixed {
  H256(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory H256.from(U8aFixed origin) {
    return H256(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

class H512 extends U8aFixed {
  H512(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory H512.from(U8aFixed origin) {
    return H512(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

class Hash extends H256 {
  Hash(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory Hash.from(H256 origin) {
    return Hash(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

// abstract class Header extends Struct {
//   Header(Registry registry, Map<String, > types) : super(registry, types);

//   Hash get parentHash;
//   Compact<BlockNumber> get number;
//   Hash get stateRoot;
//   Hash get extrinsicsRoot;
//   Digest get digest;
// }

class I32F32 extends CodecInt {
  I32F32(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory I32F32.from(CodecInt origin) =>
      I32F32(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class Index extends u32 {
  Index(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory Index.from(u32 origin) {
    return Index(origin.registry, origin.value);
  }
}

// /** @name IndicesLookupSource */
// class IndicesLookupSource extends GenericLookupSource {}

class Justification extends Bytes {
  Justification(Registry registry, [dynamic value]) : super(registry, value);
  factory Justification.from(Bytes origin) => Justification(origin.registry, origin.value);
}

class KeyTypeId extends u32 {
  KeyTypeId(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory KeyTypeId.from(u32 origin) {
    return KeyTypeId(origin.registry, origin.value);
  }
}

// /** @name KeyValue */
// class  KeyValue extends ITuple<[StorageKey, StorageData]> {}

class LockIdentifier extends U8aFixed {
  LockIdentifier(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory LockIdentifier.from(U8aFixed origin) {
    return LockIdentifier(origin.registry, origin.value, origin.bitLength, origin.typeName);
  }
}

// class  LookupSource extends IndicesLookupSource {}

class LookupTarget extends AccountId {
  LookupTarget(Registry registry, [dynamic value]) : super(registry, value);
  factory LookupTarget.from(AccountId origin) {
    return LookupTarget(origin.registry, origin.value);
  }
}

class ModuleId extends LockIdentifier {
  ModuleId(Registry registry, [dynamic value]) : super(registry, value);
  factory ModuleId.from(LockIdentifier origin) {
    return ModuleId(origin.registry, origin.value);
  }
}

class Moment extends u64 {
  Moment(Registry registry, [dynamic value = 0]) : super(registry, value);
  factory Moment.from(u64 origin) {
    return Moment(origin.registry, origin.value);
  }
}

// class MultiAddress extends GenericMultiAddress {}

class OpaqueCall extends Bytes {
  OpaqueCall(Registry registry, [dynamic value]) : super(registry, value);
  factory OpaqueCall.from(Bytes origin) => OpaqueCall(origin.registry, origin.value);
}

class Origin extends DoNotConstruct {
  Origin(Registry registry, [String typeName = 'DoNotConstruct'])
      : super(registry, typeName ?? 'DoNotConstruct');
  factory Origin.from(DoNotConstruct origin) => Origin(origin.registry);
}

// /** @name OriginCaller */
// class OriginCaller extends Enum {
//   bool get isSystem;
//   SystemOrigin get asSystem;
// }

// class  PalletsOrigin extends OriginCaller {}

class PalletVersion<S extends Map<String, dynamic>> extends Struct {
  u16 get major => super.getCodec("major").cast<u16>();
  u8 get minor => super.getCodec("minor").cast<u8>();
  u8 get patch => super.getCodec("patch").cast<u8>();
  PalletVersion(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory PalletVersion.from(Struct origin) =>
      PalletVersion(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

class Pays extends Enum {
  Pays(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory Pays.from(Enum origin) =>
      Pays(origin.registry, origin.def, origin.originValue, origin.originIndex);

  bool get isYes => super.isKey("Yes");
  bool get isNo => super.isKey("No");
}

class Perbill extends UInt {
  Perbill(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory Perbill.from(UInt origin) {
    return Perbill(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class Percent extends UInt {
  Percent(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory Percent.from(UInt origin) {
    return Percent(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class Permill extends UInt {
  Permill(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory Permill.from(UInt origin) {
    return Permill(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class Perquintill extends UInt {
  Perquintill(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory Perquintill.from(UInt origin) {
    return Perquintill(origin.registry, origin.value, origin.bitLength)
      ..setRawType(origin.typeName);
  }
}

class PerU16 extends UInt {
  PerU16(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory PerU16.from(UInt origin) {
    return PerU16(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class Phantom extends CodecNull {
  Phantom(Registry registry) : super(registry);
  factory Phantom.from(CodecNull origin) {
    return Phantom(origin.registry);
  }
}

class PhantomData extends CodecNull {
  PhantomData(Registry registry) : super(registry);
  factory PhantomData.from(CodecNull origin) {
    return PhantomData(origin.registry);
  }
}

// export interface PreRuntime extends ITuple<[ConsensusEngineId, Bytes]> {}

class Releases extends Enum {
  Releases(Registry registry, dynamic def, [dynamic value, int index])
      : super(registry, def, value, index);
  factory Releases.from(Enum origin) =>
      Releases(origin.registry, origin.def, origin.originValue, origin.originIndex);
  bool get isV1 => super.isKey("V1");
  bool get isV2 => super.isKey("V2");
  bool get isV3 => super.isKey("V3");
  bool get isV4 => super.isKey("V4");
  bool get isV5 => super.isKey("V5");
  bool get isV6 => super.isKey("V6");
  bool get isV7 => super.isKey("V7");
  bool get isV8 => super.isKey("V8");
  bool get isV9 => super.isKey("V9");
  bool get isV10 => super.isKey("V10");
}

class RuntimeDbWeight<S extends Map<String, dynamic>> extends Struct {
  Weight get read => super.getCodec("read").cast<Weight>();
  Weight get write => super.getCodec("write").cast<Weight>();

  RuntimeDbWeight(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory RuntimeDbWeight.from(Struct origin) => RuntimeDbWeight(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// /** @name Seal */
// class Seal extends ITuple<[ConsensusEngineId, Bytes]> {}

// /** @name SealV0 */
// class SealV0 extends Tuple2<u64, Signature> {}

// class SignedBlock<S extends Map<String, dynamic>> extends Struct {
//   Block get block => super.getCodec("block").cast<Block>();
//   Justification get justification => super.getCodec("justification").cast<Justification>();

//   SignedBlock(Registry registry, S types,
//       [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
//       : super(registry, types, value, jsonMap);
//   factory SignedBlock.from(Struct origin) =>
//       SignedBlock(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
// }

class StorageData extends Bytes {
  StorageData(Registry registry, [dynamic value]) : super(registry, value);
  factory StorageData.from(Bytes origin) => StorageData(origin.registry, origin.value);
}

class TransactionPriority extends u64 {
  TransactionPriority(Registry registry, [dynamic value = 0]) : super(registry, value);
  factory TransactionPriority.from(u64 origin) {
    return TransactionPriority(origin.registry, origin.value);
  }
}

class U32F32 extends UInt {
  U32F32(Registry registry, [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS);
  factory U32F32.from(UInt origin) {
    return U32F32(origin.registry, origin.value, origin.bitLength)..setRawType(origin.typeName);
  }
}

class ValidatorId extends AccountId {
  ValidatorId(Registry registry, [dynamic value]) : super(registry, value);
  factory ValidatorId.from(AccountId origin) {
    return ValidatorId(origin.registry, origin.value);
  }
}

class Weight extends u64 {
  Weight(Registry registry, [dynamic value = 0]) : super(registry, value);
  factory Weight.from(u64 origin) {
    return Weight(origin.registry, origin.value);
  }
}

class WeightMultiplier extends Fixed64 {
  WeightMultiplier(Registry registry,
      [dynamic value = 0, int bitLength = DEFAULT_UINT_BITS, String typeName])
      : super(registry, value ?? 0, bitLength ?? DEFAULT_UINT_BITS, typeName);
  factory WeightMultiplier.from(Fixed64 origin) =>
      WeightMultiplier(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

const PHANTOM_RUNTIME = 'runtime';
