import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'game_card.dart';
import 'game_card_array.dart';
import 'match_nth_card_game.dart';

class ArrayCard extends SpriteComponent with HasGameRef<MatchNthCardGame>{
  ArrayCard( {required super.position, required super.sprite, required this.cardIndex, required this.parentArray, required this.cardFront} ) :
    super(
      size: Vector2(150, 150),
      anchor: Anchor.center);
  int cardIndex;
  GameCardArray parentArray;

  Sprite? cardBack;
  Sprite cardFront;

  void flip(){
    cardBack = sprite;
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          if( parentArray.isEnd ) return;
          sprite = cardFront;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                if( parentArray.isEnd ) return;
                if(parentArray.currPhase == MatchNthCardPhase.game){
                  gameRef.showAnswerButton(true);
                }
                
                Future.delayed(const Duration(seconds: 3), (){
                  if( parentArray.isEnd ) return;
                  if(parentArray.currPhase == MatchNthCardPhase.game){
                    gameRef.showAnswerButton(false);
                    gameRef.correctBox.hide();
                  }
                  flip2();
                });
              }
            ),
          );
        }
      )
    );
  }

  void flip2(){
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          if( parentArray.isEnd ) return;
          sprite = cardBack;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                if( parentArray.isEnd ) return;
                if( parentArray.lstCardIndices.length == parentArray.nth){
                  parentArray.nextPhase();
                } else {
                  parentArray.nextCard();
                }
              }
            )
          );
        }
      )
    );
  }
}