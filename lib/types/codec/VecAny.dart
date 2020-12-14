import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class VecAny<T extends BaseCodec> extends AbstractArray<T> {
  VecAny(Registry registry, List<T> values) : super(registry, values);

  static VecAny constructor<T extends BaseCodec>(Registry registry, [dynamic values]) =>
      VecAny(registry, values as List<T>);

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    // FIXME This is basically an any type, cannot instantiate via createType
    return 'Vec<Codec>';
  }

  @override
  F cast<F extends BaseCodec>() {
    // TODO: implement cast
    return this as F;
  }
}
