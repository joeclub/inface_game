import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'match_clip_game.dart';

class ClipSpriteComponent extends SpriteComponent with HasGameRef<MatchClipGame> {
  ClipSpriteComponent( {required super.position, required this.spriteIndex, required this.rotationIndex } );

  int spriteIndex;
  int rotationIndex;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(22, 60);
    sprite = gameRef.lstClipSprites[spriteIndex];
    paint.filterQuality = FilterQuality.high;
    
    switch(rotationIndex){
      case 0:{

      }
      break;
      case 1:{
        scale = Vector2(-1, 1);
      }
      break;
      case 2:{
        angle = pi;
      }
      break;
      case 3:{
        scale = Vector2(-1, 1);
        angle = pi;
      }
      break;
    }

    
    return super.onLoad();
  }
}