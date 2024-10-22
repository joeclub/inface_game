import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'stacking_boxes_game.dart';

class ConfirmButton extends ColorRectComponent with HasGameRef<StackingBoxesGame>, TapCallbacks {
  ConfirmButton({required super.position}) : 
    super(color: const Color.fromARGB(255, 51, 60, 100),
    size: Vector2(120, 50), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: '완료',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
      position: size * 0.5,
    );

    add(text);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( gameRef.floor == null || gameRef.questionView == null ) return;

    bool correct = true;

    for( int i=0; i<gameRef.floor!.lstBoxes.length; ++i ){
      if( gameRef.floor!.lstBoxes[i] != gameRef.questionView!.lstBoxes[i] ){
        correct = false;
        break;
      }
    }

    if( correct ){
      int score = gameRef.isSecondHalfQuestion ? 100 : 80;// 3500 + (gameRef.questionView!.boxCount-5) * 500;
      gameRef.addScore(score);
      gameRef.resetGame();
    }
  }
}