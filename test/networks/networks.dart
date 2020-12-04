import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/networks/networks.dart';
import 'package:http/http.dart' as http;
import 'package:polkadot_dart/networks/types.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  networksTest(); // rename this test name
}

void networksTest() {
  group('groupTitle', () {
    var client = http.Client();
    Ss58Registry original;
    setUp(() async {
      var body = (await client.get(
              'https://raw.githubusercontent.com/paritytech/substrate/master/ss58-registry.json'))
          .body;

      original = Ss58Registry.fromJson(body);
    });
    test('has the same number as the original', () async {
      assert(all.length == original.registry.length,
          "Number of entries mismatched:: Expected ${original.registry.length} found ${all.length}");
      expect(all.length, original.registry.length);
    });

    test('has no missing any entries', () async {
      final missing = original.registry
          .where((reg) => !all.any((n) => n["prefix"] == reg.prefix))
          .map((org) => "${org.displayName} (${org.prefix})");

      assert(missing.length == 0, "Missing entries found: ${jsonEncode(missing)}");
      expect(missing.length, 0);
    });

    test('has no extra entries', () async {
      final missing = all
          .where((reg) => !original.registry.any((n) => n.prefix == reg["prefix"]))
          .map((org) => "${org["displayName"]} (${org["prefix"]})");

      assert(missing.length == 0, "Extra entries found: ${jsonEncode(missing)}");
      expect(missing.length, 0);
    });

    // tearDown(() async {
    //   client.close();
    //   original = null;
    // });

    test('has the same values as the original', () {
      final fields = original.schema.keys.toList();
      final errors = original.registry.map((n) {
        final other = all.singleWhere((e) => e["prefix"] == n.prefix);

        return [
          "${n.displayName} (${n.prefix})",
          other != null
              // eslint-disable-next-line @typescript-eslint/ban-ts-comment
              // @ts-ignore
              ? fields.where((f) => jsonEncode(n.toMap()[f]) != jsonEncode(other[f])).toList()
              : []
        ];
      }).where((arr) {
        return (arr[1] as List).length != 0;
      });

      assert(errors.length == 0,
          "Mismatches found: ${jsonEncode(errors.map((e) => '${e[0]}:: ${(e[1] as List).join(', ')}'))}");
      expect(errors.length, 0);
    });
  });

  group('filtered', () {
    test('has the correct starting order', () {
      expect(filtered.sublist(0, 3).map((e) => e.prefix).toList(), [0, 2, 42]);
    });
  });
}
