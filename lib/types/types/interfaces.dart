import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/types/types/codec.dart';

abstract class ICompact<T> extends BaseCodec {
  BigInt toBigInt();
  BigInt toBn();
  int toNumber();
  T unwrap();
}

abstract class IKeyringPair {
  String address;
  Uint8List addressRaw;
  Uint8List publicKey;
  Uint8List sign(Uint8List data, [SignOptions options]);
}

// abstract class IMethod extends BaseCodec {
//   List<BaseCodec> args;
//   Map<String, Constructor> argsDef;
//   Uint8List callIndex;
//   Uint8List data;
//   Hash hash;
//   bool hasOrigin;
//   dynamic meta; // FunctionMetadataLatest;
// }

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
