import 'dart:async';

import 'package:flutter/services.dart';

class Gamecenter {
  static const MethodChannel _channel =
      const MethodChannel('gamecenter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
