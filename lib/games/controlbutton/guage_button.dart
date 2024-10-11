import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'control_button_game.dart';
import 'guage_component.dart';

class GuageButton extends ColorRectComponent with HasGameRef<ControlButtonGame>, TapCallbacks {
  GuageButton({required super.position, required this.isActive, required this.index, required this.parentComponent}) : 
    super(color: const Color.fromARGB(255, 112, 112, 112),
    size: Vector2(57, 30), anchor: Anchor.center);

  bool isActive;
  int index;
  GuageComponent parentComponent;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    color = isActive ? const Color.fromARGB(255, 112, 112, 112) : Colors.white;
    return super.onLoad();
  }
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentComponent.onClickIndex(index);
  }

  void active(bool active){
    isActive = active;
    color = isActive ? const Color.fromARGB(255, 112, 112, 112) : Colors.white;
  }
}
