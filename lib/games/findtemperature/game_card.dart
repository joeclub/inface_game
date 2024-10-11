import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'find_temperature_game.dart';

class GameCard extends SpriteComponent with HasGameRef<FindTemperatureGame> {
  GameCard( {required super.position, required this.spriteDefault, required this.spriteFlip} );
  
  Sprite spriteDefault;
  Sprite spriteFlip;
  bool isFlipped = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(162);
    sprite = spriteDefault;

    return super.onLoad();
  }

  void flip(bool flipDefault){
    if( isFlipped != flipDefault ) return;
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          sprite = flipDefault ? spriteDefault : spriteFlip;
          isFlipped = !flipDefault;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                
              }
            )
          );
        }
      )
    );
  }
}