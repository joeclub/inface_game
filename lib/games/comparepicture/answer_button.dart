import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/button_check_effect.dart';
import 'compare_picture_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<ComparePictureGame>, TapCallbacks, HasVisibility {
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
    bool isCorrect = ( gameRef.isMatched == isLeft );
    final effect = ButtonCheckEffect(
      position: size * 0.5,
      color: isCorrect ? Colors.green : Colors.red,
    );
    if( isCorrect ) {
      gameRef.currScore += 40;
    } else {
      gameRef.currScore -= 40;
    }
    gameRef.currScore = max(0, gameRef.currScore);
    gameRef.gameStep.updateScore(gameRef.currScore);
    add(effect);
    gameRef.resetGame();
  }
}
