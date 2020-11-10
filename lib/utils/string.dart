import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:p4d_rust_binding/utils/number.dart';
import 'package:validators/validators.dart' as validators;

bool isByteString(String byStr, {int length}) {
  var str = byStr.startsWith(new RegExp(r'0x', caseSensitive: false)) ? byStr.substring(2) : byStr;
  return validators.matches(str, '^[0-9a-fA-F]{$length}') &&
      validators.isLength(str, length, length);
}

bool isHexString(String str) {
  var result = str.startsWith(new RegExp(r'0x', caseSensitive: false)) ? str.substring(2) : str;
  return validators.matches(result, '^[0-9a-fA-F]{${result.length}}');
}

String strip0xHex(String hex) {
  if (hex.startsWith('0x', 0)) return hex.substring(2);
  return hex;
}

String toHex(dynamic msg) {
  var res = '';
  for (var i = 0; i < msg.length; i++) {
    res += zero2(numberToHex(msg[i]));
  }
  return res;
}

String zero2(word) {
  if (word.length == 1)
    return '0' + word;
  else
    return word;
}

Uint8List stringToU8a(String msg, [String enc]) {
  if (enc == 'hex') {
    msg = strip0xHex(msg);
    List<int> hexRes = new List();
    msg = msg.replaceAll(new RegExp("[^a-z0-9]"), '');
    if (msg.length % 2 != 0) msg = '0' + msg;
    for (var i = 0; i < msg.length; i += 2) {
      var cul = msg[i] + msg[i + 1];
      var result = int.parse(cul, radix: 16);
      hexRes.add(result);
    }
    return Uint8List.fromList(hexRes);
  } else {
    List<int> noHexRes = new List();
    for (var i = 0; i < msg.length; i++) {
      var c = msg.codeUnitAt(i);
      var hi = c >> 8;
      var lo = c & 0xff;
      if (hi > 0) {
        noHexRes.add(hi);
        noHexRes.add(lo);
      } else {
        noHexRes.add(lo);
      }
    }

    return Uint8List.fromList(noHexRes);
  }
}

String plainTextToHex(String plainText) {
  var u8a = stringToU8a(plainText);
  return bytesToHex(u8a);
}

String hexToPlainText(String hex) {
  return utf8.decode(stringToU8a(hex, "hex"));
}

// Converts the hexadecimal string, which can be prefixed with 0x, to a byte
/// sequence.
List<int> hexToBytes(String hexStr) {
  return hex.decode(strip0xHex(hexStr));
}
