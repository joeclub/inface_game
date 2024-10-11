import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'match_weather_game.dart';

class GameCard extends SpriteComponent with HasGameRef<MatchWeatherGame>, TapCallbacks {
  GameCard( {required super.position, required this.cardIndex, required this.spriteName} );
  
  late Sprite front;
  late Sprite back;
  final int cardIndex;
  final String spriteName;
  bool isFront = false;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(200, 290);
    front = await gameRef.loadSprite('games/matchweather/$spriteName.png');
    back = await gameRef.loadSprite('games/matchweather/back.png');
    sprite = back;
    return super.onLoad();
  }

  void flip(bool isCardFront){
    if( isFront == isCardFront ) return;
    isFront = isCardFront;
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          sprite = isFront ? front : back;
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
