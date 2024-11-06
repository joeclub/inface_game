import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'compare_prev_card_game.dart';

class GameCard extends SpriteComponent with HasGameRef<ComparePrevCardGame> {
  GameCard( {required super.position, required this.cardIndex, required super.sprite} );
  
  final int cardIndex;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(360, 360);
    scale = Vector2.zero();

    const double unitAngle = 3.141592 * 2 / 6;

    angle = cardIndex * unitAngle;
    init();
    paint.filterQuality = FilterQuality.high;
    return super.onLoad();
  }

  void init(){
    add(
      ScaleEffect.to(
        Vector2(1, 1),
        EffectController(duration: 0.2),
      )
    );
  }

  void out(){
    add(
      ScaleEffect.to(
        Vector2(4, 4),
        EffectController(duration: 0.2),
      )
    );

    add(
      OpacityEffect.to(
        0,
        EffectController(duration: 0.2),
      )
    );
  }

  // void flip({bool force = false}){
  //   if( isFlipped == true ) return;

  //   if( gameRef.isTweening == true && force == false) return;
  //   gameRef.isTweening = true;

  //   isFlipped = true;
  //   add(
  //     ScaleEffect.to(
  //       Vector2(0, 1),
  //       EffectController(duration: 0.2),
  //       onComplete: (){
  //         sprite = isHappiness ? front1 : front2;
  //         add(
  //           ScaleEffect.to(
  //             Vector2(1, 1),
  //             EffectController(duration: 0.2),
  //             onComplete: (){
  //               gameRef.isTweening = false;
  //               if( gameRef.isStageEnding == false && isHappiness == false ){
  //                 gameRef.nextGame();
  //               }
  //             }
  //           )
  //         );
  //       }
  //     )
  //   );
  // }
}
