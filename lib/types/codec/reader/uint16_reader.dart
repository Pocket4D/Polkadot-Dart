import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class UInt16Reader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    int result = 0;
    result += rdr.readUByte();
    result += rdr.readUByte() << 8;
    return result;
  }
}
