import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'color_rect_component.dart';
import 'end_game_button.dart';


class EndGamePopup extends ColorRectComponent with HasGameRef, TapCallbacks, DragCallbacks {
  EndGamePopup({required super.position, required this.point})
  : super(
    color: const Color.fromARGB(128, 0, 0, 0),
    size: Vector2(1280, 720),
    anchor: Anchor.center);

  int point;
  double timeLimit = 10;
  
  late ColorRectComponent background;
  late TextComponent timeLeft;
  late EndGameButton endgameButton;
  
  @override
  FutureOr<void> onLoad() async {
    background = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: size * 0.5,
      size: Vector2(500, 500),
    );
    add(background);

    TextComponent text1 = TextComponent(
      anchor: Anchor.center,
      text: '게임이 종료되었습니다.',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      position: Vector2(background.size.x * 0.5, 60),
    );
    background.add(text1);

    TextComponent text2 = TextComponent(
      anchor: Anchor.center,
      text: '10초 뒤에 자동으로 게임이 종료됩니다.',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(background.size.x * 0.5, 110),
    );
    background.add(text2);

    TextComponent textPoint = TextComponent(
      anchor: Anchor.center,
      text: point.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 50, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(background.size.x * 0.5, 210),
    );
    background.add(textPoint);

    TextComponent textPoint2 = TextComponent(
      anchor: Anchor.center,
      text: 'POINT',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(background.size.x * 0.5, 255),
    );
    background.add(textPoint2);

    timeLeft = TextComponent(
      anchor: Anchor.center,
      text: timeLimit.toInt().toString().padLeft(2, '0'),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(background.size.x * 0.5, 285),
    );
    background.add(timeLeft);

    ColorRectComponent background2 = ColorRectComponent(
      anchor: Anchor.bottomCenter,
      color: const Color.fromARGB(255, 247, 247, 247),
      position: Vector2(background.size.x * 0.5, background.size.y),
      size: Vector2(500, 170),
    );
    background.add(background2);

    TextComponent text3 = TextComponent(
      anchor: Anchor.center,
      text: '게임을 바로 종료하시려면',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(background2.size.x * 0.5, 40),
    );
    background2.add(text3);

    TextComponent text4 = TextComponent(
      anchor: Anchor.center,
      text: '아래의 "게임 종료" 버튼을 누르시기 바랍니다.',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(background2.size.x * 0.5, 65),
    );
    background2.add(text4);

    endgameButton = EndGameButton(
      position: Vector2(background2.size.x * 0.5, 120),
    );
    background2.add(endgameButton);
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeLimit -= dt;
    timeLimit = max(0, timeLimit);
    timeLeft.text = timeLimit.toInt().toString().padLeft(2, '0');
  }
}