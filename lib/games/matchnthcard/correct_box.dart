import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

class CorrectBox extends ColorRectComponent with HasVisibility {
  CorrectBox({required super.position}) :
    super(
      color: Colors.white,
      size: Vector2(240, 50),
      anchor: Anchor.center);
  late TextComponent correctText;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    color = Colors.white;
    size - Vector2(240, 50);

    correctText = TextComponent(
      anchor: Anchor.center,
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
      position: size * 0.5,
    );
    add(correctText);

    return super.onLoad();
  }

  void setCorrect(bool isCorrect){
    correctText.text = isCorrect ? '정답입니다!' : '틀렸습니다!';
    color = isCorrect ? const Color.fromARGB(255, 52, 186, 204) : Colors.red;
  }

  void hide(){
    color = Colors.white;
  }
}