import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

// /** @name ActiveEraInfo */
// class ActiveEraInfo extends Struct {
//   readonly index: EraIndex;
//   readonly start: Option<Moment>;
// }

// /** @name CompactAssignments */
// class CompactAssignments extends Struct {
//   readonly votes1: Vec<ITuple<[NominatorIndexCompact, ValidatorIndexCompact]>>;
//   readonly votes2: Vec<ITuple<[NominatorIndexCompact, CompactScoreCompact, ValidatorIndexCompact]>>;
//   readonly votes3: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes4: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes5: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes6: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes7: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes8: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes9: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes10: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes11: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes12: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes13: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes14: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes15: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
//   readonly votes16: Vec<ITuple<[NominatorIndexCompact, Vec<CompactScoreCompact>, ValidatorIndexCompact]>>;
// }

// /** @name CompactAssignmentsTo257 */
// class CompactAssignmentsTo257 extends Struct {
//   readonly votes1: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes2: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes3: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes4: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes5: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes6: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes7: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes8: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes9: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes10: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes11: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes12: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes13: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes14: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes15: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
//   readonly votes16: Vec<ITuple<[NominatorIndex, Vec<CompactScore>, ValidatorIndex]>>;
// }

// /** @name CompactScore */
// class CompactScore extends ITuple<[ValidatorIndex, OffchainAccuracy]> {}

// /** @name CompactScoreCompact */
// class CompactScoreCompact extends ITuple<[ValidatorIndexCompact, OffchainAccuracyCompact]> {}

// /** @name ElectionCompute */
// class ElectionCompute extends Enum {
//   readonly isOnChain: boolean;
//   readonly isSigned: boolean;
//   readonly isAuthority: boolean;
// }

// /** @name ElectionResult */
// class ElectionResult extends Struct {
//   readonly compute: ElectionCompute;
//   readonly slotStake: Balance;
//   readonly electedStashes: Vec<AccountId>;
//   readonly exposures: Vec<ITuple<[AccountId, Exposure]>>;
// }

// /** @name ElectionScore */
// class ElectionScore extends Vec<u128> {}

// /** @name ElectionSize */
// class ElectionSize extends Struct {
//   readonly validators: Compact<ValidatorIndex>;
//   readonly nominators: Compact<NominatorIndex>;
// }

// /** @name ElectionStatus */
// class ElectionStatus extends Enum {
//   readonly isClose: boolean;
//   readonly isOpen: boolean;
//   readonly asOpen: BlockNumber;
// }

// /** @name EraIndex */
// class EraIndex extends u32 {}

// /** @name EraPoints */
// class EraPoints extends Struct {
//   readonly total: Points;
//   readonly individual: Vec<Points>;
// }

// /** @name EraRewardPoints */
// class EraRewardPoints extends Struct {
//   readonly total: RewardPoint;
//   readonly individual: BTreeMap<AccountId, RewardPoint>;
// }

// /** @name EraRewards */
// class EraRewards extends Struct {
//   readonly total: u32;
//   readonly rewards: Vec<u32>;
// }

/** @name Exposure */

