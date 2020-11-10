library utils;

export 'string.dart';
export 'number.dart';
export 'u8a.dart';

String throwReturn(String message) {
  if (message.startsWith("Error:")) {
    throw message;
  } else {
    return message;
  }
}
