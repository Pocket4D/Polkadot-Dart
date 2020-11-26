import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class EraReader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    int low = rdr.readByte();
    if (low != 0) {
      int high = rdr.readByte();
      return high.toUnsigned(high.bitLength) << 8 | low.toUnsigned(low.bitLength);
    } else {
      return 0;
    }
  }
}
