import 'package:polkadot_dart/types/codec/Map.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

BTreeMap<K, V> Function(Registry, [dynamic])
    _bTreeMapWith<K extends BaseCodec, V extends BaseCodec>(dynamic keyType, dynamic valType) {
  return (Registry registry, [dynamic value]) => BTreeMap<K, V>(registry, keyType, valType, value);
}

class BTreeMap<K extends BaseCodec, V extends BaseCodec> extends CodecMap<K, V> {
  BTreeMap(Registry registry, keyType, valType, rawValue)
      : super(registry, keyType, valType, rawValue, "BTreeMap");
  BTreeMap.empty() : super.empty();
  static Constructor<T>
      withParams<K extends BaseCodec, V extends BaseCodec, T extends BTreeMap<K, V>>(
              dynamic keyType,
              [dynamic valType]) =>
          _bTreeMapWith(keyType, valType);

  static BTreeMap constructor(Registry registry,
          [dynamic keyType, dynamic valType, dynamic rawValue]) =>
      BTreeMap(registry, keyType, valType, rawValue);

  static BTreeMap withTransformer<T1 extends BaseCodec, F1 extends BaseCodec, T2 extends BaseCodec,
      F2 extends BaseCodec>(
    BTreeMap codec,
    CodecTransformer<T1, F1> keyTransformer,
    CodecTransformer<T2, F2> valTransformer,
  ) {
    return BTreeMap.empty()
      ..registry = codec.registry
      ..setKeyClass(null)
      ..setValClass(null)
      ..setType(codec.type)
      ..setValue(codec.value.entries.fold<Map<T1, T2>>({}, (result, entry) {
        final newEntry = MapEntry(keyTransformer(entry.key), valTransformer(entry.value));
        result.putIfAbsent(newEntry.key, () => newEntry.value);
        return result;
      }));
  }
}
