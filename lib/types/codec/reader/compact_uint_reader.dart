import 'package:polkadot_dart/types/codec/compact_mode.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

class CompactUIntReader implements ScaleReader<int> {
  ///
  /// @param rdr reader with the encoded data
  /// @return integer value
  /// @throws UnsupportedOperationException if the value is encoded with more than four bytes (use {@link CompactBigIntReader})
  int read(ScaleCodecReader rdr) {
    int i = rdr.readUByte();
    CompactModeType mode = CompactMode.byValue((i & 3));
    if (mode == CompactModeType.SINGLE) {
      return i >> 2;
    }
    if (mode == CompactModeType.TWO) {
      return (i >> 2) + (rdr.readUByte() << 6);
    }
    if (mode == CompactModeType.FOUR) {
      return (i >> 2) +
          (rdr.readUByte() << 6) +
          (rdr.readUByte() << (6 + 8)) +
          (rdr.readUByte() << (6 + 2 * 8));
    }
    throw "Mode $mode is not implemented";
  }
}
