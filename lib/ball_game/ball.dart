import 'package:ball_game/ball_game/ball_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent
    with HasGameRef<BallGame>, CollisionCallbacks {
  static const double speed = 100.0;

  Vector2 direction;
  bool markedForRemoval = false;

  Ball({required Vector2 position})
      : direction = (Vector2.random() - Vector2(0.5, 0.5)).normalized(),
        super(
          position: position,
          radius: 20.0,
          anchor: Anchor.center,
          paint: Paint()..color = Colors.blue,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Remove the ball if it's marked for removal
    if (markedForRemoval) {
      removeFromParent();
      return;
    }

    position += direction * speed * dt;

    if (position.x < 0 || position.x > gameRef.size.x) direction.x *= -1;
    if (position.y < 0 || position.y > gameRef.size.y) direction.y *= -1;

    // Mark the ball for removal if it's outside the screen
    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      markedForRemoval = true;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ball) {
      direction = (position - other.position).normalized();
    }
  }
}
