import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class StringReader implements ScaleReader<String> {
  String read(ScaleCodecReader rdr) {
    return rdr.readString();
  }
}
