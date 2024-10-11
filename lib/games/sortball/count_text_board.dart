import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

class CountTextBoard extends ColorRectComponent {
  late TextComponent minText;
  late TextComponent currText;
  CountTextBoard({required super.position})
      : super(
            color: const Color.fromARGB(255, 226, 226, 226),
            size: Vector2(240, 120),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    ColorRectComponent leftBackground = ColorRectComponent(
        color: Colors.white,
        position: size * 0.5 - Vector2(60, 0),
        size: Vector2.all(118),
        anchor: Anchor.center);
    add(leftBackground);

    ColorRectComponent rightBackground = ColorRectComponent(
        color: Colors.white,
        position: size * 0.5 + Vector2(60, 0),
        size: Vector2.all(118),
        anchor: Anchor.center);
    add(rightBackground);

    TextComponent leftTextTitle = TextComponent(
      anchor: Anchor.center,
      text: '최소 사용 횟수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: size * 0.5 + Vector2(-60, -35),
    );

    add(leftTextTitle);

    TextComponent rightTextTitle = TextComponent(
      anchor: Anchor.center,
      text: '현재 사용 횟수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: size * 0.5 + Vector2(60, -35),
    );

    add(rightTextTitle);

    minText = TextComponent(
      anchor: Anchor.center,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 60, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: size * 0.5 + Vector2(-60, 15),
    );

    add(minText);

    currText = TextComponent(
      anchor: Anchor.center,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 60, color: Color.fromARGB(255, 255, 59, 59)),
      ),
      position: size * 0.5 + Vector2(60, 15),
    );

    add(currText);

    return super.onLoad();
  }
}
