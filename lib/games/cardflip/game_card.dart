import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'card_flip_game.dart';

class GameCard extends SpriteComponent with HasGameRef<CardFlipGame>, TapCallbacks {
  GameCard( {required super.position, required this.cardIndex, required this.isHappiness} );
  
  late Sprite front1;
  late Sprite front2;
  late Sprite back;
  final int cardIndex;
  bool isHappiness;
  bool isFlipped = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(70, 108);
    front1 = await gameRef.loadSprite('games/cardflip/cardforground0.png');
    front2 = await gameRef.loadSprite('games/cardflip/cardforground1.png');
    back = await gameRef.loadSprite('games/cardflip/cardbackground.png');
    sprite = back;
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.scoreBoard!.setScore(isHappiness);
    flip();
  }

  void flip({bool force = false}){
    if( isFlipped == true ) return;

    if( gameRef.isTweening == true && force == false) return;
    gameRef.isTweening = true;

    isFlipped = true;
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          sprite = isHappiness ? front1 : front2;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                gameRef.isTweening = false;
                if( gameRef.isStageEnding == false && isHappiness == false ){
                  gameRef.nextGame();
                }
              }
            )
          );
        }
      )
    );
  }
}
