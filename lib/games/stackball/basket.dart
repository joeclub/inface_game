import 'dart:async';

import 'package:flame/components.dart';

import 'ball.dart';

class Basket extends SpriteComponent with HasGameRef {
  int ballIndex = -1;
  Ball? ball;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(120);
    sprite = await gameRef.loadSprite('games/stackball/basket.png');
    return super.onLoad();
  }
}
