import 'dart:typed_data';

import 'package:polkadot_dart/keyring/types.dart';
import 'package:polkadot_dart/types/types.dart';

Uint8List sign(Registry registry, IKeyringPair signerPair, u8a, [SignOptions options]) {
  final encoded = u8a.length > 256 ? registry.hash(u8a) : u8a;
  return signerPair.sign(encoded, options);
}
