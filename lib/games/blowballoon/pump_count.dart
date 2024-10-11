import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'pump_button.dart';

class PumpCount extends ColorRectComponent {
  PumpCount({required super.position}) : 
    super(color: const Color.fromARGB(255, 30, 168, 186),
    size: Vector2(390, 73), anchor: Anchor.center);

  late PumpButton pumpButton;
  late TextComponent text;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    text = TextComponent(
      anchor: Anchor.center,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 42, color: Colors.white),
      ),
      position: Vector2(35, size.y * 0.5),
    );

    add(text);

    pumpButton = PumpButton(position: Vector2(size.x * 0.5 + 35, size.y * 0.5));
    add(pumpButton);

    return super.onLoad();
  }

  void setPumpCount(int count){
    text.text = count.toString();
  }
}
