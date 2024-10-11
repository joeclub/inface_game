import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/educe_game.dart';

import 'color_rect_component.dart';
import 'game_desc.dart';

class PrevDescButton extends ColorRectComponent with HasGameRef<EduceGame>, TapCallbacks, HasVisibility {
  PrevDescButton({required super.position, required this.parentGameDesc})
    : super(
            color: const Color.fromARGB(255, 115, 117, 126),
            size: Vector2(118, 50),
            anchor: Anchor.center);

  GameDesc parentGameDesc;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    ColorRectComponent background = ColorRectComponent(
      color: Colors.white,
      position: size * 0.5,
      size: Vector2(116, 48),
      anchor: Anchor.center,
    );
    add(background);
    
    TextComponent buttonName = TextComponent(
      anchor: Anchor.center,
      text: '이전 설명',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: size * 0.5,
    );
    background.add(buttonName);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentGameDesc.currDesc--;
    parentGameDesc.createDesc(parentGameDesc.currDesc);
  }
}
