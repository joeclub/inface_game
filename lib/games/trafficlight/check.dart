import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'traffic_light_game.dart';

class Check extends PositionComponent with HasGameRef<TrafficLightGame>, HasVisibility{
  Check({ required super.position});

  late TextComponent checkText;

  @override
  FutureOr<void> onLoad() async {
    checkText = TextComponent(
      anchor: Anchor.center,
      text: 'V',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 122, 73, 244)),
      ),
      position: size * 0.5,
    );

    add(checkText);
  }
}