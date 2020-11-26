import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class UByteReader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    int x = rdr.readByte();
    if (x < 0) {
      return 256 + x;
    }
    return x;
  }
}
