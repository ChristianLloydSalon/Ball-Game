import 'package:ball_game/ball_game/ball_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ball Game',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return GameWidget(
          game: BallGame(),
        );
      },
    );
  }
}
