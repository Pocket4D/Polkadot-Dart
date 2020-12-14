import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/aura/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

// there are all reversed since it is actually encoded as u32, LE,
// this means that FRNK has the bytes as KNRF

const CID_AURA = 0x61727561; // 'aura'
const CID_BABE = 0x45424142; // 'BABE'
const CID_GRPA = 0x4b4e5246; // 'FRNK'(don't ask, used to be afg1)
const CID_POW = 0x5f776f70; // 'pow_'

class GenericConsensusEngineId extends u32 {
  GenericConsensusEngineId(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory GenericConsensusEngineId.from(u32 origin) {
    return GenericConsensusEngineId(origin.registry, origin.value);
  }

  static String idToString(dynamic input) {
    return bnToBn(input)
        .toU8a(endian: Endian.little)
        .map((code) => String.fromCharCode(code))
        .join('');
  }

  static int stringToId(String input) {
    return input.split('').reversed.fold(0, (result, char) => (result * 256) + char.codeUnitAt(0));
  }

  /// @description `true` if the engine matches aura
  bool get isAura {
    return this.eq(CID_AURA);
  }

  /// @description `true` is the engine matches babe
  bool get isBabe {
    return this.eq(CID_BABE);
  }

  /// @description `true` is the engine matches grandpa
  bool get isGrandpa {
    return this.eq(CID_GRPA);
  }

  /// @description `true` is the engine matches pow
  bool get isPow {
    return this.eq(CID_POW);
  }

  AccountId _getAuraAuthor(Bytes bytes, List<AccountId> sessionValidators) {
    return sessionValidators[
        RawAuraPreDigest.from(this.registry.createType('RawAuraPreDigest', bytes.toU8a(true)))
            .slotNumber
            .value
            .modInverse(BigInt.from(sessionValidators.length))
            .toInt()];
  }

  AccountId _getBabeAuthor(Bytes bytes, List<AccountId> sessionValidators) {
    final digest = this.registry.createType('RawBabePreDigestCompat', bytes.toU8a(true));

    return sessionValidators[(digest.value as u32).toNumber()];
  }

  AccountId _getPowAuthor(Bytes bytes) {
    return AccountId.from(this.registry.createType('AccountId', bytes));
  }

  // /**
  //  * @description From the input bytes, decode into an author
  //  */ : AccountId | undefined
  dynamic extractAuthor(Bytes bytes, List<AccountId> sessionValidators) {
    if (sessionValidators.length > 0) {
      if (this.isAura) {
        return this._getAuraAuthor(bytes, sessionValidators);
      } else if (this.isBabe) {
        return this._getBabeAuthor(bytes, sessionValidators);
      }
    }

    if (this.isPow) {
      return this._getPowAuthor(bytes);
    }

    return null;
  }

  /// @description Override the default toString to return a 4-byte string
  String toString([int base = 10]) {
    return GenericConsensusEngineId.idToString(this.value);
  }
}
