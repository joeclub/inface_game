import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:inface/games/sortball/submit_button.dart';

import '../../models/base/game/sort_ball_model.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer.dart';
import 'ball.dart';
import 'count_text_board.dart';
import 'pool.dart';
import 'result_text.dart';
import 'scale.dart';

class SortBallGame extends EduceGame with HasGameRef<SortBallGame> {
  late List<SortBallModel> lstBalls;
  late GameStep gameStep;
  final limitTime = 4 * 60;
  Pool? ballPool;
  Answer? answer;

  bool isSecondHalf = false;

  List<SortBallModel> lstPoolBalls = [];
  List<Ball> lstBallComponents = [];
  Scale? scale;

  ResultText? resultText;
  CountTextBoard? countTextBoard;
  int tryCount = 0;
  int ballCount = 6;

  SortBallGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    String json = await rootBundle.loadString('assets/games/sortball/WeightList.json');
    lstBalls = sortBallModelFromJson(json);

    // ignore: use_build_context_synchronously
    gameStep = GameStep( gameNumber: 2, gameName: '무거운 순서대로 나열하기', timeLimit: limitTime, gameDescIndex: 1);

    world.add(gameStep);

    //await initGame();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // gameTimer.limitTimer.update(dt);
    if (gameStep.limitTimer.current > gameStep.halfTime) {
      isSecondHalf = true;
    }
    if (gameStep.limitTimer.finished) {
      endGame();
    }
  }

  void endGame() {}

  @override
  void initGame(){
    resultText = ResultText(position: Vector2(1014, 320));
    world.add(resultText!);

    countTextBoard = CountTextBoard(position: Vector2(1014, 410));
    world.add(countTextBoard!);

    SubmitButton submitButton = SubmitButton(position: Vector2(1014, 500));
    world.add(submitButton);
  }

  @override
  void resetGame() {
    currRound++;
    gameStep.updateRound();
    
    if (scale != null) {
      world.remove(scale!);
    }
    scale = Scale(position: Vector2(640 - 110, 460));
    world.add(scale!);

    if (ballPool != null) {
      world.remove(ballPool!);
    }

    for (int i = 0; i < lstBallComponents.length; ++i) {
      world.remove(lstBallComponents[i]);
    }
    lstBallComponents.clear();

    if (answer != null) {
      world.remove(answer!);
    }

    lstPoolBalls.clear();
    lstPoolBalls.addAll(lstBalls);
    lstPoolBalls.shuffle();

    ballCount = 6;
    if (isSecondHalf == false) {
      ballCount = Random().nextInt(2) + 4;
    }

    tryCount = 0;
    countTextBoard!.minText.text = (ballCount - 1).toString();
    countTextBoard!.currText.text = tryCount.toString();

    ballPool = Pool(ballCount: ballCount, position: Vector2(640, 200));
    world.add(ballPool!);

    List<SortBallModel> lstAnswer = lstPoolBalls.getRange(0, ballCount).toList();
    answer = Answer(lstAnswer: lstAnswer, position: Vector2(640, 630));
    world.add(answer!);

    double startX = 640 - (ballCount - 1) * 130 * 0.5;
    for (int i = 0; i < ballCount; ++i) {
      String spriteName = lstPoolBalls[i].spriteName;
      var lstStrings = spriteName.split("ball");
      int ballIndex = int.parse(lstStrings[1]);
      int ballWeight = int.parse(lstPoolBalls[i].weight);
      double posX = startX + i * 130;
      Ball ball = Ball(
          ballIndex: ballIndex,
          weight: ballWeight,
          position: Vector2(posX, 200));
      lstBallComponents.add(ball);
    }

    world.addAll(lstBallComponents);
  }

  bool setBall(Ball ball) {
    if (scale!.setBall(ball)) {
      return true;
    }
    if (answer!.setBall(ball)) {
      return true;
    }
    return false;
  }

  void ballDragStart(Ball ball) {
    scale!.removeBall(ball);
    answer!.removeBall(ball);
  }

  void checkAnswer() {
    bool result = answer!.checkBall();
    resultText!.setResult(result);
    int minCount = ballCount - 1;
    if( result ) {
      if( isSecondHalf ){
        if( minCount < tryCount ) {
          currScore += 200;
        } else {
          currScore += 250;
        }
      }
      else {
        if( minCount < tryCount ) {
          currScore += 100;
        } else {
          currScore += 200;
        }
      }
    }
    gameStep.updateScore(currScore);
    resetGame();
  }

  void addTry() {
    tryCount++;
    countTextBoard!.currText.text = tryCount.toString();
  }
}
