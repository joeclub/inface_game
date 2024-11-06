import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'match_emotion_game.dart';

class Emotion extends SpriteComponent with HasGameRef<MatchEmotionGame>, TapCallbacks {
  Emotion( {required super.position, required this.spriteName, required this.emotionIndex} );
  
  final String spriteName;
  bool isTapped = false;

  late Sprite spriteTapped;
  SpriteComponent? tapped;
  int emotionIndex;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(200, 208);
    spriteTapped = await gameRef.loadSprite('games/matchemotion/over_chk@2x.png');
    sprite = await gameRef.loadSprite('games/emotionfit/$spriteName');
    paint.filterQuality = FilterQuality.high;
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    
    if( isTapped == false ){
      tapped = SpriteComponent(
        sprite: spriteTapped,
        position: size * 0.5,
        size: Vector2(200, 208),
        anchor: Anchor.center,
      );
      add(tapped!);
      gameRef.addSelectedEmotion(1);
    } else {
      remove(tapped!);
      gameRef.addSelectedEmotion(-1);
    }

    isTapped = !isTapped;
  }
}
