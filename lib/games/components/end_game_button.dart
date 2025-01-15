import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/educe_game.dart';

import 'color_rect_component.dart';
import '../../game_manager.dart';

class EndGameButton extends ColorRectComponent with HasGameRef<EduceGame>, TapCallbacks {
  EndGameButton({required super.position})
    : super(
            color: const Color.fromARGB(255, 52, 186, 204),
            size: Vector2(154, 40),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    Sprite sprite = await gameRef.loadSprite('games/common/rightarrow.png');
    SpriteComponent arrow = SpriteComponent(
      anchor: Anchor.center,
      position: size * 0.5 + Vector2( 45, 0),
      size: Vector2(15, 13),
      sprite: sprite,
    );
    add(arrow);

    TextComponent buttonName = TextComponent(
      anchor: Anchor.centerLeft,
      text: '게임종료',
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
    GameManager().playNextGame(gameRef.context!);
  }
}
