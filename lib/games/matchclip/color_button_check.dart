import 'dart:async';

import 'package:flame/components.dart';

import 'match_clip_game.dart';

class ColorButtonCheck extends SpriteComponent with HasGameRef<MatchClipGame>, HasVisibility {
  ColorButtonCheck( {required super.position } );

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(45, 45);
    sprite = gameRef.checkSprite;
    
    return super.onLoad();
  }
}