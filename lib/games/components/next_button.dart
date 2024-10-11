import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/educe_game.dart';

import 'color_rect_component.dart';
import 'input_ui.dart';

class NextButton extends ColorRectComponent with HasGameRef<EduceGame>, TapCallbacks, HasVisibility {
  NextButton({required super.position, required this.parentUI})
    : super(
            color: const Color.fromARGB(255, 52, 186, 204),
            size: Vector2(109, 35),
            anchor: Anchor.center);

  InputUI parentUI;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    Sprite sprite = await gameRef.loadSprite('games/common/rightarrow.png');
    SpriteComponent arrow = SpriteComponent(
      anchor: Anchor.center,
      position: size * 0.5 + Vector2( 30, 0),
      size: Vector2(15, 13),
      sprite: sprite,
    );
    add(arrow);

    TextComponent buttonName = TextComponent(
      anchor: Anchor.centerLeft,
      text: '게임시작',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
      position: size * 0.5 + Vector2( -40, 0),
    );
    add(buttonName);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentUI.onClickNext();
  }
}
