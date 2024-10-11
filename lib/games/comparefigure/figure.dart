import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'compare_figure_game.dart';

class Figure extends SpriteComponent with HasGameRef<CompareFigureGame> {
  Figure({required super.position, required this.figureIndex, required this.isCircle});
  
  int figureIndex;
  bool isCircle;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = figureIndex > 1 ? Vector2(35, 35) : Vector2(60, 60);
    sprite = isCircle ? gameRef.lstCircles[figureIndex] : gameRef.lstRects[figureIndex];

    TextComponent textB = TextComponent(
      anchor: Anchor.center,
      text: getFigureText(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
      position: size * 0.5 + Vector2(0, figureIndex > 1 ? 35 : 46),
    );
    add(textB);

    return super.onLoad();
  }
  
  String getFigureText(){
    switch(figureIndex){
      case 0: return isCircle ? 'AB' : 'A';
      case 1: return isCircle ? 'AC' : 'B';
      case 2: return isCircle ? 'AD' : 'C';
      case 3: return isCircle ? 'BC' : 'D';
    }
    return '';
  }
}