class Exposure<S extends Map<String, dynamic>> extends Struct {
  Compact<Balance> get session => super.getCodec("session").cast<Compact<Balance>>();
  Compact<Balance> get own => super.getCodec("own").cast<Compact<Balance>>();
  Vec<IndividualExposure> get others => super.getCodec("others").cast<Vec<IndividualExposure>>();
  Exposure(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory Exposure.from(Struct origin) =>
      Exposure(origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// /** @name Forcing */
// class Forcing extends Enum {
//   readonly isNotForcing: boolean;
//   readonly isForceNew: boolean;
//   readonly isForceNone: boolean;
//   readonly isForceAlways: boolean;
// }

/** @name IndividualExposure */
class IndividualExposure<S extends Map<String, dynamic>> extends Struct {
  AccountId get thisValue => super.getCodec("value").cast<AccountId>();
  Compact<Balance> get who => super.getCodec("who").cast<Compact<Balance>>();
  Vec<IndividualExposure> get others => super.getCodec("others").cast<Vec<IndividualExposure>>();
  IndividualExposure(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory IndividualExposure.from(Struct origin) => IndividualExposure(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

// /** @name KeyType */
// class KeyType extends AccountId {}

// /** @name MomentOf */
// class MomentOf extends Moment {}

// /** @name Nominations */
// class Nominations extends Struct {
//   readonly targets: Vec<AccountId>;
//   readonly submittedIn: EraIndex;
//   readonly suppressed: bool;
// }

// /** @name NominatorIndex */
// class NominatorIndex extends u32 {}

// /** @name NominatorIndexCompact */
// class NominatorIndexCompact extends Compact<NominatorIndex> {}

// /** @name OffchainAccuracy */
// class OffchainAccuracy extends PerU16 {}

// /** @name OffchainAccuracyCompact */
// class OffchainAccuracyCompact extends Compact<OffchainAccuracy> {}

// /** @name PhragmenScore */
// class PhragmenScore extends Vec<u128> {}

// /** @name Points */
// class Points extends u32 {}

// /** @name RewardDestination */
// class RewardDestination extends Enum {
//   readonly isStaked: boolean;
//   readonly isStash: boolean;
//   readonly isController: boolean;
//   readonly isAccount: boolean;
//   readonly asAccount: AccountId;
// }

// /** @name RewardDestinationTo257 */
// class RewardDestinationTo257 extends Enum {
//   readonly isStaked: boolean;
//   readonly isStash: boolean;
//   readonly isController: boolean;
// }

// /** @name RewardPoint */
// class RewardPoint extends u32 {}

// /** @name SlashingSpans */
// class SlashingSpans extends Struct {
//   readonly spanIndex: SpanIndex;
//   readonly lastStart: EraIndex;
//   readonly lastNonzeroSlash: EraIndex;
//   readonly prior: Vec<EraIndex>;
// }

// /** @name SlashingSpansTo204 */
// class SlashingSpansTo204 extends Struct {
//   readonly spanIndex: SpanIndex;
//   readonly lastStart: EraIndex;
//   readonly prior: Vec<EraIndex>;
// }

// /** @name SlashJournalEntry */
// class SlashJournalEntry extends Struct {
//   readonly who: AccountId;
//   readonly amount: Balance;
//   readonly ownSlash: Balance;
// }

// /** @name SpanIndex */
// class SpanIndex extends u32 {}

// /** @name SpanRecord */
// class SpanRecord extends Struct {
//   readonly slashed: Balance;
//   readonly paidOut: Balance;
// }

// /** @name StakingLedger */
// class StakingLedger extends Struct {
//   readonly stash: AccountId;
//   readonly total: Compact<Balance>;
//   readonly active: Compact<Balance>;
//   readonly unlocking: Vec<UnlockChunk>;
//   readonly claimedRewards: Vec<EraIndex>;
// }

// /** @name StakingLedgerTo223 */
// class StakingLedgerTo223 extends Struct {
//   readonly stash: AccountId;
//   readonly total: Compact<Balance>;
//   readonly active: Compact<Balance>;
//   readonly unlocking: Vec<UnlockChunk>;
// }

// /** @name StakingLedgerTo240 */
// class StakingLedgerTo240 extends Struct {
//   readonly stash: AccountId;
//   readonly total: Compact<Balance>;
//   readonly active: Compact<Balance>;
//   readonly unlocking: Vec<UnlockChunk>;
//   readonly lastReward: Option<EraIndex>;
// }

// /** @name UnappliedSlash */
// class UnappliedSlash extends Struct {
//   readonly validator: AccountId;
//   readonly own: Balance;
//   readonly others: Vec<UnappliedSlashOther>;
//   readonly reporters: Vec<AccountId>;
//   readonly payout: Balance;
// }

// /** @name UnappliedSlashOther */
// class UnappliedSlashOther extends ITuple<[AccountId, Balance]> {}

// /** @name UnlockChunk */
// class UnlockChunk extends Struct {
//   readonly value: Compact<Balance>;
//   readonly era: Compact<BlockNumber>;
// }

// /** @name ValidatorIndex */
// class ValidatorIndex extends u16 {}

// /** @name ValidatorIndexCompact */
// class ValidatorIndexCompact extends Compact<ValidatorIndex> {}

// /** @name ValidatorPrefs */
// class ValidatorPrefs extends Struct {
//   readonly commission: Compact<Perbill>;
// }

// /** @name ValidatorPrefsTo145 */
// class ValidatorPrefsTo145 extends Struct {
//   readonly unstakeThreshold: Compact<u32>;
//   readonly validatorPayment: Compact<Balance>;
// }

// /** @name ValidatorPrefsTo196 */
// class ValidatorPrefsTo196 extends Struct {
//   readonly validatorPayment: Compact<Balance>;
// }

const PHANTOM_STAKING = 'staking';
