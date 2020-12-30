import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class AuthorityId extends AccountId {
  AuthorityId(Registry registry, [dynamic value]) : super(registry, value);
  factory AuthorityId.from(AccountId origin) => AuthorityId(origin.registry, origin.value);
}

class RawVRFOutput extends U8aFixed {
  RawVRFOutput(Registry registry, [dynamic value, int bitLength = 256, String typeName])
      : super(registry, value, bitLength ?? 256, typeName);
  factory RawVRFOutput.from(U8aFixed origin) =>
      RawVRFOutput(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

const PHANTOM_CONSENSUS = 'consensus';
