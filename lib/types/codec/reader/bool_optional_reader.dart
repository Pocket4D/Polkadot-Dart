import 'package:optional/optional.dart';
import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';
import 'package:p4d_rust_binding/types/codec/scale_reader.dart';

class BoolOptionalReader implements ScaleReader<Optional<bool>> {
  Optional<bool> read(ScaleCodecReader rdr) {
    int b = rdr.readByte();
    if (b == 0) {
      return Optional.empty();
    }
    if (b == 1) {
      return Optional.of(false);
    }
    if (b == 2) {
      return Optional.of(true);
    }
    throw "Not a boolean option: $b";
  }
}
