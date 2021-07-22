const SI_MID = 8;
// ignore: non_constant_identifier_names
const SI = [
  {"power": -24, "text": 'yocto', "value": 'y'},
  {"power": -21, "text": 'zepto', "value": 'z'},
  {"power": -18, "text": 'atto', "value": 'a'},
  {"power": -15, "text": 'femto', "value": 'f'},
  {"power": -12, "text": 'pico', "value": 'p'},
  {"power": -9, "text": 'nano', "value": 'n'},
  {"power": -6, "text": 'micro', "value": 'µ'},
  {"power": -3, "text": 'milli', "value": 'm'},
  {"power": 0, "text": 'Unit', "value": '-'}, // position 8
  {"power": 3, "text": 'Kilo', "value": 'k'},
  {"power": 6, "text": 'Mega', "value": 'M'},
  {"power": 9, "text": 'Giga', "value": 'G'},
  {"power": 12, "text": 'Tera', "value": 'T'},
  {"power": 15, "text": 'Peta', "value": 'P'},
  {"power": 18, "text": 'Exa', "value": 'E'},
  {"power": 21, "text": 'Zeta', "value": 'Z'},
  {"power": 24, "text": 'Yotta', "value": 'Y'}
];

Map<String, dynamic> findSi(String type) {
  // use a loop here, better RN support (which doesn't have [].find)
  for (var i = 0; i < SI.length; i++) {
    if (SI[i]["value"] == type) {
      return SI[i];
    }
  }
  return SI[SI_MID];
}

Map<String, dynamic> calcSi(String text, num decimals, [String? forceUnit]) {
  if (forceUnit != null) {
    return findSi(forceUnit);
  }
  int siDefIndex = (SI_MID - 1) + ((text.length - decimals.toInt()) / 3).ceil();

  return siDefIndex >= 0 ? SI[siDefIndex] : SI[siDefIndex < 0 ? 0 : SI.length - 1];
}
