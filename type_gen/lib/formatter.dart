import 'package:polkadot_dart/types/types.dart';

/**
 * Given the inner `K` & `V`, return a `BTreeMap<K, V>`  string
 */
/** @internal */
String formatBTreeMap(String key, String val) {
  key = fixVal(key);
  val = fixVal(val);
  return "BTreeMap<$key, $val>";
}

/**
 * Given the inner `V`, return a `BTreeSet<V>`  string
 */
/** @internal */
String formatBTreeSet(val) {
  val = fixVal(val);
  return "BTreeSet<$val>";
}

/**
 * Given the inner `T`, return a `Compact<T>` string
 */
/** @internal */
String formatCompact(String inner) {
  inner = fixVal(inner);
  return paramsNotation('Compact', inner);
}

/**
 * Simple return
 */
/** @internal */
String formatDoNoConstruct() {
  return 'DoNotConstruct';
}

/**
 * Given the inner `K` & `V`, return a `BTreeMap<K, V>`  string
 */
/** @internal */
String formatHashMap(String key, String val) {
  key = fixVal(key);
  val = fixVal(val);
  return "HashMap<$key, $val>";
}

/**
 * Given the inner `T`, return a `Vec<T>` string
 */
/** @internal */
String formatLinkage(String inner) {
  inner = fixVal(inner);
  return paramsNotation('Linkage', inner);
}

/**
 * Given the inner `O` & `E`, return a `Result<O, E>`  string
 */
/** @internal */
String formatResult(String innerOk, String innerError) {
  innerOk = fixVal(innerOk);
  innerError = fixVal(innerError);
  return "Result<$innerOk, $innerError>";
}

/**
 * Given the inner `T`, return a `Option<T>` string
 */
/** @internal */
String formatOption(String inner) {
  inner = fixVal(inner);
  return paramsNotation('Option', inner);
}

/**
 * Given the inners `T[]`, return a `ITuple<...T>` string
 */
/** @internal */
String formatTuple(List<String> inners) {
  inners.forEach((element) {
    element = fixVal(element);
  });
  return paramsNotation('ITuple', inners.length > 1 ? "[${inners.join(', ')}]" : null);
}

/**
 * Given the inner `T`, return a `Vec<T>` string
 */
/** @internal */
String formatVec(String inner) {
  inner = fixVal(inner);
  return paramsNotation('Vec', inner);
}

String fixVal(String key) {
  if (key == "Text") {
    key = "CodecText";
  } else if (key == "null" || key == "Null") {
    key = "CodecNull";
  } else if (key == "bool" || key == "Bool") {
    key = "CodecBool";
  } else if (key == "set" || key == "Set") {
    key = "CodecSet";
  } else if (key == "int" || key == "Int") {
    key = "CodecInt";
  }
  return key;
}
