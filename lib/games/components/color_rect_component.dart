import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ColorRectComponent extends PositionComponent {
  Color color;
  ColorRectComponent(
      {required this.color,
      required super.position,
      required super.size,
      required super.anchor});

  @override
  FutureOr<void> onLoad() async {
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final paint = Paint()..color = color;
    canvas.drawRect(rect, paint);
  }

  void setColor(Color newColor) {
    color = newColor;
  }
}
