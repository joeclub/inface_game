import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import 'accumulate_button.dart';

class ScoreBoard extends ColorRectComponent {
  ScoreBoard({required super.position})
      : super(
            color: const Color.fromARGB(255, 226, 226, 226),
            size: Vector2(378, 544),
            anchor: Anchor.center);
  late TextComponent remainBalloonText;
  late TextComponent expectedProfitText;
  late TextComponent accumulatedProfitText;

  late AccumulateButton accumulateButton;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 247, 247, 247),
      position: size * 0.5,
      size: Vector2(376, 542),
      anchor: Anchor.center
    );
    add(background);

    TextComponent title = TextComponent(
      anchor: Anchor.center,
      text: '결과판',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: Vector2( size.x* 0.5, 50 ),
    );
    add(title);

    ColorRectComponent scoreBackground1 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2( size.x* 0.5, 260 ),
      size: Vector2(338, 328),
      anchor: Anchor.center
    );
    add(scoreBackground1);

    ColorRectComponent scoreBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 151 ),
      size: Vector2(336, 108),
      anchor: Anchor.center
    );
    add(scoreBackground2);

    TextComponent remainBalloonTitle = TextComponent(
      anchor: Anchor.centerLeft,
      text: '남은 풍선',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2( 40, 151 ),
    );
    add(remainBalloonTitle);

    remainBalloonText = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(320, 151),
    );
    add(remainBalloonText);

    ColorRectComponent scoreBackground3 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 260 ),
      size: Vector2(336, 108),
      anchor: Anchor.center
    );
    add(scoreBackground3);

    TextComponent expectedProfitTitle = TextComponent(
      anchor: Anchor.centerLeft,
      text: '기대 이익',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2( 40, 260 ),
    );
    add(expectedProfitTitle);

    expectedProfitText = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(320, 260),
    );
    add(expectedProfitText);

    ColorRectComponent scoreBackground4 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 369 ),
      size: Vector2(336, 108),
      anchor: Anchor.center
    );
    add(scoreBackground4);

    TextComponent accumulatedProfitTitle = TextComponent(
      anchor: Anchor.centerLeft,
      text: '누적 이익',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2( 40, 369 ),
    );
    add(accumulatedProfitTitle);

    accumulatedProfitText = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 255, 59, 59)),
      ),
      position: Vector2(320, 369),
    );
    add(accumulatedProfitText);

    ColorRectComponent scoreBackground5 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2( size.x* 0.5, 489 ),
      size: Vector2(378, 110),
      anchor: Anchor.center
    );
    add(scoreBackground5);

    ColorRectComponent scoreBackground6 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 489 ),
      size: Vector2(376, 108),
      anchor: Anchor.center
    );
    add(scoreBackground6);

    accumulateButton = AccumulateButton(
      position: Vector2( size.x* 0.5, 489 ),
    );
    add(accumulateButton);
  }

  void updateScore(int remainBalloon, int expectedProfit, int accumulatedProfit){
    remainBalloonText.text = remainBalloon.toString();
    expectedProfitText.text = expectedProfit.toString();
    accumulatedProfitText.text = accumulatedProfit.toString();
  }
}