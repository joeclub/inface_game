import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import 'card_flip_game.dart';
import 'select_button.dart';

class ScoreBoard extends ColorRectComponent with HasGameRef<CardFlipGame>{
  int round = 0;
  int happinessScore = 0;
  int unhappinessScore = 0;
  int unhappinessCount = 0;
  int currScore = 0;
  late TextComponent rountText;
  late TextComponent happinessScoreText;
  late TextComponent unhappinessScoreText;
  late TextComponent unhappinessCountText;
  late TextComponent currScoreText;
  ScoreBoard({required super.position})
      : super(
            color: const Color.fromARGB(255, 247, 247, 247),
            size: Vector2(298, 536),
            anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    rountText = TextComponent(
      anchor: Anchor.center,
      text: 'ROUND $round',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 60),
    );
    add(rountText);

    ColorRectComponent scoreBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 269.5),
      size: Vector2(260, 293),
      anchor: Anchor.center
    );
    add(scoreBackground);

    ColorRectComponent happinessBackground = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 160),
      size: Vector2(258, 72),
      anchor: Anchor.center
    );
    add(happinessBackground);

    ColorRectComponent unhappinessBackground = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 233),
      size: Vector2(258, 72),
      anchor: Anchor.center
    );
    add(unhappinessBackground);

    ColorRectComponent unhappinessBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 306),
      size: Vector2(258, 72),
      anchor: Anchor.center
    );
    add(unhappinessBackground2);

    ColorRectComponent currScoreBackground = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 379),
      size: Vector2(258, 72),
      anchor: Anchor.center
    );
    add(currScoreBackground);

    ColorRectComponent selectBtnBackground1 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 488),
      size: Vector2( size.x, 100 ),
      anchor: Anchor.center
    );
    add(selectBtnBackground1);

    ColorRectComponent selectBtnBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2( size.x* 0.5 + 1, 0 ) + Vector2(0, 488),
      size: Vector2( size.x - 2, 98 ),
      anchor: Anchor.center
    );
    add(selectBtnBackground2);

    SelectButton selectButton = SelectButton(
      position: Vector2( size.x* 0.5, 0 ) + Vector2(0, 488),
    );
    add(selectButton);

    TextComponent happinessText = TextComponent(
      anchor: Anchor.centerLeft,
      text: '행복카드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(35, 160),
    );
    add(happinessText);

    TextComponent unhappinessText = TextComponent(
      anchor: Anchor.centerLeft,
      text: '불행카드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(35, 233),
    );
    add(unhappinessText);

    TextComponent unhappinessCountTitleText = TextComponent(
      anchor: Anchor.centerLeft,
      text: '불행카드 수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(35, 306),
    );
    add(unhappinessCountTitleText);

    TextComponent currScoreTitleText = TextComponent(
      anchor: Anchor.centerLeft,
      text: '라운드 점수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(35, 379),
    );
    add(currScoreTitleText);

    happinessScoreText = TextComponent(
      anchor: Anchor.centerRight,
      text: '+$happinessScore',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(260, 160),
    );
    add(happinessScoreText);

    unhappinessScoreText = TextComponent(
      anchor: Anchor.centerRight,
      text: '$unhappinessScore',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(260, 233),
    );
    add(unhappinessScoreText);

    unhappinessCountText = TextComponent(
      anchor: Anchor.centerRight,
      text: '$unhappinessCount',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(260, 306),
    );
    add(unhappinessCountText);

    currScoreText = TextComponent(
      anchor: Anchor.centerRight,
      text: '$currScore',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 255, 59, 59)),
      ),
      position: Vector2(260, 379),
    );
    add(currScoreText);
  }

  void updateRound(int round, int happinessScore, int unhappinessScore, int unhappinessCount){
    this.round = round;
    this.happinessScore = happinessScore;
    this.unhappinessScore = unhappinessScore;
    this.unhappinessCount = unhappinessCount;
    gameRef.currRound = round;

    rountText.text = 'ROUND $round';
    happinessScoreText.text = '+$happinessScore';
    unhappinessScoreText.text = unhappinessScore.toString();
    unhappinessCountText.text = unhappinessCount.toString();
  }

  void setScore(bool correct){
    if( correct ){
      currScore += happinessScore;
    } else {
      currScore += unhappinessScore;
    }
    gameRef.currScore = currScore;
    currScoreText.text = currScore.toString();
    gameRef.gameStep.updateScore(currScore);
  }
}