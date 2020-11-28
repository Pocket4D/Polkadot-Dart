import 'dart:typed_data';
import 'package:polkadot_dart/utils/utils.dart';
import 'package:polkadot_dart/types/codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';

/// Common shortcuts for SCALE extract
class ScaleExtract {
  /// Shortcut to setup extraction of an Object from bytes array
  ///
  /// @param reader actual reader to use
  ///
  /// @param <T> type of the result
  ///
  /// @return Function to apply for extraction
  //
  static T Function<T>(Uint8List) fromBytesArray<T>(ScaleReader<T> reader) {
    if (reader == null) {
      throw "ScaleReader is null";
    }

    T readerCallback<T>(Uint8List encoded) {
      ScaleCodecReader codec = ScaleCodecReader<T>(encoded);
      return codec.read(reader);
    }

    return readerCallback;
  }

  /// Shortcut to setup extraction of an Object from hex encoded bytes typically provided by RPC
  ///
  /// @param reader actual reader to use
  ///
  /// @param <T> type of the result
  ///
  /// @return Function to apply for extraction
  ///
  ///
  static T Function<T>(String) fromBytesData<T>(ScaleReader<T> reader) {
    if (reader == null) {
      throw "ScaleReader is null";
    }
    T readerCallback<T>(String encoded) {
      if (!isHex(encoded)) {
        throw "$encoded should be `0x` hex";
      }
      ScaleCodecReader codec = ScaleCodecReader(encoded.toU8a());
      return codec.read(reader);
    }

    return readerCallback;
  }
}
