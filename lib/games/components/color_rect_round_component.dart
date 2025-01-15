import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ColorRectRoundComponent extends PositionComponent with HasVisibility {
  Color color;
  double radius;
  ColorRectRoundComponent(
      {required this.color,
      required this.radius,
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
    RRect rect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.x, size.y), Radius.circular(radius));
    final paint = Paint()..color = color
    ..style = PaintingStyle.fill;
    canvas.drawRRect(rect, paint);
  }

  void setColor(Color newColor) {
    color = newColor;
  }
}
