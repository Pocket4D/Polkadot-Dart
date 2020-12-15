import 'dart:typed_data';
import 'dart:math' as Math;

import 'package:polkadot_dart/types/extrinsic/constant.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

class MortalMethod {
  int current;
  int period;
}

class MortalEnumDef {
  // ignore: non_constant_identifier_names
  String MortalEra;
}

class ImmortalEnumDef {
  // ignore: non_constant_identifier_names
  String ImmortalEra;
}

int getTrailingZeros(int period) {
  final binary = BigInt.from(period).toRadixString(2);
  int index = 0;

  while (binary[binary.length - 1 - index] == '0') {
    index++;
  }

  return index;
}

class ImmortalEra extends Raw {
  ImmortalEra(Registry registry, [dynamic value]) : super(registry, IMMORTAL_ERA);
  static ImmortalEra constructor(Registry registry, [dynamic value]) =>
      ImmortalEra(registry, value);
}

class MortalEra extends Tuple {
  MortalEra(Registry registry, [dynamic value])
      : super(registry, {"period": u64, "phase": u64}, MortalEra._decodeMortalEra(registry, value));

  /** @internal */
  static List<u64> _decodeMortalEra(Registry registry, [dynamic value]) {
    if (value == null) {
      return [new u64(registry), new u64(registry)];
    } else if (isU8a(value) || isHex(value) || (value is List)) {
      return MortalEra._decodeMortalU8a(registry, u8aToU8a(value));
    } else if (isObject(value)) {
      return MortalEra._decodeMortalObject(registry, value);
    }

    throw 'Invalid data passed to Mortal era';
  }

  /** @internal */
  static List<u64> _decodeMortalObject(Registry registry, MortalMethod value) {
    final current = value.current;
    final period = value.period;

    var calPeriod = Math.pow(2, (log2(period).ceil())).toInt();

    calPeriod = Math.min(Math.max(calPeriod, 4), 1 << 16);

    final phase = current % calPeriod;
    final quantizeFactor = Math.max(calPeriod >> 12, 1);
    final quantizedPhase = phase / quantizeFactor * quantizeFactor;

    return [u64(registry, calPeriod), u64(registry, quantizedPhase)];
  }

  /** @internal */
  static List<u64> _decodeMortalU8a(Registry registry, Uint8List value) {
    if (value.length == 0) {
      return [u64(registry), u64(registry)];
    }

    final first = u8aToBn(value.sublist(0, 1)).toInt();
    final second = u8aToBn(value.sublist(1, 2)).toInt();
    final encoded = first + (second << 8);
    final period = 2 << (encoded % (1 << 4));
    final quantizeFactor = Math.max(period >> 12, 1);
    final phase = (encoded >> 4) * quantizeFactor;

    assert(period >= 4 && phase < period, 'Invalid data passed to Mortal era');

    return [u64(registry, period), u64(registry, phase)];
  }

  /**
   * @description Encoded length for mortals occupy 2 bytes, different from the actual Tuple since it is encoded. This is a shortcut fro `toU8a().length`
   */
  int get encodedLength {
    return 2;
  }

  /**
   * @description The period of this Mortal wraps as a [[u64]]
   */
  u64 get period {
    return this.value[0] as u64;
  }

  /**
   * @description The phase of this Mortal wraps as a [[u64]]
   */
  u64 get phase {
    return this.value[1] as u64;
  }

  /**
   * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
   */
  dynamic toHuman([bool isExpanded]) {
    return {"period": formatNumber(this.period), "phase": formatNumber(this.phase)};
  }

  /**
   * @description Returns a JSON representation of the actual value
   */
  dynamic toJSON() {
    return this.toHex();
  }

  /**
   * @description Encodes the value as a Uint8Array as per the parity-codec specifications
   * @param isBare true when the value has none of the type-specific prefixes(internal)
   * Period and phase are encoded:
   *   - The period of validity from the block hash found in the signing material.
   *   - The phase in the period that this transaction's lifetime begins(and, importantly,
   *     implies which block hash is included in the signature material). If the `period` is
   *     greater than 1 << 12, then it will be a factor of the times greater than 1<<12 that
   *     `period` is.
   */
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    final period = this.period.toNumber();
    final phase = this.phase.toNumber();
    final quantizeFactor = Math.max(period >> 12, 1).toInt();
    final trailingZeros = getTrailingZeros(period);
    final encoded =
        Math.min(15, Math.max(1, trailingZeros - 1)) + ((((phase ~/ quantizeFactor).toInt()) << 4));
    final first = encoded >> 8;
    final second = encoded & 0xff;

