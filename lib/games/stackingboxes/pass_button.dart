import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'stacking_boxes_game.dart';

class PassButton extends ColorRectComponent with HasGameRef<StackingBoxesGame>, TapCallbacks {
  PassButton({required super.position}) : 
    super(color: const Color.fromARGB(255, 51, 60, 100),
    size: Vector2(170, 50), anchor: Anchor.center);

  int passCount = 2;
  late TextComponent text;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    ColorRectComponent background = ColorRectComponent(
      color: Colors.white,
      position: size * 0.5,
      size: Vector2(166, 46),
      anchor: Anchor.center,
    );
    add(background);

    text = TextComponent(
      anchor: Anchor.center,
      text: '넘어가기($passCount회 가능)',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: size * 0.5,
    );

    add(text);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if( passCount == 0 ) return;
    passCount--;
    text.text = '넘어가기($passCount회 가능)';
    gameRef.resetGame();
  }

  void reset(){
    passCount = 2;
  }
}