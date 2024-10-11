import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'pillar.dart';
import 'stack_ball_game.dart';

class Ball extends SpriteComponent with HasGameRef<StackBallGame>, TapCallbacks {
  Ball({required super.position, required super.size, required this.ballIndex});
  Pillar? parentPillar;

  int ballIndex;
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    sprite = await gameRef.loadSprite('games/stackball/marble${ballIndex + 1}.png');
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (parentPillar?.stage.basket == null) return;
    if (gameRef.isTweening) return;
    if (parentPillar == null) return;
    if (parentPillar?.stack.top() != ballIndex) return;
    if (parentPillar!.stage.basket!.ballIndex >= 0) return;

    gameRef.isTweening = true;
    Vector2 toPos = Vector2(parentPillar!.stage.basket!.position.x,
        parentPillar!.stage.basket!.position.y);
    toPos.y += size.y * 0.5;

    Vector2 pillarTopPos =
        Vector2(parentPillar!.position.x, parentPillar!.position.y);
    pillarTopPos.y -= parentPillar!.size.y;

    final path = Path()
      ..moveTo(position.x, position.y)
      ..lineTo(pillarTopPos.x, pillarTopPos.y)
      ..lineTo(toPos.x, toPos.y);

    add(MoveAlongPathEffect(path, EffectController(duration: 1.0),
        absolute: true, onComplete: () {
      gameRef.isTweening = false;
      parentPillar!.stage.basket?.ballIndex = ballIndex;
      parentPillar!.stage.basket?.ball = this;
      parentPillar!.stack.pop();
      parentPillar = null;
    }));
  }
}
