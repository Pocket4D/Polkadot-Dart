import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/utils/format.dart';

void main() {
  formatTest();
}

void formatTest() {
  test("zeroPad", () async {
    expect(zeroPad(5), '05');
    // print("\n");
  });

  test('formatDate', () {
    var reg = RegExp(
        r"(([1-3][0-9]{3})[-]{0,1}(((0[13578]|1[02])[-]{0,1}(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)[-]{0,1}(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))\s\d{1,2}:\d{1,2}:\d{1,2})|(([1-3][0-9]{3})[-]{0,1}(((0[13578]|1[02])[-]{0,1}(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))\s\d{1,2}:\d{1,2})|(([1-3][0-9]{3})[-]{0,1}(((0[13578]|1[02])[-]{0,1}(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)[-]{0,1}(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))");

    expect(reg.allMatches(formatDate(DateTime.now())).isNotEmpty, true);
    // print("\n");
  });

  test('formatDecimal', () {
    var expected = "-test";
    expect(formatDecimal("-test"), expected);
    // print("\n");
  });

  test('formatElapsed', () {
    var start = 12345678;
    var now = DateTime.fromMillisecondsSinceEpoch(start);

    var eee = formatElapsed(
        now, BigInt.from(DateTime.fromMillisecondsSinceEpoch(start + 9700).millisecondsSinceEpoch));

    var fff = formatElapsed(now, BigInt.from(start + 42700));
    var ggg = formatElapsed(now, BigInt.from(start + (5.3 * 60000)));
    var hhh = formatElapsed(now, BigInt.from(start + (42 * 60 * 60000)));
    var jjj = formatElapsed();
    expect(eee, '9.7s');
    expect(fff, '42s');
    expect(ggg, '5m');
    expect(hhh, '42h');
    expect(jjj, '0.0s');
  });

  test('BalanceFormatter', () {
    try {
      var testVal = BigInt.from(123456789000);
      var option1 = BalanceFormatterOptions(decimals: 15, withSi: true);
      var option2 = BalanceFormatterOptions(decimals: 0, withSi: true);
      var option3 = BalanceFormatterOptions(decimals: 36, withSi: true);
      var option4 = BalanceFormatterOptions(withSi: true);
      var option5 = BalanceFormatterOptions(withSi: true, withUnit: 'BAR');
      var option6 = BalanceFormatterOptions(
        withSi: true,
      );
      var option7 = BalanceFormatterOptions(
        forceUnit: '-',
      );
      var option8 = BalanceFormatterOptions(
        withUnit: '🔥',
      );

      BalanceFormatter();
      expect(BalanceFormatter.instance.formatBalance(testVal, option1),
          '123.4567 µUnit'); // 123.4567 µUnit
      expect(BalanceFormatter.instance.formatBalance(123456, option2),
          '123.4560 kUnit'); // 123.4560 kUnit
      expect(BalanceFormatter.instance.formatBalance(testVal, option3),
          '0.1234 yUnit'); // 0.1234 yUnit
      expect(BalanceFormatter.instance.formatBalance(testVal, option4, 6),
          '123.4567 kUnit'); // 123.4567 kUnit
      expect(BalanceFormatter.instance.formatBalance(testVal, option5, 6),
          '123.4567 kBAR'); // 123.4567 kBAR
      expect(BalanceFormatter.instance.formatBalance(BigInt.from(-123456789000), option6, 15),
          '-123.4567 µUnit'); // -123.4567 µUnit
      expect(BalanceFormatter.instance.formatBalance(testVal, option7, 7),
          '12,345.6789 Unit'); // 12,345.6789 Unit
      expect(BalanceFormatter.instance.formatBalance(testVal, option8, 15),
          '123.4567 µ🔥'); // 123.4567 µ🔥
      BalanceFormatter.instance.setDefaults(Defaults(decimals: 0, unit: 'TEST'));
      expect(BalanceFormatter.instance.getOptions()[0]["text"],
          "TEST"); // [{power: 0, text: TEST, value: -},...]
      // print("\n");
    } catch (e) {
      throw "format Error: $e";
    }
  });
}
