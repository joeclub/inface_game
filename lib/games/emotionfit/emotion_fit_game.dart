import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'emotion_button.dart';

enum EmotionType{
  // ignore: constant_identifier_names
  Expressionless,
  // ignore: constant_identifier_names
  Surprised,
  // ignore: constant_identifier_names
  Sad,
  // ignore: constant_identifier_names
  Anger,
  // ignore: constant_identifier_names
  Confusion,
  // ignore: constant_identifier_names
  Fear,
  // ignore: constant_identifier_names
  Aversion,
  // ignore: constant_identifier_names
  Pleasure
}

class EmotionFitGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  int emotionIndex = 0;

  TextComponent? roundText;
  SpriteComponent? emotionSprite;

  //List<List<Sprite>> lstEmotionSprites = [];
  List<int> lstEmotionCount = [];

  EmotionFitGame({required super.context});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 8, gameName: '감정 맞히기', timeLimit: limitTime, context: context, gameDescIndex: 7);
    world.add(gameStep);
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
    lstEmotionCount.add(46);
    lstEmotionCount.add(22);
    lstEmotionCount.add(11);
    lstEmotionCount.add(27);
    lstEmotionCount.add(46);
    lstEmotionCount.add(28);
    lstEmotionCount.add(19);
    lstEmotionCount.add(28);
    
    ColorRectComponent buttonBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 247, 247, 247),
      position: Vector2(890, 410),
      size: Vector2(540, 538),
      anchor: Anchor.center,
    );
    world.add(buttonBackground);

    EmotionButton expressionlessButton = EmotionButton(
      position: Vector2(170, 110),
      buttonText: '침착',
      buttonIndex: 0,
    );
    buttonBackground.add(expressionlessButton);

    EmotionButton suprisedButton = EmotionButton(
      position: Vector2(370, 110),
      buttonText: '놀람',
      buttonIndex: 1,
    );
    buttonBackground.add(suprisedButton);

    EmotionButton sadButton = EmotionButton(
      position: Vector2(170, 230),
      buttonText: '슬픔',
      buttonIndex: 2,
    );
    buttonBackground.add(sadButton);

    EmotionButton angerButton = EmotionButton(
      position: Vector2(370, 230),
      buttonText: '분노',
      buttonIndex: 3,
    );
    buttonBackground.add(angerButton);

    EmotionButton confusionButton = EmotionButton(
      position: Vector2(170, 350),
      buttonText: '혼란',
      buttonIndex: 4,
    );
    buttonBackground.add(confusionButton);

    EmotionButton fearButton = EmotionButton(
      position: Vector2(370, 350),
      buttonText: '공포',
      buttonIndex: 5,
    );
    buttonBackground.add(fearButton);

    EmotionButton aversionButton = EmotionButton(
      position: Vector2(170, 470),
      buttonText: '혐오',
      buttonIndex: 6,
    );
    buttonBackground.add(aversionButton);

    EmotionButton pleasureButton = EmotionButton(
      position: Vector2(370, 470),
      buttonText: '기쁨',
      buttonIndex: 7,
    );
    buttonBackground.add(pleasureButton);
  }

  @override
  Future<void> resetGame() async {
    currRound++;
    gameStep.updateRound();

    if( roundText != null ) world.remove(roundText!);

    roundText = TextComponent(
      anchor: Anchor.center,
      text: 'ROUND ${currRound.toString()}',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 4, 25)),
      ),
      position: Vector2(890, 175),
    );
    world.add(roundText!);

    if( emotionSprite != null ) world.remove(emotionSprite!);

    emotionIndex = Random().nextInt(EmotionType.values.length);

    String emotionName = EmotionType.values[emotionIndex].name;
    int emotionIndex2 = Random().nextInt(lstEmotionCount[emotionIndex]) + 1;
    String emotionFileName = emotionName + emotionIndex2.toString();

    Sprite sprite = await loadSprite('games/emotionfit/$emotionName/$emotionFileName.jpg');
    
    emotionSprite = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2(320, 420),
      size: Vector2.all(300),
      sprite: sprite,
    );
    world.add(emotionSprite!);
  }
}
