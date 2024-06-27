import 'package:ball_game/ball_game/ball_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent
    with HasGameRef<BallGame>, CollisionCallbacks {
  static const double speed = 100.0;
  Vector2 direction;

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

    position += direction * speed * dt;

    if (position.x < 0 || position.x > gameRef.size.x) direction.x *= -1;
    if (position.y < 0 || position.y > gameRef.size.y) direction.y *= -1;

    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      final Vector2 collisionNormal = (other.position - position).normalized();

      final Vector2 relativeVelocity = direction - other.direction;
      final double velocityAlongNormal = relativeVelocity.dot(collisionNormal);

      if (velocityAlongNormal > 0) return;

      const double restitution = 1; // Assuming a perfectly elastic collision
      final double impulseMagnitude = -(1 + restitution) * velocityAlongNormal;
      direction += collisionNormal * impulseMagnitude;
      other.direction -= collisionNormal * impulseMagnitude;
    }
  }
}