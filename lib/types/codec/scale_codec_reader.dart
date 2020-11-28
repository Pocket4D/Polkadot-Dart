import 'dart:typed_data';

import 'package:optional/optional.dart';
import 'package:polkadot_dart/types/codec/reader/reader.dart';
import 'package:polkadot_dart/types/codec/scale_reader.dart';
import 'package:polkadot_dart/utils/utils.dart';

class ScaleCodecReader<T> {
  static final UByteReader uByte = UByteReader();
  static final UInt16Reader uInt16Reader = UInt16Reader();
  static final UInt32Reader uInt32Reader = UInt32Reader();
  static final UInt128Reader uInt128Reader = UInt128Reader();
  static final Int32Reader int32Reader = Int32Reader();
  static final CompactUIntReader compactUintReader = CompactUIntReader();
  static final CompactBigIntReader compactBigIntReader = CompactBigIntReader();
  static final EraReader eraReader = EraReader();
  static final BoolReader boolReader = BoolReader();
  static final BoolOptionalReader boolOptionReader = BoolOptionalReader();
  static final StringReader stringReader = StringReader();

  Uint8List source;
  int pos = 0;

  ScaleCodecReader(Uint8List source) {
    this.source = source;
  }

  ///
  /// @return true if has more elements
  bool hasNext() {
    return pos < source.length;
  }

  /// Move reader position forward (or backward for negative value)
  /// @param len amount to bytes to skip
  void skip(int len) {
    if (len < 0 && len.abs() > pos) {
      throw "Position cannot be negative:  $pos  $len";
    }
    pos += len;
  }

  /// Specify a  position
  /// @param pos position
  void seek(int pos) {
    if (pos < 0) {
      throw "Position cannot be negative: $pos";
    } else if (pos >= source.length) {
      throw "Position $pos must be strictly smaller than source length: ${source.length}";
    }

    this.pos = pos;
  }

  /// @return a next single byte from reader
  int readByte() {
    if (!hasNext()) {
      throw "Cannot read $pos of $source.length";
    }
    return source[pos++];
  }

  /// Read complex value from the reader
  /// @param scaleReader reader implementation
  /// @param <T> resulting type
  /// @return read value
  T read(ScaleReader<T> scaleReader) {
    if (scaleReader == null) {
      throw "ItemReader cannot be null";
    }
    return scaleReader.read(this);
  }

  int readUByte() {
    return uByte.read(this);
  }

  int readUint16() {
    return uInt16Reader.read(this);
  }

  int readUint32() {
    return uInt32Reader.read(this);
  }

  BigInt readUint128() {
    return uInt128Reader.read(this);
  }

  int readCompactInt() {
    return compactUintReader.read(this);
  }

  int readEra() {
    return eraReader.read(this);
  }

  bool readBoolean() {
    return boolReader.read(this);
  }

  /// Read optional value from the reader
  /// @param scaleReader reader implementation
  /// @param <T> resulting type
  /// @return optional read value
  Optional<T> readOptional(ScaleReader<T> scaleReader) {
    if (scaleReader is BoolReader || scaleReader is BoolOptionalReader) {
      return Optional.of(read(boolOptionReader as ScaleReader<T>));
    }
    bool some = readBoolean();
    if (some) {
      return Optional.of(read(scaleReader));
    } else {
      return Optional.empty();
    }
  }

  Uint8List readUint256() {
    return readByteArray(32);
  }

  Uint8List readByteArray([int len]) {
    if (len == null) {
      return readByteArray(readCompactInt());
    }

    Uint8List result = Uint8List(len);

    result.setAll(0, source.sublist(pos, pos + result.length));
    // System.arraycopy(source, pos, result, 0, result.length);
    pos += len;
    return result;
  }

  /// Read string, encoded as UTF-8 bytes
  /// @return string value
  String readString() {
    return u8aToString(readByteArray());
  }
}
