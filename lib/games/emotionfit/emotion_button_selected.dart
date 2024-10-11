import 'dart:async';

import 'package:flame/components.dart';

import 'emotion_fit_game.dart';

class EmotionButtonSelected extends SpriteComponent with HasGameRef<EmotionFitGame>, HasVisibility {
  EmotionButtonSelected({required super.position});
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(160, 90);
    sprite = await gameRef.loadSprite('games/emotionfit/emotion_select.png');

    return super.onLoad();
  }
}