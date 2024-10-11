import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'check.dart';
import 'compare_figure_game.dart';

class Answer extends PositionComponent with HasGameRef<CompareFigureGame>, TapCallbacks{
  Answer({ required super.position, required this.number});

  int number;
  late Check check;

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(50, 30);
    TextComponent text = TextComponent(
      anchor: Anchor.centerLeft,
      text: getNumberText(number),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2(0, 15),
    );
    add(text);

    check = Check(
      position: Vector2(8, 5),
    );
    add(check);
    check.isVisible = false;
  }

  String getNumberText(int number){
    switch(number){
      case 1: return '① A';
      case 2: return '② B';
      case 3: return '③ C';
      case 4: return '④ D';
    }
    return '';
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.check(number-1);
  }

  void onOff(bool isOn){
    check.isVisible = isOn;
  }
}