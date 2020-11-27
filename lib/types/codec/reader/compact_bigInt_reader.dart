import 'dart:typed_data';

import 'package:p4d_rust_binding/p4d_rust_binding.dart';
import 'package:p4d_rust_binding/types/codec/compact_mode.dart';
import 'package:p4d_rust_binding/types/codec/reader/compact_uint_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class CompactBigIntReader implements ScaleReader<BigInt> {
  static final CompactUIntReader intReader = new CompactUIntReader();

  BigInt read(ScaleCodecReader rdr) {
    int type = rdr.readUByte();
    CompactModeType mode = CompactMode.byValue((type & 3));
    if (mode != CompactModeType.BIGINT) {
      rdr.skip(-1);
      int value = intReader.read(rdr);
      return BigInt.from(value);
    }
    int len = (type >> 2) + 4;
    Uint8List value = rdr.readByteArray(len);
    //LE encoded, so need to reverse it
    for (int i = 0; i < value.length / 2; i++) {
      int temp = value[i];
      value[i] = value[value.length - i - 1];
      value[value.length - i - 1] = temp;
    }
    //unsigned, i.e. always positive, signum=1
    return u8aToBn(value, endian: Endian.big, isNegative: false);
  }
}
