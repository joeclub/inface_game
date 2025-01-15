import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/cardflip/scoreboard.dart';
import 'package:inface/games/components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'game_card.dart';

class CardFlipGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  final numCards = 4 * 8;
  List<GameCard> lstCards = [];
  late ColorRectComponent playBoard;
  int unhappinessCount = 0;
  ScoreBoard? scoreBoard;

  bool isStageEnding = false;
  bool isTweening = false;

  CardFlipGame({required super.hasFirstHalfScore, required super.hasRoundScore, required super.isEP});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 3, gameName: '카드 뒤집기', timeLimit: limitTime, gameDescIndex: 2);
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

  @override
  void endGame() {
    super.endGame();
  }

  @override
  void initGame(){
    playBoard = ColorRectComponent(
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(100, 150),
      size: Vector2(770, 540),
      anchor: Anchor.topLeft
    );
    world.add(playBoard);

    ColorRectComponent scoreBoardBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2(870, 150),
      size: Vector2(300, 540),
      anchor: Anchor.topLeft
    );
    world.add(scoreBoardBackground);

    scoreBoard = ScoreBoard(
      position: Vector2(1019, 420),
    );
    world.add(scoreBoard!);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    for(int i=0; i<lstCards.length; ++i){
      world.remove(lstCards[i]);
    }
    lstCards.clear();

    Vector2 startPos = playBoard.position + Vector2.all(20) + Vector2(35, 54);

    List<int> cardSuffle = [];
    for(int i=0; i<numCards; ++i){
      cardSuffle.add(i);
    }
    cardSuffle.shuffle();
    unhappinessCount = Random().nextInt(3) + (isSecondHalf ? 4 : 1);
    
    for(int i=0; i<numCards; ++i){
      int posX = i % 8;
      int posY = i ~/ 8;
      GameCard card = GameCard(
        position: startPos + Vector2(posX * 94, posY * 132),
        cardIndex: i,
        isHappiness: true,
      );
      world.add(card);
      lstCards.add(card);
    }

    for( int i=0; i<unhappinessCount; ++i){
      int index = cardSuffle[i];
      lstCards[index].isHappiness = false;
    }

    int happinessScore = 0;
    int unhappinessScore = 0;

    switch(unhappinessCount){
      case 1:
      {
        happinessScore = 100;
        unhappinessScore = -750;
      }
      break;
      case 2:
      {
        happinessScore = 100;
        unhappinessScore = -750;
      }
      break;
      case 3:
      {
        happinessScore = 130;
        unhappinessScore = -550;
      }
      break;
      case 4:
      {
        happinessScore = 130;
        unhappinessScore = -550;
      }
      break;
      case 5:
      {
        happinessScore = 150;
        unhappinessScore = -300;
      }
      break;
      case 6:
      {
        happinessScore = 150;
        unhappinessScore = -300;
      }
      break;
    }
    scoreBoard!.updateRound(currRound, happinessScore, unhappinessScore, unhappinessCount);
  }

  void nextGame() async {
    isStageEnding = true;
    for( int i=0; i<lstCards.length; ++i){
      lstCards[i].flip(force: true);
    }

    await Future.delayed(const Duration(seconds: 2), (){
      isStageEnding = false;
      resetGame();
    });
  }
}
