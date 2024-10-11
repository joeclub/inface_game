import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:inface/games/stackingboxes/question_view.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'confirm_button.dart';
import 'floor.dart';
import 'pass_button.dart';
import 'reset_button.dart';


class StackingBoxesGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  Floor? floor;
  QuestionView? questionView;

  late TextComponent scoreText;
  late Sprite arrowSprite;

  StackingBoxesGame({required super.context});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 9, gameName: '상자 쌓기', timeLimit: limitTime, context: context, gameDescIndex: 8);
    world.add(gameStep);

    arrowSprite = await loadSprite('games/stackingboxes/arrow_black.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameStep.limitTimer.current > gameStep.halfTime) {
      isSecondHalf = true;
    }
    if (gameStep.limitTimer.finished) {
      endGame();
    }
  }

  void endGame() {
  }

  @override
  void initGame(){
    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(640, 420),
      size: Vector2(1021, 550),
      anchor: Anchor.center,
    );
    world.add(background);

    ColorRectComponent rightBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 234, 236, 245),
      position: Vector2(866, 420),
      size: Vector2(567, 546),
      anchor: Anchor.center,
    );
    world.add(rightBackground);

    ColorRectComponent leftTopBackground = ColorRectComponent(
      color: Colors.white,
      position: Vector2(356, 284),
      size: Vector2(449, 273),
      anchor: Anchor.center,
    );
    world.add(leftTopBackground);

    ColorRectComponent leftBottomBackground1 = ColorRectComponent(
      color: Colors.white,
      position: Vector2(243, 558),
      size: Vector2(223, 272),
      anchor: Anchor.center,
    );
    world.add(leftBottomBackground1);

    ColorRectComponent leftBottomBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2(469, 558),
      size: Vector2(223, 272),
      anchor: Anchor.center,
    );
    world.add(leftBottomBackground2);

    TextComponent topText = TextComponent(
      anchor: Anchor.center,
      text: '평면도',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(170, 170),
    );
    world.add(topText);

    TextComponent bottomLeftText = TextComponent(
      anchor: Anchor.center,
      text: '정면도',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(170, 445),
    );
    world.add(bottomLeftText);

    TextComponent bottomRightText = TextComponent(
      anchor: Anchor.center,
      text: '우측면도',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(400, 445),
    );
    world.add(bottomRightText);

    TextComponent score = TextComponent(
      anchor: Anchor.center,
      text: '점',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: Vector2(1120, 170),
    );
    world.add(score);

    scoreText = TextComponent(
      anchor: Anchor.centerRight,
      text: '$currScore',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: Vector2(1100, 173),
    );
    world.add(scoreText);

    world.add(
      SpriteComponent(
        sprite: arrowSprite,
        position: Vector2(650, 600),
        size: Vector2.all(25),
        angle: -math.pi * 0.2,
      ),
    );

    PassButton passButton = PassButton(
      position: Vector2(710, 650),
    );
    world.add(passButton);

    ConfirmButton confirmButton = ConfirmButton(
      position: Vector2(890, 650),
    );
    world.add(confirmButton);

    ResetButton resetButton = ResetButton(
      position: Vector2(1050, 650),
    );
    world.add(resetButton);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    if( floor != null ) world.remove(floor!);
    if( questionView != null ) world.remove(questionView!);
    floor = Floor(
      position: Vector2(870, 540),
    );
    world.add(floor!);

    questionView = QuestionView(
      position: Vector2(356, 420),
      isSecondHalf: isSecondHalf,
    );
    world.add(questionView!);
  }

  void addScore(int score){
    currScore += score;
    scoreText.text = '$currScore';
    gameStep.updateScore(currScore);
  }
}