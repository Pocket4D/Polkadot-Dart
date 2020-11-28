import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

class IterableReader<T> implements ScaleReader<T> {
  Iterable<T> values;

  /// Define reader by specifying list of possible values. In most of the cases it would be:
  /// <code>new EnumReader(MyEnum.values()</code>
  ///
  /// @param values list of enum values
  IterableReader(Iterable<T> values) {
    if (values == null) {
      throw "List of iterable is null";
    }
    if (values.length == 0) {
      throw "List of iterable is empty";
    }
    this.values = values;
  }

  T read(ScaleCodecReader rdr) {
    int id = rdr.readUByte();
    T result;
    for (var i = 0; i < values.length; i += 1) {
      if (i == id) {
        result = values.elementAt(i);
        break;
      }
    }
    if (result != null) return result;
    throw ("Unknown enum value: $id");
  }
}
