import 'dart:async';

import 'package:flame/components.dart';

class Floor extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('games/stackball/wood_texture.png');
    return super.onLoad();
  }
}
