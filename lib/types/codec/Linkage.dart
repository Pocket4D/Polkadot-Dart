import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Option.dart';
import 'package:polkadot_dart/types/codec/Struct.dart';
import 'package:polkadot_dart/types/codec/Tuple.dart';
import 'package:polkadot_dart/types/codec/Vec.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

Linkage<T> Function(Registry, Uint8List) linkageWith<T extends BaseCodec>(dynamic type) {
  return (Registry registry, [dynamic value]) => Linkage<T>(registry, type, value);
}

class Linkage<T extends BaseCodec> extends Struct {
  Linkage(Registry registry, dynamic type, [dynamic value])
      : super(
            registry,
            {
              "previous": Option.withParams(type),
              // eslint-disable-next-line sort-keys
              "next": Option.withParams(type)
            },
            value as String);

  static Constructor<Linkage<O>> withKey<O extends BaseCodec>(dynamic type) => linkageWith(type);

  static Linkage constructor(Registry registry, [dynamic type, dynamic value]) =>
      Linkage(registry, type, value);

  Option<T> get previous {
    return this.getCodec('previous') as Option<T>;
  }

  Option<T> get next {
    return this.getCodec('next') as Option<T>;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "Linkage<${this.next.toRawType(true)}>";
  }

  /// @description Custom toU8a which with bare mode does not return the linkage if empty
  Uint8List toU8a([dynamic isBare]) {
    // As part of a storage query(where these appear), in the case of empty, the values
    // are NOT populated by the node - follow the same logic, leaving it empty
    return this.isEmpty ? Uint8List(0) : super.toU8a();
  }
}

class LinkageResult extends Tuple {
  LinkageResult(Registry registry, List<dynamic> typeKeys, List<dynamic> typeValues)
      : super(
            registry,
            {'Keys': Vec.withParams(typeKeys[0]), 'Values': Vec.withParams(typeValues[0])},
            [typeKeys[1], typeValues[1]]);
}
