import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'check.dart';
import 'traffic_light_game.dart';

class Answer extends PositionComponent with HasGameRef<TrafficLightGame>, TapCallbacks{
  Answer({ required super.position, required this.number, required this.isSecondHalf });

  int number;
  late Check check;

  bool isSecondHalf;

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(50, 30);
    TextComponent text = TextComponent(
      anchor: Anchor.centerLeft,
      text: getNumberText(number),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: Vector2(0, 15),
    );
    add(text);
    if( number < 5 ){

      List<Sprite> lstLights = [];
      Sprite spriteR = await gameRef.loadSprite('games/trafficlight/light_red.png');
      Sprite spriteG = await gameRef.loadSprite('games/trafficlight/light_green.png');
      Sprite spriteB = await gameRef.loadSprite('games/trafficlight/light_blue.png');
      Sprite spriteY = await gameRef.loadSprite('games/trafficlight/light_yellow.png');
      lstLights.add(spriteR);
      lstLights.add(spriteY);
      lstLights.add(spriteG);
      lstLights.add(spriteB);

      if( isSecondHalf ) {
        SpriteComponent colorComponent = SpriteComponent(
          position: Vector2(50, 0),
          size: Vector2(40, 80),
          sprite: gameRef.lstContidions[number-1],
          anchor: Anchor.topCenter,
        );
        add(colorComponent);
      } else {
        SpriteComponent colorComponent = SpriteComponent(
          position: Vector2(25, 15),
          size: Vector2(25, 25),
          sprite: lstLights[number-1],
          anchor: Anchor.centerLeft,
        );
        add(colorComponent);
      }
      
    }

    check = Check(
      position: Vector2(8, 5),
    );
    add(check);
    check.isVisible = false;
  }

  String getNumberText(int number){
    switch(number){
      case 1: return '①';
      case 2: return '②';
      case 3: return '③';
      case 4: return '④';
      case 5: return '⑤ 모두 off';
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