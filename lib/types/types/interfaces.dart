import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
// import 'package:polkadot_dart/types/interfaces/runtime/typesbak.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:tuple/tuple.dart';

abstract class ICompact<T> extends BaseCodec {
  BigInt toBigInt();
  BigInt toBn();
  int toNumber();
  T unwrap();
}

abstract class IKeyringPair extends KeyringPair {
  String address;
  Uint8List addressRaw;
  Uint8List publicKey;
}

abstract class IMethod extends BaseCodec {
  List<BaseCodec> get args;
  Map<String, Constructor> get argsDef;
  Uint8List get callIndex;
  Uint8List get data;
  H256 get hash;
  bool get hasOrigin;
  FunctionMetadataLatest get meta; // ;
}

abstract class IRuntimeVersion {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  List<dynamic> apis;
  BigInt authoringVersion;
  // eslint-disable-next-line @typescript-eslint/ban-types
  String implName;
  BigInt implVersion;
  // eslint-disable-next-line @typescript-eslint/ban-types
  String specName;
  BigInt specVersion;
  BigInt transactionVersion;
}

abstract class IU8a extends BaseCodec {
  int get bitLength;
  dynamic toHuman([bool isExtended]);
  dynamic toJSON();
}

// export type ITuple<Sub extends Codec[]> = Sub & Codec
abstract class ITuple<S extends BaseCodec, E extends BaseCodec> extends Tuple2<S, E>
    implements BaseCodec {
  ITuple(S item1, E item2) : super(item1, item2);
}
