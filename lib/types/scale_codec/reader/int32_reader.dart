import 'dart:typed_data';

import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_reader.dart';
import 'package:polkadot_dart/utils/utils.dart';

class Int32Reader implements ScaleReader<int> {
  int read(ScaleCodecReader rdr) {
    var list = List<int>(4);
    for (var i = 0; i < 4; i += 1) {
      list[i] = rdr.readByte();
    }

    final value = Uint8List.fromList(list);

    return decodeBigInt(value, endian: Endian.little).toSigned(32).toInt();
  }
}
