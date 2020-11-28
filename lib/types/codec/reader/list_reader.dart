import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

class ListReader<T> implements ScaleReader<List<T>> {
  ScaleReader<T> scaleReader;

  ListReader(ScaleReader<T> scaleReader) {
    this.scaleReader = scaleReader;
  }

  List<T> read(ScaleCodecReader rdr) {
    int size = rdr.readCompactInt();
    List<T> result = List(size);
    for (int i = 0; i < size; i++) {
      result[i] = (rdr.read(scaleReader));
    }
    return result;
  }
}
