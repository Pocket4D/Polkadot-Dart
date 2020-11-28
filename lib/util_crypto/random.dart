import 'dart:math';
import 'dart:typed_data';

// import 'package:laksadart/laksadart.dart';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/utils/number.dart' as numbers;

const DEFAULT_LENGTH = 32;

final bn53 = BigInt.parse('11111111111111111111111111111111111111111111111111111', radix: 2);

class DartRandom {
  Random dartRandom;

  DartRandom(this.dartRandom);

  String get algorithmName => "DartRandom";

  BigInt nextBigInteger(int bitLength) {
    int fullBytes = bitLength ~/ 8;

    /// var remainingBits = bitLength % 8;

    /// Generate a number from the full bytes. Then, prepend a smaller number
    /// covering the remaining bits.
    BigInt main = numbers.bytesToInt(nextBytes(fullBytes));

    /// forcing remainingBits to be calculate with bitLength
    int remainingBits = (bitLength - main.bitLength);
    int additional = remainingBits < 4 ? dartRandom.nextInt(pow(2, remainingBits)) : remainingBits;
    BigInt additionalBit = (new BigInt.from(additional) << (fullBytes * 8));
    BigInt result = main + additionalBit;
    return result;
  }

  Uint8List nextBytes(int count) {
    Uint8List list = new Uint8List(count);

    for (int i = 0; i < list.length; i++) {
      list[i] = nextUint8();
    }
    return list;
  }

  int nextUint16() => dartRandom.nextInt(pow(2, 32));

  int nextUint32() => dartRandom.nextInt(pow(2, 32));

  int nextUint8() => dartRandom.nextInt(pow(2, 8));
}

Uint8List getRandomValues([int length = DEFAULT_LENGTH]) {
  DartRandom rn = DartRandom(Random.secure());
  var entropy = rn.nextBigInteger(length * 8).toRadixString(16);

  if (entropy.length > length * 2) {
    entropy = entropy.substring(0, length * 2);
  }

  var randomPers = rn.nextBigInteger((length) * 8).toRadixString(16);

  if (randomPers.length > (length) * 2) {
    randomPers = randomPers.substring(0, (length) * 2);
  }
  return randomPers.hexAddPrefix().toU8a();
}

Uint8List randomAsU8a([int length = DEFAULT_LENGTH]) {
  return getRandomValues(length);
}

String randomAsHex([int length = 32]) {
  return u8aToHex(randomAsU8a(length));
}

int randomAsNumber() {
  return (hexToBn(randomAsHex(8)) & bn53).toInt();
}
