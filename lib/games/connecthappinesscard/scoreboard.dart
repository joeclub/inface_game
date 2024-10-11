import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';

class ScoreBoard extends ColorRectComponent {
  ScoreBoard({required super.position})
      : super(
            color: const Color.fromARGB(255, 226, 226, 226),
            size: Vector2(260, 325),
            anchor: Anchor.center);
  late TextComponent happinessScore;
  late TextComponent unhappinessScore;
  late TextComponent unhappinessCount;
  late TextComponent roundScore;

  @override
  Future<void> onLoad() async {
    ColorRectComponent background1 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x * 0.5, 41 ),
      size: Vector2(258, 80),
      anchor: Anchor.center
    );
    add(background1);

    ColorRectComponent background2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x * 0.5, 122 ),
      size: Vector2(258, 80),
      anchor: Anchor.center
    );
    add(background2);

    ColorRectComponent background3 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x * 0.5, 203 ),
      size: Vector2(258, 80),
      anchor: Anchor.center
    );
    add(background3);

    ColorRectComponent background4 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x * 0.5, 284 ),
      size: Vector2(258, 80),
      anchor: Anchor.center
    );
    add(background4);

    TextComponent title1 = TextComponent(
      anchor: Anchor.centerLeft,
      text: '행복카드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      position: background1.size * 0.5 - Vector2( 110, 0),
    );
    background1.add(title1);

    happinessScore = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, color: Colors.black),
      ),
      position: background1.size * 0.5 - Vector2( -110, 0),
    );
    background1.add(happinessScore);

    TextComponent title2 = TextComponent(
      anchor: Anchor.centerLeft,
      text: '불행카드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      position: background2.size * 0.5 - Vector2( 110, 0),
    );
    background2.add(title2);

    unhappinessScore = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, color: Colors.black),
      ),
      position: background2.size * 0.5 - Vector2( -110, 0),
    );
    background2.add(unhappinessScore);

    TextComponent title3 = TextComponent(
      anchor: Anchor.centerLeft,
      text: '불행카드 수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      position: background3.size * 0.5 - Vector2( 110, 0),
    );
    background3.add(title3);

    unhappinessCount = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: background3.size * 0.5 - Vector2( -110, 0),
    );
    background3.add(unhappinessCount);

    TextComponent title4 = TextComponent(
      anchor: Anchor.centerLeft,
      text: '라운드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      position: background4.size * 0.5 - Vector2( 110, 0),
    );
    background4.add(title4);

    roundScore = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, color: Color.fromARGB(255, 255, 59, 59)),
      ),
      position: background4.size * 0.5 - Vector2( -110, 0),
    );
    background4.add(roundScore);
  }
}