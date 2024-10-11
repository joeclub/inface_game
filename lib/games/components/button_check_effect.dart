import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'color_rect_component.dart';

class ButtonCheckEffect extends ColorRectComponent with HasGameRef{
  ButtonCheckEffect({required super.position, required super.color})
      : super(
            size: Vector2(40, 40),
            anchor: Anchor.center);

  final double duration = 0.5;
  double currTime = 0;

  @override
  void update(double dt) {
    super.update(dt);

    currTime += dt;
    if( currTime > duration ){
      parent!.remove(this);
      return;
    }
    Color thisColor = color;
    double t = 1 - (currTime / duration);
    int alpha = (t * 255).toInt();
    thisColor = thisColor.withAlpha(alpha);
    setColor(thisColor);
  }
}