library utils;

export 'array.dart';
export 'string.dart';
export 'number.dart';
export 'u8a.dart';
export 'format.dart';
export 'si.dart';
export 'is.dart';
export 'hex.dart';
export 'bn.dart';
export 'compact.dart';
export 'time.dart';
export 'extension.dart';
export 'logger.dart';
export 'types.dart';

String throwReturn(String message) {
  if (message.startsWith("Error:")) {
    throw message;
  } else {
    return message;
  }
}
