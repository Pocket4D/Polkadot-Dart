import 'package:polkadot_dart/types/codec/abstract_array.dart';
import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';

import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

const MAX_LENGTH = 64 * 1024;

Vec Function(Registry, List<dynamic>) vecWith(dynamic type) {
  return (Registry registry, List<dynamic> value) => Vec(registry, type, value);
}

class Vec<T extends BaseCodec> extends AbstractArray<T> {
  Constructor<T> _type;

  Vec(Registry registry, dynamic type, [dynamic value])
      : super(registry, Vec.decodeVec(registry, typeToConstructor<T>(registry, type), value)) {
    if (value == null) {
      value = [];
    }
    final clazz = typeToConstructor<T>(registry, type);
    this._type = clazz;
  }

  /// @internal */
  static List<T> decodeVec<T extends BaseCodec>(
      Registry registry, Constructor<T> type, dynamic value) {
    if (value is List) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-return
      return (value).map((entry) {
        final index = value.indexOf(entry);
        try {
          return entry is Constructor ? entry : type(registry, entry);
        } catch (error) {
          throw "Unable to decode on index $index $error";
        }
      });
    }

    final u8a = u8aToU8a(value);
    final compact = compactFromU8a(u8a);
    final offset = compact[0] as int;
    final length = compact[1] as BigInt;
    assert(length.toInt() <= (MAX_LENGTH), "Vec length ${length.toString()} exceeds $MAX_LENGTH");
    return decodeU8a(registry, u8a.sublist(offset), List.filled(length.toInt(), type));
  }

  static Constructor<Vec<O>> withParams<O extends BaseCodec>(dynamic type) => vecWith(type);

  /// @description The type for the items
  get type {
    Type typeName = T;
    return typeName.toString();
  }

  /// @description Finds the index of the value in the array
  int indexOf([dynamic _other]) {
    // convert type first, this removes overhead from the eq
    final other = _other is BaseCodec ? _other : this._type(this.registry, _other);

    for (var i = 0; i < this.length; i++) {
      if (other.eq(this.values[i])) {
        return i;
      }
    }

    return -1;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return "Vec<${this.registry.getClassName(this._type) ?? this._type(this.registry).toRawType()}>";
  }
}
