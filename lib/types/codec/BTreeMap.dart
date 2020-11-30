import 'package:polkadot_dart/types/codec/Map.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

BTreeMap Function(Registry, dynamic) _bTreeMapWith(dynamic keyType, dynamic valType) {
  return (Registry registry, dynamic value) => BTreeMap(registry, keyType, valType, value);
}

class BTreeMap<K extends BaseCodec, V extends BaseCodec> extends CodecMap<K, V> {
  BTreeMap(Registry registry, keyType, valType, rawValue)
      : super(registry, keyType, valType, rawValue, "BTreeMap");

  static Constructor<BTreeMap<K, V>> withParams<K extends BaseCodec, V extends BaseCodec>(
          dynamic keyType, dynamic valType) =>
      _bTreeMapWith(keyType, valType);
}
