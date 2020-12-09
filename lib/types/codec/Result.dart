import 'package:polkadot_dart/types/codec/Enum.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class Result<O extends BaseCodec, E extends BaseCodec> extends Enum {
  Result(Registry registry, dynamic ok, dynamic error, [dynamic value])
      : super(registry, {"Ok": ok, "Error": error}, value);

  static withParams(Map<String, dynamic> types) {
    return (Registry registry, [dynamic value]) {
      return Result(registry, types["Ok"], types["Error"], value);
    };
  }

  /// @description Returns the wrapper Error value (if isError)
  E get asError {
    assert(this.isError, 'Cannot extract Error value from Ok result, check isError first');

    return this.value as E;
  }

  /// @description Returns the wrapper Ok value (if isOk)
  O get asOk {
    assert(this.isOk, 'Cannot extract Ok value from Error result, check isOk first');
    return this.value as O;
  }

  /// @description Checks if the Result has no value
  bool get isEmpty {
    return this.isOk && this.value.isEmpty;
  }

  /// @description Checks if the Result wraps an Error value
  bool get isError {
    return !this.isOk;
  }

  /// @description Checks if the Result wraps an Ok value
  bool get isOk {
    return this.index == 0;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    final types = this.toRawStruct();

    return "Result<${types['Ok']},${types['Error']}>";
  }
}
