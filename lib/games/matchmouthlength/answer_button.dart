import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/button_check_effect.dart';
import 'match_mouth_length_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<MatchMouthLengthGame>, TapCallbacks, HasVisibility {
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
    if( gameRef.isButtonTapped){
      return;
    }
    gameRef.isButtonTapped = true;
    bool isCorrect = ( gameRef.isMatched == isLeft );
    final effect = ButtonCheckEffect(
      position: size * 0.5,
      color: isCorrect ? Colors.green : Colors.red,
    );
    gameRef.currScore += isCorrect ? gameRef.matchScore : -gameRef.matchScore;
    gameRef.currScore = math.max(0, gameRef.currScore);
    gameRef.gameStep.updateScore(gameRef.currScore);
    add(effect);
    Future.delayed(const Duration(milliseconds: 500), (){
      gameRef.isButtonTapped = false;
      gameRef.resetGame();
    });
  }
}
