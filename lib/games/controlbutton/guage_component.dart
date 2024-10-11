import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:inface/games/controlbutton/guage_button.dart';

import 'control_button_game.dart';

class GuageComponent extends ColorRectComponent with HasGameRef<ControlButtonGame> {
  GuageComponent({required super.position}) : 
    super(color: const Color.fromARGB(255, 112, 112, 112),
    size: Vector2(340, 32), anchor: Anchor.center);
 
  List<GuageButton> lstButtons = [];

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    

    for( int i=0; i<7; ++i){
      ColorRectComponent bar = ColorRectComponent(
        anchor: Anchor.center,
        color: const Color.fromARGB(255, 112, 112, 112),
        position: Vector2(1, -6) + Vector2(i * 56.2, 0),
        size: Vector2(2, 12),
      );
      add(bar);

      TextComponent text = TextComponent(
        anchor: Anchor.center,
        text: gameRef.lstValue[i].toString(),
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        position: Vector2(1, -20) + Vector2(i * 56.2, 0),
      );
      add(text);
    }

    ColorRectComponent background = ColorRectComponent(
      color: Colors.white,
      position: size * 0.5,
      size: Vector2(336, 28),
      anchor: Anchor.center,
    );

    add(background);

    for( int i=0; i<6; ++i){
      GuageButton button = GuageButton(
        position: Vector2(29.8, 16) + Vector2(i * 56.1, 0),
        isActive: gameRef.currIndex == i,
        index: i,
        parentComponent: this,
      );
      add(button);
      lstButtons.add(button);
    }

    return super.onLoad();
  }

  void onClickIndex( int index ){
    gameRef.currIndex = index;
    for( int i=0; i<lstButtons.length; ++i){
      lstButtons[i].active(gameRef.currIndex == i);
    }
  }
}
