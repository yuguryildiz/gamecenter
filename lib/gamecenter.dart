import 'dart:async';

import 'package:flutter/services.dart';

class GameCenter {
  static const MethodChannel _channel = const MethodChannel('gamecenter');

  /// Login GameCenter for iOS or Google Play Games for Android.
  ///
  /// Returns True if connected and False if is not connected.
  ///
  /// [silent] If it is true SignIn view is not shown.
  static Future<bool> login({silent: true}) async {
    return await _channel.invokeMethod('login', silent);
  }

  /// Get the player nickname
  static Future<String> getPlayerName() async {
    return await _channel.invokeMethod('getPlayerName');
  }

  /// Show Leaderboard view.
  static Future showLeaderboard(String leaderboardId) async {
    return await _channel.invokeMethod('showLeaderboard', [leaderboardId]);
  }

  /// Show Achievements Board view.
  static Future showAchievementsBoard() async {
    return await _channel.invokeMethod('showAchievementsBoard');
  }

  /// Report an achievement to completed.
  static Future reportAchievement(String achievementId) async {
    return await _channel.invokeMethod('reportAchievement', [achievementId]);
  }

  /// Get player current score in entered Leaderboard Id.
  static Future<int> getScore(String leaderboardId) async {
    return await _channel.invokeMethod('getScore', [leaderboardId]);
  }

  /// Set player score in entered Loeaderboard Id.
  static Future saveScore(String leaderboardId, int score) async {
    return await _channel.invokeMethod('saveScore', [leaderboardId, score]);
  }
}
