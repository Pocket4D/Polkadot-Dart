import 'package:p4d_rust_binding/types/codec/scale_codec_reader.dart';

abstract class ScaleReader<T> {
  /// Reads value from specified reader. The reader must be positioned on the beginning of the value
  ///
  /// @param rdr reader with the encoded data
  /// @return read value
  T read(ScaleCodecReader rdr);
}
