import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'control_button_game.dart';

class SwitchComponent extends ColorRectComponent with HasGameRef<ControlButtonGame> {
  SwitchComponent({required super.position, required this.switchNumber, required this.isOn}) : 
    super(color: Colors.white,
    size: Vector2(52, 120), anchor: Anchor.center);

  int switchNumber;
  bool isOn;

  late ColorRectComponent button;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: switchNumber.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: size * 0.5 + Vector2(0, 75),
    );

    add(text);

    button = ColorRectComponent(
      color: const Color.fromARGB(255, 138, 138, 138),
      position: size * 0.5 + Vector2(0, isOn ? -46 : 46),
      size: Vector2(48, 24),
      anchor: Anchor.center,
    );

    add(button);

    return super.onLoad();
  }
}
