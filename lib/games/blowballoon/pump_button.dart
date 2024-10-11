import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'blow_balloon_game.dart';

class PumpButton extends ColorRectComponent with HasGameRef<BlowBalloonGame>, TapCallbacks {
  PumpButton({required super.position}) : 
    super(color: const Color.fromARGB(255, 52, 186, 204),
    size: Vector2(320, 70), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: 'PUMP',
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
    gameRef.blow();
  }
}
