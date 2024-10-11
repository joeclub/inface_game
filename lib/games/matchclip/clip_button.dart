import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'match_clip_game.dart';

class ClipButton extends SpriteComponent with HasGameRef<MatchClipGame>, TapCallbacks {
  ClipButton( {required super.position, required this.clipIndex } );

  int clipIndex;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(28, 75);
    sprite = gameRef.clipSprite;

    switch(clipIndex){
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

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.onClickClipButton(clipIndex);
  }

  void checkSelected(bool selected){
    sprite = selected ? gameRef.selectedSprite : gameRef.clipSprite;
  }
}