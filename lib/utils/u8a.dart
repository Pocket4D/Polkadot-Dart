import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:p4d_rust_binding/utils/string.dart';

import 'number.dart';

Uint8List convertString(String str) {
  return isHexString(str)
      ? Uint8List.fromList(stringToU8a(strip0xHex(str)))
      : Uint8List.fromList(stringToU8a(str));
}

Uint8List convertArray(List<int> arr) {
  return (arr is List<int>) ? Uint8List.fromList(arr) : arr;
}

Uint8List u8aToU8a(dynamic value) {
  if (value == null) {
    return Uint8List.fromList([]);
  } else if (value is ByteBuffer) {
    return value.asUint8List();
  } else if (value is String) {
    return convertString(value);
  }
  return convertArray(value);
}

Uint8List u8aConcat(List<dynamic> list) {
  var u8as = List<Uint8List>(list.length);
  for (var i = 0; i < list.length; i += 1) {
    u8as[i] = u8aToU8a(list[i]);
  }

  final expandedList = u8as.expand((element) => element).toList();
  final result = Uint8List.fromList(expandedList);
  return result;
}

bool u8aEq(Uint8List a, Uint8List b) {
  return ListEquality().equals(a, b);
}

Uint8List u8aFixLength(Uint8List value, {int bitLength = -1, bool atStart = false}) {
  final byteLength = (bitLength / 8).ceil();

  if (bitLength == -1 || value.length == byteLength) {
    return value;
  } else if (value.length > byteLength) {
    return value.sublist(0, byteLength);
  }

  final result = Uint8List(byteLength);

  if (atStart) {
    result.setRange(0, value.length, value);
  } else {
    result.setRange(byteLength - value.length, byteLength, value);
  }

  return result;
}

List<Uint8List> u8aSorted(List<Uint8List> u8as) {
  u8as.sort((a, b) {
    var i = 0;
    while (true) {
      if (a[i] == null && b[i] == null) {
        return 0;
      } else if (a[i] == null) {
        return -1;
      } else if (b[i] == null) {
        return 1;
      }
      var cmp = a[i] - b[i];
      if (cmp != 0) {
        return cmp;
      }
      i++;
    }
  });
  return u8as;
}

BigInt u8aToBN(Uint8List u8a) {
  return decodeBigInt(u8a);
}

String u8aToHex(Uint8List u8a, {bool include0x = true}) {
  return bytesToHex(u8a, include0x: include0x);
}

ByteBuffer u8aToBuffer(Uint8List u8a) {
  return u8a.buffer;
}

String u8aToString(Uint8List u8a) {
  return utf8.decode(u8a);
}
