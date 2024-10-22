import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/button_check_effect.dart';
import 'match_text_color_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<MatchTextColorGame>, TapCallbacks {
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
    gameRef.currScore += isCorrect ? 20 : -20;
    gameRef.currScore = math.max(0, gameRef.currScore);
    add(effect);
    gameRef.gameStep.updateScore(gameRef.currScore);
    gameRef.resetGame();
  }
}
