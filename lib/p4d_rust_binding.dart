
import 'dart:async';

import 'package:flutter/services.dart';

class P4dRustBinding {
  static const MethodChannel _channel =
      const MethodChannel('p4d_rust_binding');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
