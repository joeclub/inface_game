import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/educe_game.dart';

import 'color_rect_component.dart';
import 'game_desc.dart';

class StartButton extends ColorRectComponent with HasGameRef<EduceGame>, TapCallbacks, HasVisibility {
  StartButton({required super.position, required this.parentGameDesc})
    : super(
            color: const Color.fromARGB(255, 52, 186, 204),
            size: Vector2(160, 50),
            anchor: Anchor.center);

  GameDesc parentGameDesc;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    Sprite sprite = await gameRef.loadSprite('games/common/rightarrow.png');
    SpriteComponent arrow = SpriteComponent(
      anchor: Anchor.center,
      position: size * 0.5 + Vector2( 40, 0),
      size: Vector2(20, 18),
      sprite: sprite,
    );
    add(arrow);

    TextComponent buttonName = TextComponent(
      anchor: Anchor.centerLeft,
      text: '게임시작',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      position: size * 0.5 + Vector2( -55, 0),
    );
    add(buttonName);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentGameDesc.onClickStart();
  }
}
