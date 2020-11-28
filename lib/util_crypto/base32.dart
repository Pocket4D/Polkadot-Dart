import 'dart:typed_data';

import 'package:polkadot_dart/util_crypto/base58.dart';
import 'package:polkadot_dart/utils/utils.dart';

const BASE32_ALPHABET = 'abcdefghijklmnopqrstuvwxyz234567';
const BITS_PER_CHAR = 5;

const MASK = (1 << BITS_PER_CHAR) - 1;

class Base32Config extends CheckConfig {
  final String alphabet = BASE32_ALPHABET;
  final String ipfsChar = "b";
  final String type = "base32";
  Base32Config();
}

bool base32Validate(String value, {bool ipfsCompat}) {
  return validateChars(Base32Config(), value: value, ipfsCompat: ipfsCompat);
}

final lookupList = BASE32_ALPHABET.split('').fold<Map<String, dynamic>>({},
    (Map<String, dynamic> previousValue, String element) {
  previousValue[element] = BASE32_ALPHABET.indexOf(element);
  return previousValue;
});

List<dynamic> decode(Uint8List output, String input, num offset) {
  var bits = 0;
  var buffer = 0;
  var written = 0;

  for (var i = offset; i < input.length; i++) {
    buffer = (buffer << BITS_PER_CHAR) | lookupList[input[i]];
    bits += BITS_PER_CHAR;

    if (bits >= 8) {
      bits -= 8;
      output[written++] = 0xff & (buffer >> bits);
    }
  }

  return [output, bits, buffer];
}

Uint8List base32Decode(String value, {bool ipfsCompat = false}) {
  base32Validate(value, ipfsCompat: ipfsCompat);

  var offset = (ipfsCompat ? 1 : 0);
  var decodedResult =
      decode(Uint8List(((value.length - offset) * BITS_PER_CHAR ~/ 8) | 0), value, offset);
  var output = decodedResult[0] as Uint8List;
  var bits = decodedResult[1] as int;
  var buffer = decodedResult[2] as int;

  assert(
      !(bits >= BITS_PER_CHAR || (0xff & (buffer << (8 - bits))) != 0), 'Unexpected end of data');

  return output;
}

String base32Encode(dynamic value, {bool ipfsCompat = false}) {
  final u8a = u8aToU8a(value);
  var out = '';
  var bits = 0;
  var buffer = 0;

  for (var i = 0; i < u8a.length; ++i) {
    buffer = (buffer << 8) | u8a[i];
    bits += 8;

    while (bits > BITS_PER_CHAR) {
      bits -= BITS_PER_CHAR;
      out += BASE32_ALPHABET[MASK & (buffer >> bits)];
    }
  }

  if (bits != 0) {
    out += BASE32_ALPHABET[MASK & (buffer << (BITS_PER_CHAR - bits))];
  }

  return ipfsCompat ? "b$out" : out;
}

typedef BaseValidator = bool Function(String value, {bool ipfsCompat});

bool testValidator(BaseValidator validate, String value, {bool ipfsCompat}) {
  try {
    return validate(value, ipfsCompat: ipfsCompat);
  } catch (error) {
    return false;
  }
}

bool isBase32({String value, bool ipfsCompat}) {
  return testValidator(base32Validate, value, ipfsCompat: ipfsCompat);
}
