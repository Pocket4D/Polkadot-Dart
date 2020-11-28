import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

class UInt16Reader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    int result = 0;
    result += rdr.readUByte();
    result += rdr.readUByte() << 8;
    return result;
  }
}
