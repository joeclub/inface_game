import 'dart:async';

import 'package:flame/components.dart';

class BalloonBottom extends SpriteComponent with HasGameRef {
  BalloonBottom({required super.position, required this.balloonIndex});
  final int balloonIndex;
    
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    size = Vector2(28, 20);
    sprite = await gameRef.loadSprite('games/blowballoon/ballonsBottom${balloonIndex+1}.png');

    return super.onLoad();
  }
}
