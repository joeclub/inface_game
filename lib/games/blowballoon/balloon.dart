import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Balloon extends SpriteComponent with HasGameRef {
  Balloon({required super.position, required this.balloonIndex});
  final int balloonIndex;
  int currBlow = 0;
  late Vector2 startSize;
  final pumpLimit = 64;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    size = Vector2(34, 44);
    sprite = await gameRef.loadSprite('games/blowballoon/balloon${balloonIndex+1}.png');
    paint.filterQuality = FilterQuality.high;

    return super.onLoad();
  }

  void blow(){
    currBlow++;

    double width = lerp(34, 300, currBlow / pumpLimit);
    double height = lerp(44, 373, currBlow / pumpLimit);
    add(
      SizeEffect.to(
        Vector2(width, height),
        EffectController(duration: 0.15)
      )
    );
  }

  double lerp(int a, int b, double t){
    return a + (b-a)*t;
  }
}