    return Uint8List.fromList([second, first]);
  }

  /**
   * @description Get the block number of the start of the era whose properties this object describes that `current` belongs to.
   */
  int birth(dynamic current) {
    // FIXME No toNumber() here
    return ((Math.max(bnToBn(current).toInt(), this.phase.toNumber()) - this.phase.toNumber()) /
                    this.period.toNumber())
                .floor() *
            this.period.toNumber() +
        this.phase.toNumber();
  }

  /**
   * @description Get the block number of the first block at which the era has ended.
   */
  int death(dynamic current) {
    // FIXME No toNumber() here
    return this.birth(current) + this.period.toNumber();
  }
}

/**
 * @name GenericExtrinsicEra
 * @description
 * The era for an extrinsic, indicating either a mortal or immortal extrinsic
 */
// implements IExtrinsicEra
class GenericExtrinsicEra extends Enum {
  GenericExtrinsicEra(Registry registry, [dynamic value])
      : super(registry, {ImmortalEra, MortalEra},
            GenericExtrinsicEra._decodeExtrinsicEra(value as String));

  // ImmortalEra get asImmortalEra => super.askey("ImmortalEra").cast<ImmortalEra>();
  // MortalEra get asMortalEra => super.askey("MortalEra").cast<MortalEra>();
  /** @internal */
  // eslint-disable-next-line @typescript-eslint/ban-types
  static _decodeExtrinsicEra(dynamic value) {
    if (value == null) {
      value = Uint8List.fromList([]);
    }
    if (value is GenericExtrinsicEra) {
      return GenericExtrinsicEra._decodeExtrinsicEra(value.toU8a());
    } else if (isHex(value)) {
      return GenericExtrinsicEra._decodeExtrinsicEra(hexToU8a(value));
    } else if (value == null || isU8a(value)) {
      return (value?.length == 0 || value[0] == 0)
          ? Uint8List.fromList([0])
          : Uint8List.fromList([1, value[0], value[1]]);
    } else if (isObject(value)) {
      // this is to de-serialize from JSON
      return (value as MortalEnumDef).MortalEra != null
          ? {MortalEra: (value as MortalEnumDef).MortalEra}
          : (value as ImmortalEnumDef).ImmortalEra != null
              ? {ImmortalEra: (value as ImmortalEnumDef).ImmortalEra}
              : {MortalEra: value};
    }

    throw 'Invalid data passed to Era';
  }

  /**
   * @description Override the encoded length method
   */
  int get encodedLength {
    return this.isImmortalEra ? this.asImmortalEra.encodedLength : this.asMortalEra.encodedLength;
  }

  /**
   * @description Returns the item as a [[ImmortalEra]]
   */
  ImmortalEra get asImmortalEra {
    assert(this.isImmortalEra, "Cannot convert '${this.type}' via asImmortalEra");
    return this.value as ImmortalEra;
  }

  /**
   * @description Returns the item as a [[MortalEra]]
   */
  MortalEra get asMortalEra {
    assert(this.isMortalEra, "Cannot convert '${this.type}' via asMortalEra");

    return this.value as MortalEra;
  }

  /**
   * @description `true` if Immortal
   */
  bool get isImmortalEra {
    return this.index == 0;
  }

  /**
   * @description `true` if Mortal
   */
  bool get isMortalEra {
    return this.index > 0;
  }

  /**
   * @description Encodes the value as a Uint8Array as per the parity-codec specifications
   * @param isBare true when the value has none of the type-specific prefixes(internal)
   */
  Uint8List toU8a([dynamic isBare]) {
    return this.isMortalEra ? this.asMortalEra.toU8a(isBare) : this.asImmortalEra.toU8a(isBare);
  }
}
