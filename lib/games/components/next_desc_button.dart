import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/educe_game.dart';

import 'color_rect_component.dart';
import 'game_desc.dart';

class NextDescButton extends ColorRectComponent with HasGameRef<EduceGame>, TapCallbacks, HasVisibility {
  NextDescButton({required super.position, required this.parentGameDesc, required this.numDesc, required this.currDesc})
    : super(
            color: const Color.fromARGB(255, 51, 60, 100),
            size: Vector2(160, 50),
            anchor: Anchor.center);

  GameDesc parentGameDesc;
  int numDesc;
  int currDesc;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    
    TextComponent buttonName = TextComponent(
      anchor: Anchor.center,
      text: '다음 설명 ($currDesc/$numDesc)',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      position: size * 0.5,
    );
    add(buttonName);
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    parentGameDesc.currDesc++;
    parentGameDesc.createDesc(parentGameDesc.currDesc);
  }
}
