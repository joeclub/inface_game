import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'blow_balloon_game.dart';

class AccumulateButton extends ColorRectComponent with HasGameRef<BlowBalloonGame>, TapCallbacks {
  AccumulateButton({required super.position}) : 
    super(color: const Color.fromARGB(255, 51, 60, 100),
    size: Vector2(338, 70), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: '적립하기',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 34, color: Colors.white),
      ),
      position: size * 0.5,
    );

    add(text);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.accmulate();
  }
}
