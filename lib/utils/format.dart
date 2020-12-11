import 'package:polkadot_dart/utils/si.dart';
import 'package:polkadot_dart/utils/utils.dart';

String zeroPad(int value) {
  return value.toString().padLeft(2, '0');
}

String formatDate(DateTime date) {
  final year = date.year.toString();
  final month = zeroPad((date.month));
  final day = zeroPad(date.day);
  final hour = zeroPad(date.hour);
  final minute = zeroPad(date.minute);
  final second = zeroPad(date.second);
  return "$year-$month-$day $hour:$minute:$second";
}

final numberRegex = RegExp(r"(\d+?)(?=(\d{3})+(?!\d)|$)", dotAll: true);
// final numberRegex = RegExp(r"/(\d)(?=(\d{3})+(?!\d))/g");

String formatDecimal(String value) {
  // We can do this by adjusting the regx, however for the sake of clarity
  // we rather strip and re-add the negative sign in the output
  final isNegative = value[0].startsWith('-');

  String split(String input) {
    var temp = input.splitMapJoin(numberRegex, onNonMatch: (m) => ",");
    var trimLeft = temp.startsWith(',') ? temp.substring(1) : temp;
    var trimRight = trimLeft.endsWith(',') ? trimLeft.substring(0, trimLeft.length - 1) : trimLeft;
    return trimRight;
  }

  final matched = isNegative ? split(value.substring(1)) : split(value);
  return matched.length > 0 ? "${isNegative ? '-' : ''}$matched" : value;
}

String formatValue(double elapsed) {
  if (elapsed < 15) {
    return "${elapsed.toStringAsFixed(1)}s";
  } else if (elapsed < 60) {
    return "${elapsed.floor()}s";
  } else if (elapsed < 3600) {
    var _h = elapsed / 60;
    return "${_h.floor()}m";
  }
  return "${(elapsed / 3600).floor()}h";
}

String formatElapsed([DateTime now, dynamic value]) {
  if (now != null && value != null) {
    var valueTime = DateTime.fromMillisecondsSinceEpoch(
        value is BigInt ? value.toInt() : BigInt.from(value).toInt());
    var diff = now.difference(valueTime).inMilliseconds / 1000;
    return formatValue(diff.abs());
  }
  return '0.0s';
}

String formatNumber(dynamic value) {
  var dec = value is BigInt ? value : BigInt.from(value);
  return formatDecimal(dec.toString());
}

class Defaults {
  final num decimals;
  final String unit;
  final List<Map<String, Object>> si;
  const Defaults({this.decimals, this.unit, this.si});
}

class BalanceFormatterOptions {
  num decimals;
  String forceUnit;
  bool withSi;
  bool withSiFull;
  dynamic withUnit;
  BalanceFormatterOptions(
      {this.decimals, this.forceUnit, this.withSi, this.withSiFull, this.withUnit});
}

abstract class Formatter {
  Map<String, Object> calcSi(String text, num decimals, [String forceUnit]);
  Map<String, Object> findSi(String type);
  Defaults getDefaults();
  List<Map<String, Object>> getOptions();
  void setDefaults(Defaults defaults);
}

class BalanceFormatter implements Formatter {
  num defaultDecimals;
  dynamic defaultUnit;
  List<Map<String, Object>> si;
  static BalanceFormatter _instance;
  static BalanceFormatter get instance => _instance;
  factory BalanceFormatter({Defaults defaults}) =>
      _getInstance(defaults: defaults ?? Defaults(decimals: 0, unit: SI[SI_MID]["text"] as String));
  static _getInstance({Defaults defaults}) {
    // 只能有一个实例
    if (_instance == null) {
      _instance = BalanceFormatter._internal(defaults: defaults);
    }
    return _instance;
  }

  BalanceFormatter._internal({Defaults defaults}) {
    setDefaults(defaults);
  }
  String formatBalance(dynamic input, BalanceFormatterOptions options, [num optDecimals]) {
    optDecimals = optDecimals ?? defaultDecimals;
    var bnValue;
    if (input is String) {
      bnValue = hexToBn(input);
    } else if (input is int) {
      bnValue = BigInt.from(input);
    } else if (input is BigInt) {
      bnValue = input;
    }
    var text = bnValue.toString();

    if (text.length == 0 || text == '0') {
      return '0';
    }
    final isNegative = text[0].startsWith('-');

    if (isNegative) {
      text = text.substring(1);
    }

    var decimals = options.decimals ?? optDecimals;
    var forceUnit = options.forceUnit ?? null;
    var withSi = options.withSi ?? true;
    var withSiFull = options.withSiFull ?? false;
    var withUnit = options.withUnit ?? true;

    var _si = calcSi(text, decimals, forceUnit);

    var mid = text.length - (decimals + _si["power"]);

    var prefix = text.substring(0, mid);

    var padding = mid < 0 ? 0 - mid : 0;

    var padString = "${List(padding + 1).join('0').replaceAll("null", "")}$text";

    var postfix = "${padString.substring(mid < 0 ? 0 : mid)}0000".substring(0, 4);
    var withU = (withUnit is bool) ? _si["text"] : withUnit;
    var uu = withSiFull ? ' ' : '';
    var zz = (withUnit is bool) ? SI[SI_MID]["text"] : withUnit;
    var finalU = (withUnit is bool && withUnit == true) || withUnit is String ? "$uu$zz" : '';
    var units = withSi || withSiFull
        ? _si["value"] == '-'
            ? (withUnit is bool && withUnit == true) || withUnit is String
                ? " $withU"
                : ''
            : " ${withSiFull ? _si["text"] : _si["value"]}$finalU"
        : '';

    return "${isNegative ? '-' : ''}${formatDecimal(prefix == "" ? '0' : prefix)}.$postfix$units";
  }

  Map<String, Object> calcSi(String text, num decimals, [String forceUnit]) {
    if (forceUnit != null) {
      return findSi(forceUnit);
    }
    int siDefIndex = (SI_MID - 1) + ((text.length - decimals.toInt()) / 3).ceil();

    return siDefIndex >= 0 ? si[siDefIndex] : si[siDefIndex < 0 ? 0 : si.length - 1];
  }

  Map<String, Object> findSi(String type) {
    for (var i = 0; i < si.length; i++) {
      if (si[i]["value"] == type) {
        return si[i];
      }
    }
    return si[SI_MID];
  }

  Defaults getDefaults() {
    var newList = List<Map<String, Object>>(SI.length);
    for (var i = 0; i < SI.length; i += 1) {
      newList[i] = Map<String, Object>();
      SI[i].forEach((key, value) {
        newList[i].addEntries([MapEntry(key, value)]);
      });
    }
    return Defaults(decimals: defaultDecimals, unit: defaultUnit, si: newList);
  }

  List<Map<String, Object>> getOptions([int decimals]) {
    decimals = decimals ?? defaultDecimals;
    return si.where((e) {
      return e["power"] as int < 0 ? (decimals + e["power"]) >= 0 : true;
    }).toList();
  }

  void setDefaults(Defaults defaults) {
    var newList = List<Map<String, Object>>(SI.length);
    for (var i = 0; i < SI.length; i += 1) {
      newList[i] = Map<String, Object>();
      SI[i].forEach((key, value) {
        newList[i].addEntries([MapEntry(key, value)]);
      });
    }
    defaultDecimals = defaults.decimals ?? defaultDecimals;
    defaultUnit = defaults.unit ?? defaultUnit;
    si = defaults.si ?? newList;
    si[SI_MID]["text"] = defaultUnit;
  }
}
