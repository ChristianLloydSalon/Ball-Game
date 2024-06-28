import 'package:ball_game/ball_game/ball.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BallGame extends FlameGame with TapDetector, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    final ball = Ball(position: info.eventPosition.global);
    add(ball);
  }
}
