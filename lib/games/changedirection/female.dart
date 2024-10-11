import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Female extends SpriteComponent with HasGameRef, TapCallbacks {
  Female({required super.position});
  int dir = 1;

  late Sprite leftSprite;
  late Sprite rightSprite;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(34, 34);
    leftSprite = await gameRef.loadSprite('games/changedirection/leftComplite.png');
    rightSprite = await gameRef.loadSprite('games/changedirection/rightComplite.png');

    dir = Random().nextInt(2);
    sprite = ( dir == 0 ) ? leftSprite : rightSprite;

    return super.onLoad();
  }
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    dir = (dir == 0) ? 1 : 0;
    sprite = ( dir == 0 ) ? leftSprite : rightSprite;
  }
}