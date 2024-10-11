import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import 'stacking_boxes_game.dart';

class QuestionView extends PositionComponent with HasGameRef<StackingBoxesGame> {
  List<int> lstBoxes = List.filled(16, 0);
  bool isSecondHalf;
  int boxCount = 0;
  QuestionView({super.position, required this.isSecondHalf});
  @override
  FutureOr<void> onLoad() async {
    Sprite topBackgroundSprite = await gameRef.loadSprite('games/stackingboxes/floor2d.png');
    add(
      SpriteComponent(
        sprite: topBackgroundSprite,
        position: Vector2(0, -135),
        size: Vector2.all(200),
        anchor: Anchor.center,
      ),
    );

    ColorRectComponent frontBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 115, 117, 126),
      position: Vector2(-110, 220),
      size: Vector2( 180, 2),
      anchor: Anchor.center,
    );
    add( frontBackground );

    ColorRectComponent rightBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 115, 117, 126),
      position: Vector2(110, 220),
      size: Vector2( 180, 2),
      anchor: Anchor.center,
    );
    add( rightBackground );

    setQuestion();

    Sprite boxSprite = await gameRef.loadSprite('games/stackingboxes/box2d.png');

    double boxSize = 50;

    Vector2 startPos = Vector2(-50, -35) + Vector2(-25, -25);

    for( int i=0; i<lstBoxes.length; ++i){
      if( lstBoxes[i] == 0 ) continue;
      double x = i % 4;
      double y = -(i ~/ 4).toDouble();
      add(
        SpriteComponent(
          sprite: boxSprite,
          anchor: Anchor.center,
          position: Vector2(x, y) * boxSize + startPos,
          size: Vector2.all(boxSize),
        ),
      );
    }

    boxSize = 40;
    startPos = Vector2(-190, 195) + Vector2(20, 5);

    for( int i=0; i<4; ++i){
      int floors = 0;

      floors = math.max(floors, lstBoxes[i+0]);
      floors = math.max(floors, lstBoxes[i+4]);
      floors = math.max(floors, lstBoxes[i+8]);
      floors = math.max(floors, lstBoxes[i+12]);
      if( floors == 0 ) continue;
      double x = i.toDouble();
      for( int j=0; j<floors; ++j){
        add(
          SpriteComponent(
            sprite: boxSprite,
            anchor: Anchor.center,
            position: Vector2(x, -j.toDouble()) * boxSize + startPos,
            size: Vector2.all(boxSize),
          ),
        );
      }
    }

    startPos = Vector2(30, 195) + Vector2(20, 5);

    for( int i=0; i<4; ++i){
      int floors = 0;

      floors = math.max(floors, lstBoxes[0+i*4]);
      floors = math.max(floors, lstBoxes[1+i*4]);
      floors = math.max(floors, lstBoxes[2+i*4]);
      floors = math.max(floors, lstBoxes[3+i*4]);
      if( floors == 0 ) continue;
      double x = i.toDouble();
      for( int j=0; j<floors; ++j){
        add(
          SpriteComponent(
            sprite: boxSprite,
            anchor: Anchor.center,
            position: Vector2(x, -j.toDouble()) * boxSize + startPos,
            size: Vector2.all(boxSize),
          ),
        );
      }
    }

    return super.onLoad();
  }

  void setQuestion(){
    const int maxFloor = 4;
    boxCount = math.Random().nextInt(3) + (isSecondHalf ? 8 : 5);
    for( int i=0; i<boxCount; ++i){
      int boxIndex = math.Random().nextInt(16);
      while(true){
        if( lstBoxes[boxIndex] >= maxFloor ) continue;
        lstBoxes[boxIndex]++;
        break;
      }
    }
  }
}