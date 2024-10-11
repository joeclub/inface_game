import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class ShapePattern extends SpriteComponent {
  ShapePattern({required super.position, required super.sprite, required this.color});

  Color color;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(40, 40);
    CustomCurve curve = CustomCurve();
    ColorEffect colorEffect = ColorEffect(color, EffectController(duration: 0.1, curve: curve, infinite: true));
    add(
      colorEffect
    );

    return super.onLoad();
  }
}

class CustomCurve extends Curve{
  @override
  double transformInternal(double t){return 1;}
}