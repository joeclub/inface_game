import 'dart:math';

import 'package:flame/components.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'balloon.dart';
import 'balloon_bottom.dart';
import 'pump.dart';
import 'scoreboard.dart';

class BlowBalloonGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  Balloon? balloon;
  BalloonBottom? balloonBottom;
  late Pump pump;
  ScoreBoard? scoreBoard;

  int maxBlow = 0;
  int currBlow = 0;

  int remainBalloon = 0;
  int expectedProfit = 0;
  int accumulatedProfit = 0;
  bool isGameEnd = false;

  BlowBalloonGame();
  
  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 4, gameName: '풍선 불기', timeLimit: limitTime, gameDescIndex: 3);
    world.add(gameStep);

    isLoadedGame = true;
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
    remainBalloon = 0;
    scoreBoard!.updateScore(remainBalloon, expectedProfit, accumulatedProfit);
  }

  @override
  void initGame(){
    pump = Pump(position: Vector2(910, 600));
    world.add(pump);

    scoreBoard = ScoreBoard(position: Vector2(360, 410));
    world.add(scoreBoard!);

    remainBalloon = 31;
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    if( balloon != null ) {
      world.remove(balloon!);
    }
    if( balloonBottom != null ) {
      world.remove(balloonBottom!);
    }

    remainBalloon--;
    if( remainBalloon < 1 ){
      endGame();
      return;
    }

    maxBlow = Random().nextInt(64) + 1;
    currBlow = 0;

    int balloonIndex = Random().nextInt(4);
    balloon = Balloon(position: Vector2(910, 517), balloonIndex: balloonIndex);
    world.add(balloon!);

    balloonBottom = BalloonBottom(position: Vector2(910, 537), balloonIndex: balloonIndex);
    world.add(balloonBottom!);

    scoreBoard!.updateScore(remainBalloon, expectedProfit, accumulatedProfit);
  }

  void blow(){
    if( isGameEnd ){
      return;
    }
    currBlow++;
    pump.setPumpCount(currBlow);
    if( maxBlow <= currBlow ) {
      expectedProfit = 0;
      resetGame();
    }

    expectedProfit += 1000;
    scoreBoard!.updateScore(remainBalloon, expectedProfit, accumulatedProfit);

    if( balloon != null){
      balloon!.blow();
    }
  }

  void accmulate(){
    if( isGameEnd ){
      return;
    }
    accumulatedProfit += expectedProfit;
    expectedProfit = 0;
    scoreBoard!.updateScore(remainBalloon, expectedProfit, accumulatedProfit);
    gameStep.updateScore(accumulatedProfit);
    pump.setPumpCount(0);
    resetGame();
  }
}