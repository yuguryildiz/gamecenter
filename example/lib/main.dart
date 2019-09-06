import 'package:flutter/material.dart';
import 'package:gamecenter/gamecenter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Game Center'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.login(silent: false));
                },
                child: Text("Login To Game Center"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.login(silent: true));
                },
                child: Text("Login To Game Center (Silent)"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.showLeaderboard("com.fty.flutter.leaderboard"));
                },
                child: Text("Show Leaderboard"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.showAchievementsBoard());
                },
                child: Text("Show Achievement Board"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.reportAchievement("com.fty.flutter.achievement"));
                },
                child: Text("Report Achievement"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.getScore("com.fty.flutter.leaderboard"));
                },
                child: Text("Get Score"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  print(await GameCenter.saveScore("com.fty.flutter.leaderboard", 10));
                },
                child: Text("Save Score: 10"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  var score = int.tryParse("${await GameCenter.getScore("com.fty.flutter.leaderboard")}");
                  score += 10;
                  print(await GameCenter.saveScore("com.fty.flutter.leaderboard", score));
                },
                child: Text("Save Score: +10"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
