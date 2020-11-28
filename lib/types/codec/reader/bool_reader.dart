import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

class BoolReader implements ScaleReader<bool> {
  bool read(ScaleCodecReader rdr) {
    int b = rdr.readByte();
    if (b == 0) {
      return false;
    }
    if (b == 1) {
      return true;
    }
    throw "Not a boolean value: $b";
  }
}
