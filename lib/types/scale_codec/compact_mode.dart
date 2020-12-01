enum CompactModeType { SINGLE, TWO, FOUR, BIGINT }

class CompactMode {
  static BigInt max = BigInt.two.pow(536) - (BigInt.one);

  // final _single = int.parse('00', radix: 2).toRadixString(2);
  // final _two = int.parse('01', radix: 2).toRadixString(2);
  // final _four = int.parse('10', radix: 2).toRadixString(2);
  // final _bigInt = int.parse('11', radix: 2).toRadixString(2);

  /// byte value;
  int value;

  CompactMode(int value) {
    this.value = value;
  }

  static CompactModeType byValue(int value) {
    if (value == CompactModeType.SINGLE.index) {
      return CompactModeType.SINGLE;
    } else if (value == CompactModeType.TWO.index) {
      return CompactModeType.TWO;
    } else if (value == CompactModeType.FOUR.index) {
      return CompactModeType.FOUR;
    } else {
      return CompactModeType.BIGINT;
    }
  }

  // static CompactModeType forNumber(int number) {
  //   if (number < 0) {
  //     throw "Negative numbers are not supported";
  //   }
  //   if (number <= 0x3f) {
  //     return CompactModeType.SINGLE;
  //   } else if (number <= 0x3fff) {
  //     return CompactModeType.TWO;
  //   } else if (number <= 0x3fffffff) {
  //     return CompactModeType.FOUR;
  //   } else {
  //     return CompactModeType.BIGINT;
  //   }
  // }

  static CompactModeType forNumber(num numVal) {
    final number = BigInt.from(numVal);
    if (number.isNegative) {
      throw "Negative numbers are not supported";
    }
    if (number.compareTo(CompactMode.max) > 0) {
      throw "Numbers larger than 2**536-1 are not supported";
    }
    if (number == (BigInt.zero)) {
      return CompactModeType.SINGLE;
    } else if (number.compareTo(BigInt.from(0x3fffffff)) > 0) {
      return CompactModeType.BIGINT;
    } else if (number.compareTo(BigInt.from(0x3fff)) > 0) {
      return CompactModeType.FOUR;
    } else if (number.compareTo(BigInt.from(0x3f)) > 0) {
      return CompactModeType.TWO;
    } else {
      return CompactModeType.SINGLE;
    }
  }
}
