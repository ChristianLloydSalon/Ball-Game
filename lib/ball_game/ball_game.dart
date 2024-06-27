import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'data/model/ball.dart';

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
