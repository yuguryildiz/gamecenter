import 'dart:async';

import 'package:flutter/services.dart';

class GameCenter {
  static const MethodChannel _channel = const MethodChannel('gamecenter');

  static Future get connect async {
    await _channel.invokeMethod('connect');
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    // return version;
  }
}
