import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'match_clip_game.dart';

class SubmitButton extends ColorRectComponent with HasGameRef<MatchClipGame>, TapCallbacks {
  SubmitButton({required super.position})
    : super(
            color: const Color.fromARGB(255, 133, 58, 253),
            size: Vector2(150, 50),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent buttonName = TextComponent(
      anchor: Anchor.center,
      text: '정답 제출',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 19, color: Colors.white),
      ),
      position: size * 0.5,
    );
    add(buttonName);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.submit();
  }
}
