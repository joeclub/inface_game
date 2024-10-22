import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'game_card.dart';

class MatchWeatherGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  int answerIndex = 0;

  List<GameCard> lstCards = [];
  late AnswerButton sunnyButton;
  late AnswerButton cloudyButton;

  List<bool> lstAnswers = [];

  bool isClicked = false;

  MatchWeatherGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 10, gameName: '날씨 맞히기', timeLimit: limitTime, gameDescIndex: 9);
    world.add(gameStep);

    

    // Future.delayed(const Duration(seconds: 2), () {
    //   resetGame();
    // });
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
    lstAnswers.add(false);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(true);
    lstAnswers.add(false);

    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(true);
    lstAnswers.add(false);
    lstAnswers.add(false);
    lstAnswers.add(true);
    lstAnswers.add(true);
    lstAnswers.add(false);

    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 234, 236, 245),
      position: Vector2(640, 420),
      size: Vector2(1009, 543),
      anchor: Anchor.center
    );
    world.add(background);

    GameCard gameCard = GameCard(
      cardIndex: 0,
      position: Vector2(295, 360),
      spriteName: 'temperature',
    );
    world.add(gameCard);
    lstCards.add(gameCard);

    TextComponent cardText = TextComponent(
      anchor: Anchor.center,
      text: '온도',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 160, 165, 187)),
      ),
      position: Vector2(295, 530),
    );
    world.add(cardText);

    gameCard = GameCard(
      cardIndex: 0,
      position: Vector2(525, 360),
      spriteName: 'humidity',
    );
    world.add(gameCard);
    lstCards.add(gameCard);

    cardText = TextComponent(
      anchor: Anchor.center,
      text: '습도',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 160, 165, 187)),
      ),
      position: Vector2(525, 530),
    );
    world.add(cardText);

    gameCard = GameCard(
      cardIndex: 0,
      position: Vector2(755, 360),
      spriteName: 'atmospheric_pressure',
    );
    world.add(gameCard);
    lstCards.add(gameCard);

    cardText = TextComponent(
      anchor: Anchor.center,
      text: '기압',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 160, 165, 187)),
      ),
      position: Vector2(755, 530),
    );
    world.add(cardText);

    gameCard = GameCard(
      cardIndex: 0,
      position: Vector2(985, 360),
      spriteName: 'windspeed',
    );
    world.add(gameCard);
    lstCards.add(gameCard);

    cardText = TextComponent(
      anchor: Anchor.center,
      text: '풍속',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 160, 165, 187)),
      ),
      position: Vector2(985, 530),
    );
    world.add(cardText);

    sunnyButton = AnswerButton(
      position: Vector2(526, 610),
      isSunny: true,
    );
    world.add(sunnyButton);

    cloudyButton = AnswerButton(
      position: Vector2(754, 610),
      isSunny: false,
    );
    world.add(cloudyButton);
    
    showButton(false);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    isClicked = false;
    
    answerIndex = Random().nextInt(lstAnswers.length);
    int temp = answerIndex;
    int currCard = lstAnswers.length;
    for( int i=0; i<4; ++i){
      currCard = currCard ~/ 2;
      bool isFront = temp < currCard;
      temp = (temp % currCard);
      lstCards[i].flip(isFront);
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      showButton(true);
    });
  }

  void showButton( isShow ){
    sunnyButton.isVisible = isShow;
    cloudyButton.isVisible = isShow;
  }

  void checkAnswer(bool isSunny){
    bool correct = lstAnswers[answerIndex] == isSunny;
    if( isSunny ) {
      sunnyButton.addColor(correct);
    } else {
      cloudyButton.addColor(correct);
    }

    if( correct ){
      currScore += 100;
    }
    gameStep.updateScore(currScore);

    Future.delayed(const Duration(seconds: 1), () {
     if( isSunny ) {
        sunnyButton.removeColor();
      } else {
        cloudyButton.removeColor();
      }
      showButton(false);
      for( int i=0; i<4; ++i){
        lstCards[i].flip(false);
      }
      Future.delayed(const Duration(seconds: 1), () {
        resetGame();
      });
    });
  }
}