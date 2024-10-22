import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'lane.dart';

class DefendingBallGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  bool isGameEnd = false;

  int matchScore = 30;

  DefendingBallGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 13, gameName: '공 막아 내기', timeLimit: limitTime, gameDescIndex: 13);
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
    isGameEnd = true;

  }

  @override
  void initGame(){

  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    
    if( isSecondHalf ){
      int laneIndex = Random().nextInt(LaneType.values.length);
      Lane lane = Lane(
        position: Vector2(500, 420),
        laneIndex: laneIndex,
      );
      world.add(lane);

      laneIndex = Random().nextInt(LaneType.values.length);
      lane = Lane(
        position: Vector2(780, 420),
        laneIndex: laneIndex,
      );
      world.add(lane);
    } else {
      int laneIndex = Random().nextInt(LaneType.values.length);
      Lane lane = Lane(
        position: Vector2(640, 420),
        laneIndex: laneIndex,
      );
      world.add(lane);
    } 
  }

  void removeLane(Lane lane){
    world.remove(lane);
    resetGame();
  }

  void addScore(int score){
    currScore += score;
    currScore = max(0, currScore);
    gameStep.updateScore(currScore);
  }
}