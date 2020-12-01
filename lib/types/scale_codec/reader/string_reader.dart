import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_reader.dart';

class StringReader implements ScaleReader<String> {
  String read(ScaleCodecReader rdr) {
    return rdr.readString();
  }
}
