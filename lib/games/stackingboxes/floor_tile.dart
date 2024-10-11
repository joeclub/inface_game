import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'floor.dart';


class FloorTile extends PolygonComponent with TapCallbacks  {
  FloorTile({ required super.position, required this.boxIndex, required this.parentFloor}) : super([
    Vector2(5, 18),
    Vector2(70, -1.5),
    Vector2(-5, -18),
    Vector2(-70, 2.5),
  ]);

  int boxIndex;
  Floor parentFloor;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
   
    return super.onLoad();
  }
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentFloor.addBox(boxIndex);
  }

  @override
  void render(Canvas canvas) {
    //super.render(canvas);
  }
}