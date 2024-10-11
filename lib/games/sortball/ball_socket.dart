import 'dart:async';

import 'package:flame/components.dart';

import 'ball.dart';

class BallSocket extends SpriteComponent with HasGameRef {
  Ball? ball;
  bool isScale;
  BallSocket({required super.position, required this.isScale});
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = isScale ? Vector2.all(130) : Vector2.all(70);
    String spriteName = isScale ? 'compareBallBg' : 'resultBallBg';
    sprite = await gameRef.loadSprite('games/sortball/$spriteName.png');
    return super.onLoad();
  }

  bool setBall(Ball fromBall, Vector2 parentPos) {
    Vector2 worldPos = position + parentPos;
    if (worldPos.x - size.x * 0.5 < fromBall.position.x &&
        worldPos.x + size.x * 0.5 > fromBall.position.x &&
        worldPos.y - size.y * 0.5 < fromBall.position.y &&
        worldPos.y + size.y * 0.5 > fromBall.position.y) {
      if (ball != null) {
        ball!.position = Vector2.copy(ball!.oldPos);
      }
      fromBall.position = Vector2.copy(worldPos);
      ball = fromBall;
      return true;
    }
    return false;
  }
}
