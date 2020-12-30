import 'dart:typed_data';

import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

class VoteType {
  bool aye;
  dynamic conviction; // number | ArrayElementType<typeof AllConvictions>;
  VoteType({this.aye, this.conviction});
  toMap() => {"aye": this.aye, "conviction": this.conviction};
  factory VoteType.fromMap(Map<String, dynamic> map) =>
      VoteType(aye: map["aye"] ?? map["aye"] as bool, conviction: map["conviction"] ?? null);
}

// abstract class Conviction extends Enum {
//   Conviction(Registry registry, dynamic def, [dynamic value, int index])
//       : super(registry, def, value, index);
// }

// eslint-disable-next-line @typescript-eslint/ban-types
// type InputTypes = boolean | number | Boolean | Uint8List | VoteType;

// For votes, the topmost bit indicated aye/nay, the lower bits indicate the conviction
final AYE_BITS = BigInt.parse("10000000", radix: 2).toInt();
final NAY_BITS = BigInt.parse("00000000", radix: 2).toInt();
final CON_MASK = BigInt.parse("01111111", radix: 2).toInt();
final DEF_CONV = BigInt.parse("00000000", radix: 2).toInt(); // the default conviction, None

Uint8List _decodeVoteBool(bool value) {
  return value ? Uint8List.fromList([AYE_BITS | DEF_CONV]) : Uint8List.fromList([NAY_BITS]);
}

/** @internal */
Uint8List _decodeVoteU8a(Uint8List value) {
  return value.length > 0 ? value.sublist(0, 1) : Uint8List.fromList([NAY_BITS]);
}

/** @internal */
Uint8List _decodeVoteType(Registry registry, VoteType value) {
  final vote = CodecBool(registry, value.aye).isTrue ? AYE_BITS : NAY_BITS;
  final conviction = registry.createType('Conviction', value.conviction ?? DEF_CONV).cast<Enum>();

  return new Uint8List.fromList([vote | conviction.index]);
}

/** @internal */
Uint8List _decodeVote(Registry registry, [dynamic value]) {
  if ((value == null) || value is bool) {
    return _decodeVoteBool(CodecBool(registry, value).isTrue);
  } else if ((value is int)) {
    return _decodeVoteBool(value < 0);
  } else if (isU8a(value)) {
    return _decodeVoteU8a(value);
  }
  return _decodeVoteType(registry, value is Map ? VoteType.fromMap(value) : value);
}

/**
 * @name GenericVote
 * @description
 * A number of lock periods, plus a vote, one way or the other.
 */
class GenericVote extends U8aFixed {
  bool _aye;

  // Conviction _conviction;

  GenericVote(Registry registry, [dynamic value])
      : super(registry, _decodeVote(registry, value), 8) {
    // decoded is just 1 byte
    // Aye: Most Significant Bit
    // Conviction: 0000 - 0101
    final decoded = _decodeVote(registry, value);

    this._aye = (decoded[0] & AYE_BITS) == AYE_BITS;
    // this._conviction = this.registry.createType('Conviction', decoded[0] & CON_MASK);
  }
  static GenericVote constructor(Registry registry, [dynamic value]) =>
      GenericVote(registry, value);
  /**
   * @description returns a V2 conviction
   */
  // Conviction get conviction {
  //   return this._conviction;
  // }

  /**
   * @description true if the wrapped value is a positive vote
   */
  bool get isAye {
    return this._aye;
  }

  /**
   * @description true if the wrapped value is a negative vote
   */
  bool get isNay {
    return !this.isAye;
  }

  /**
   * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
   */
  dynamic toHuman([bool isExpanded]) {
    // return {"conviction": this.conviction.toHuman(isExpanded), "vote": this.isAye ? 'Aye' : 'Nay'};
    return {"vote": this.isAye ? 'Aye' : 'Nay'};
  }

  /**
   * @description Returns the base runtime type name for this instance
   */
  String toRawType() {
    return 'Vote';
  }
}
