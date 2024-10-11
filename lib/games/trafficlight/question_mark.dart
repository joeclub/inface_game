import 'dart:async';

import 'package:flame/components.dart';

import 'package:inface/games/components/color_rect_component.dart';
import 'package:flutter/material.dart';

import 'traffic_light_game.dart';


class QuestionMark extends ColorRectComponent with HasGameRef<TrafficLightGame> {
  QuestionMark({required super.position}) : 
    super(color: const Color.fromARGB(255, 180, 180, 188),
    size: Vector2(54, 108), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    TextComponent text = TextComponent(
      anchor: Anchor.center,
      text: '?',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 60, color: Colors.white),
      ),
      position: size * 0.5,
    );

    add(text);

    return super.onLoad();
  }
}