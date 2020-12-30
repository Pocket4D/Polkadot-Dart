import 'package:polkadot_dart/types/generic/AccountId.dart';
import 'package:polkadot_dart/types/generic/AccountIndex.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/util_crypto/util_crypto.dart';
import 'package:polkadot_dart/utils/utils.dart';

decodeMultiU8a(Registry registry, [dynamic value]) {
  if (isU8a(value) && value.length <= 32) {
    if (value.length == 32) {
      return {"id": value};
    } else if (value.length == 20) {
      return {"Address20": value};
    } else {
      return decodeMultiAny(registry, registry.createType('AccountIndex', value));
    }
  }

  return value;
}

decodeMultiAny(Registry registry, [dynamic value]) {
  if (value is GenericMultiAddress) {
    return value;
  } else if (value is GenericAccountId) {
    return {"Id": value};
  } else if (value is GenericAccountIndex || isNumber(value) || isBn(value)) {
    return {"Index": registry.createType('Compact<AccountIndex>', value)};
  } else if (isString(value)) {
    return decodeMultiU8a(registry, decodeAddress(value.toString()));
  }

  return decodeMultiU8a(registry, value);
}

class GenericMultiAddress extends Enum {
  GenericMultiAddress(Registry registry, [dynamic value])
      : super(
            registry,
            {
              "Id": 'AccountId',
              "Index": 'Compact<AccountIndex>',
              "Raw": 'Bytes',
              // eslint-disable-next-line sort-keys
              "Address32": 'H256',
              // eslint-disable-next-line sort-keys
              "Address20": 'H160'
            },
            decodeMultiAny(registry, value));

  static GenericMultiAddress constructor(Registry registry, [dynamic value]) =>
      GenericMultiAddress(registry, value);

  factory GenericMultiAddress.from(Enum origin) =>
      GenericMultiAddress(origin.registry, origin.value);

  /// @description Returns the string representation of the value
  String toString() {
    return this.value.toString();
  }
}
