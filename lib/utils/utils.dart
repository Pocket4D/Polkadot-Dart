library utils;

export 'string.dart';
export 'number.dart';
export 'u8a.dart';
export 'format.dart';
export 'si.dart';
export 'metadata.dart';
export 'is.dart';
export 'hex.dart';
export 'bn.dart';
export 'compact.dart';
export 'time.dart';

String throwReturn(String message) {
  if (message.startsWith("Error:")) {
    throw message;
  } else {
    return message;
  }
}
