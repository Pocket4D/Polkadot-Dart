import 'dart:typed_data';

import 'package:polkadot_dart/utils/u8a.dart';
import 'dart:convert' as convert;

bool base64Validate(String value) {
  assert(value != null, 'Expected non-null, non-empty base64 input');
  assert(
      RegExp(r"^(?:[A-Za-z0-9+/]{2}[A-Za-z0-9+/]{2})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$")
          .allMatches(value)
          .isNotEmpty,
      'Invalid base64 encoding');

  return true;
}

String base64Trim(String value) {
  while (value.length != 0 && value[value.length - 1] == '=') {
    final len = value.length;
    value = value.substring(0, len - 1);
  }
  return value;
}

String base64Pad(String value) {
  return value.padRight(value.length + (value.length % 4), '=');
}

bool isBase64(String value) {
  try {
    return base64Validate(value);
  } catch (error) {
    return false;
  }
}

String base64Encode(dynamic value) {
  return convert.base64Encode(u8aToU8a(value, useDartEncode: true).toList());
}

Uint8List base64Decode(String value) {
  base64Validate(value);
  return convert.base64Decode(value);
}
