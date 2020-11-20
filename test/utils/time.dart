import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/utils/time.dart';

void main() {
  timeTest();
}

void timeTest() {
  test('extractTime', () {
    const milliseconds = 1e9 + 123;
    expect(
        extractTime(milliseconds).toJson(),
        jsonEncode({
          "days": 11,
          "hours": 13,
          "milliseconds": 123,
          "minutes": 46,
          "seconds": 40
        })); // {"days":11,"hours":13,"milliseconds":123,"minutes":46,"seconds":40}
    // print("\n");
  });
}
