import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:stack/stack.dart';

import 'ball.dart';
import 'stack_ball_game.dart';
import 'stage.dart';

class Pillar extends SpriteComponent with HasGameRef<StackBallGame>, TapCallbacks {
  Stack<int> stack = Stack<int>();
  final int maxBalls;
  final Stage stage;

  Pillar({required this.maxBalls, required this.stage});

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    sprite = await gameRef.loadSprite('games/stackball/pilar_texture.png');
    return super.onLoad();
  }

  void pushBall(int ballIndex) {
    stack.push(ballIndex);
  }

  int popBall() {
    return stack.pop();
  }

  int getSize() {
    return stack.size();
  }

  bool compare(Stack<int> other) {
    List<int> lhs = stack.toList();
    List<int> rhs = other.toList();

    if (lhs.length != rhs.length) return false;
    for (int i = 0; i < lhs.length; ++i) {
      if (lhs[i] != rhs[i]) return false;
    }

    return true;
  }

  int remainCount() {
    return maxBalls - getSize();
  }

  void createBallInstance() {
    List<int> list = stack.toList();
    for (int i = 0; i < list.length; ++i) {
      final Ball ball = Ball(
          position: Vector2(position.x, stage.resizeScalar(-44) * i.toDouble()),
          size: stage.resizeVector(Vector2(80, 44)),
          ballIndex: list[i])
        ..parentPillar = this;
      stage.addBall(ball);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (stage.basket == null) return;
    if (gameRef.isTweening) return;
    if (stage.basket!.ballIndex == -1) return;

    gameRef.isTweening = true;
    Vector2 toPos = Vector2(position.x, position.y - stack.size() * 44);

    Vector2 pillarTopPos = Vector2(position.x, position.y);
    pillarTopPos.y -= size.y;

    Ball ball = stage.basket!.ball!;

    final path = Path()
      ..moveTo(ball.position.x, ball.position.y)
      ..lineTo(pillarTopPos.x, pillarTopPos.y)
      ..lineTo(toPos.x, toPos.y);

    ball.add(MoveAlongPathEffect(path, EffectController(duration: 1.0),
        absolute: true, onComplete: () {
      gameRef.isTweening = false;
      stack.push(stage.basket!.ballIndex);
      stage.basket?.ballIndex = -1;
      stage.basket?.ball = null;
      ball.parentPillar = this;
      gameRef.currMoveCount++;
      gameRef.updateCurrMoveCount();
      gameRef.checkCorrect();
    }));
  }
}
