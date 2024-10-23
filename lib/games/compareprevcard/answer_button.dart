import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/button_check_effect.dart';
import 'compare_prev_card_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<ComparePrevCardGame>, TapCallbacks, HasVisibility {
  AnswerButton({required super.position, required this.isLeft});

  bool isLeft;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    String spriteName = isLeft ? 'left_key' : 'right_key';
    size = Vector2.all(45);
    sprite = await gameRef.loadSprite('games/common/$spriteName.png');
    return super.onLoad();
  }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   super.onTapUp(event);

  //   onClick();
  // }

  void onClick(){
    bool isMatched = gameRef.lstCardHistory[gameRef.lstCardHistory.length-1] == gameRef.lstCardHistory[gameRef.lstCardHistory.length-3];

    bool isCorrect = ( isMatched == isLeft );
    final effect = ButtonCheckEffect(
      position: size * 0.5,
      color: isCorrect ? Colors.green : Colors.red,
    );
    if( isCorrect ) {
      gameRef.currScore += 50;
    } else {
      gameRef.currScore -= 50;
    }
    gameRef.currScore = max(0, gameRef.currScore);
    gameRef.gameStep.updateScore(gameRef.currScore);
    add(effect);
    gameRef.prevCard.out();
    gameRef.resetGame2();
  }
}
