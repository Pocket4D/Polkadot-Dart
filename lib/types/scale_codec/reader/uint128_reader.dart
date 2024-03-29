import 'dart:typed_data';

import 'package:polkadot_dart/polkadot_dart.dart';
import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_reader.dart';

class UInt128Reader implements ScaleReader<BigInt> {
  static final int sizeBytes = 16;

  Uint8List reverse(Uint8List value) {
    for (int i = 0; i < value.length / 2; i++) {
      int other = value.length - i - 1;
      int tmp = value[other];
      value[other] = value[i];
      value[i] = tmp;
    }
    return value;
  }

  BigInt read(ScaleCodecReader rdr) {
    Uint8List value = rdr.readByteArray(sizeBytes);
    var reversed = reverse(value);
    return u8aToBn(reversed, endian: Endian.big).toUnsigned(128);
  }
}
