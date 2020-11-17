import 'dart:math';
import 'dart:typed_data';

import 'package:laksadart/laksadart.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';

const DEFAULT_LENGTH = 32;

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
  return hexToU8a(hexAddPrefix(randomPers));
}

Uint8List randomAsU8a([int length = DEFAULT_LENGTH]) {
  return getRandomValues(length);
}
