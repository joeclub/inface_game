import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'stacking_boxes_game.dart';

class ResetButton extends ColorRectComponent with HasGameRef<StackingBoxesGame>, TapCallbacks {
  ResetButton({required super.position}) : 
    super(color: const Color.fromARGB(255, 52, 186, 204),
    size: Vector2(120, 50), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: '초기화',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
      position: size * 0.5 - Vector2(10, 0),
    );

    add(text);

    Sprite sprite = await gameRef.loadSprite('games/stackingboxes/refresh.png');
    add(
      SpriteComponent(
        sprite: sprite,
        position: size * 0.5 + Vector2(30, 0),
        size: Vector2.all(25),
        anchor: Anchor.center,
      ),
    );

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if( gameRef.floor != null ) {
      gameRef.floor!.reset();
    }
  }
}