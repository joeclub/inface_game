import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'traffic_light_game.dart';

class TrafficLight extends SpriteComponent  with HasGameRef<TrafficLightGame> {
  TrafficLight({required super.position, required this.on, required this.isExample});

  int on;
  bool isExample;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    sprite = await gameRef.loadSprite('games/trafficlight/lbox_default.png');
    scale = isExample ? Vector2(0.55, 0.55) : Vector2(1, 1);
    size = Vector2(54, 108);

    Sprite spriteDefalut = await gameRef.loadSprite('games/trafficlight/light_def.png');
    List<Sprite> lstLights = [];
    Sprite spriteR = await gameRef.loadSprite('games/trafficlight/light_red.png');
    Sprite spriteG = await gameRef.loadSprite('games/trafficlight/light_green.png');
    Sprite spriteB = await gameRef.loadSprite('games/trafficlight/light_blue.png');
    Sprite spriteY = await gameRef.loadSprite('games/trafficlight/light_yellow.png');
    lstLights.add(spriteR);
    lstLights.add(spriteY);
    lstLights.add(spriteG);
    lstLights.add(spriteB);

    int on1 = on;
    int shift = 15;
    for( int i=3; i>=0; --i){
      SpriteComponent lightBackground = SpriteComponent(
        anchor: Anchor.center,
        position: size * 0.5 + Vector2( 0, -36 + i * 24),
        size: Vector2.all(18),
        sprite: spriteDefalut,
      );
      add(lightBackground);

      if( (on1 >> i) > 0 ) {
        SpriteComponent light = SpriteComponent(
          anchor: Anchor.center,
          position: lightBackground.size * 0.5,
          size: Vector2.all(18),
          sprite: lstLights[i],
        );
        lightBackground.add(light);
      }
      shift = shift >> 1;
      on1 = on1 & shift;
    }

    paint.filterQuality = FilterQuality.high;
    
    return super.onLoad();
  }
}