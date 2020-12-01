import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_reader.dart';

class UByteReader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    int x = rdr.readByte();
    if (x < 0) {
      return 256 + x;
    }
    return x;
  }
}
