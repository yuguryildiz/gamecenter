import 'dart:async';

import 'package:flutter/services.dart';

class GameCenter {
  static const MethodChannel _channel = const MethodChannel('gamecenter');

  static Future login({silent: true}) async {
    return await _channel.invokeMethod('login', silent);
  }

  static Future getPlayerName() async {
    return await _channel.invokeMethod('getPlayerName');
  }

  static Future showLeaderboard(String leaderboardId) async {
    return await _channel.invokeMethod('showLeaderboard', [leaderboardId]);
  }

  static Future showAchievementsBoard() async {
    return await _channel.invokeMethod('showAchievementsBoard');
  }

  static Future reportAchievement(String achievementId) async {
    return await _channel.invokeMethod('reportAchievement', [achievementId]);
  }

  static Future getScore(String leaderboardId) async {
    return await _channel.invokeMethod('getScore', [leaderboardId]);
  }

  static Future saveScore(String leaderboardId, int score) async {
    return await _channel.invokeMethod('saveScore', [leaderboardId, score]);
  }
}
