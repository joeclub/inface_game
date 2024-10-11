import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'color_rect_component.dart';
import 'game_step.dart';
import 'next_button.dart';

class InputUI extends ColorRectComponent with HasGameRef {
  InputUI({required super.position, required this.isKeyboardControl, required this.parentGameStep})
      : super(
            color: const Color.fromARGB(255, 247, 247, 247),
            size: Vector2(892, 412),
            anchor: Anchor.center);

  bool isKeyboardControl;
  GameStep parentGameStep;

  @override
  FutureOr<void> onLoad() async {
    String spriteName = isKeyboardControl ? 'keyboard' : 'mouse';
    Sprite sprite = await gameRef.loadSprite('games/common/$spriteName.png');

    SpriteComponent controller = SpriteComponent(
      anchor: Anchor.center,
      position: size * 0.5 + Vector2( 0, 30),
      size: isKeyboardControl ? Vector2(531, 227) : Vector2(133, 173),
      sprite: sprite,
    );
    add(controller);

    NextButton nextButton = NextButton(
      position: size * 0.5 + Vector2(350, 160),
      parentUI: this,
    );

    TextComponent controllerText = TextComponent(
      anchor: Anchor.center,
      text: isKeyboardControl ? '키보드(방향키)' : '마우스로',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 21, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: size * 0.5 + (isKeyboardControl ? Vector2( -70, -140) : Vector2( -50, -140)),
    );
    add(controllerText);

    TextComponent controllerText1 = TextComponent(
      anchor: Anchor.centerLeft,
      text: isKeyboardControl ? '로만 응시합니다.' : '응시합니다.',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 21, color: Colors.black,),
      ),
      position: size * 0.5 +  (isKeyboardControl ? Vector2( 0, -140) :  Vector2( 0, -140)),
    );
    add(controllerText1);

    add(nextButton);

    return super.onLoad();
  }

  onClickNext(){
    parentGameStep.showGameDesc();
  }
}