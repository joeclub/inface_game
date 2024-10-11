import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

class ResultText extends ColorRectComponent {
  late TextComponent text;
  ResultText({required super.position})
      : super(
            color: const Color.fromARGB(255, 52, 186, 204),
            size: Vector2(240, 50),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    text = TextComponent(
      anchor: Anchor.center,
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      position: size * 0.5,
    );

    add(text);

    return super.onLoad();
  }

  void setResult(bool result) {
    if (result) {
      text.text = '정답입니다!';
      setColor(const Color.fromARGB(255, 52, 186, 204));
    } else {
      text.text = '틀렸습니다!';
      setColor(const Color.fromARGB(255, 255, 0, 0));
    }
  }
}
