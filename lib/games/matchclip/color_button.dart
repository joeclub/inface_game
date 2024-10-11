import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'color_button_check.dart';
import 'match_clip_game.dart';

class ColorButton extends PositionComponent with HasGameRef<MatchClipGame>, TapCallbacks {
  ColorButton( {required super.position, required this.colorIndex} );

  int colorIndex;

  late ColorButtonCheck check;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(90, 90);

    ClipComponent clip1 = ClipComponent.circle(
      anchor: Anchor.center,
      position: size * 0.5,
      size: Vector2(90, 90),
    );
    add(clip1);
    ColorRectComponent rect1 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: clip1.size * 0.5,
      size: Vector2(90, 90),
      anchor: Anchor.center
    );
    clip1.add(rect1); 

    ClipComponent clip2 = ClipComponent.circle(
      anchor: Anchor.center,
      position: size * 0.5,
      size: Vector2(88, 88),
    );
    add(clip2);
    ColorRectComponent rect2 = ColorRectComponent(
      color: Colors.white,
      position: clip2.size * 0.5,
      size: Vector2(88, 88),
      anchor: Anchor.center
    );
    clip2.add(rect2); 

    Color buttonColor = Colors.white;
    switch(colorIndex){
      case 0:{
        buttonColor = const Color.fromARGB(255, 212, 64, 38);
      }
      break;
      case 1:{
        buttonColor = const Color.fromARGB(255, 59, 186, 36);
      }
      break;
      case 2:{
        buttonColor = const Color.fromARGB(255, 68, 102, 199);
      }
      break;
    }

    ClipComponent clip3 = ClipComponent.circle(
      anchor: Anchor.center,
      position: size * 0.5,
      size: Vector2(45, 45),
    );
    add(clip3);
    ColorRectComponent rect3 = ColorRectComponent(
      color: buttonColor,
      position: clip3.size * 0.5,
      size: Vector2(45, 45),
      anchor: Anchor.center
    );
    clip3.add(rect3); 

    check = ColorButtonCheck(
      position: size * 0.5,
    );
    add(check);
    check.isVisible = false;
    
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    gameRef.onClickColorButton(colorIndex);
  }

  void checkVisible(bool visible){
    check.isVisible = visible;
  }
}