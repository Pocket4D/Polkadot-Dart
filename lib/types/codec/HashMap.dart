import 'package:polkadot_dart/types/codec/Map.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

Constructor<CodecMap<K, V>> hashMapWithParams<K extends BaseCodec, V extends BaseCodec>(
        keyType, valType) =>
    (Registry registry, [dynamic value]) => CodecMap<K, V>(registry, keyType, valType, value);

class HashMap<K extends BaseCodec, V extends BaseCodec> extends CodecMap<K, V> {
  HashMap(Registry registry, dynamic keyType, dynamic valType, [dynamic value])
      : super(registry, keyType, valType, value);

  HashMap.empty() : super.empty();
  static Constructor<T>
      withParams<K extends BaseCodec, V extends BaseCodec, T extends CodecMap<K, V>>(
              keyType, valType) =>
          hashMapWithParams(keyType, valType);

  static HashMap constructor(Registry registry,
          [dynamic keyType, dynamic valType, dynamic value]) =>
      HashMap(registry, keyType, valType, value);
}
