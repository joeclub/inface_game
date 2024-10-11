import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'compare_pattern_game.dart';
import 'shape_pattern.dart';

enum PatternType{
  circle,
  hexagon,
  rectangle,
  triangle,
}

enum PatternColor{
  red,
  green,
  blue,
  yellow,
}

class Emitter extends PositionComponent with HasGameRef<ComparePatternGame>, HasPaint {
  Emitter({required super.position, required this.lstPatterns});
  List<ShapePattern> lstSprites = [];

  List<Sprite> lstPatterns;
  double rotateSpeed = 1;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += dt * rotateSpeed;
  }
  
  void emit(PatternType patternType, PatternColor patternColor, int count){
    for( int i=0; i<lstSprites.length; ++i ){
      remove(lstSprites[i]);
    }
    lstSprites.clear();

    // ignore: constant_identifier_names
    const double PI = 3.141592;
    int count2 = count == 5 ? 4 : count;
    double rotation = 0;
    double unitRotation = PI * 2 / count2;
    for( int i=0; i<count2; ++i){
      Vector2 pos = Vector2(100, 0);
      Matrix3 m = Matrix3.rotationZ(rotation);
      m.transform2(pos);
      ShapePattern shapePattern = ShapePattern(
        sprite: lstPatterns[patternType.index],
        position: pos,
        color: getColor(patternColor),
      );

      //spriteComponent.paint.color = 
      add(shapePattern);
      lstSprites.add(shapePattern);
      
      rotation += unitRotation;
    }

    if( count == 5 ){
      ShapePattern shapePattern = ShapePattern(
        sprite: lstPatterns[patternType.index],
        position: Vector2.zero(),
        color: getColor(patternColor),
      );
      add(shapePattern);
      lstSprites.add(shapePattern);
    }

    rotateSpeed = Random().nextInt(2) == 0 ? 0.2 : -0.2;
  }

  Color getColor(PatternColor color ){
    switch(color){
      case PatternColor.red: return Colors.red;
      case PatternColor.green: return Colors.green;
      case PatternColor.blue: return Colors.blue;
      case PatternColor.yellow: return Colors.yellow;
    }
  }
}