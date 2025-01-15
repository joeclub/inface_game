import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/end_game_popup.dart';
import 'package:inface/games/stackball/giveup.dart';

import '../components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'stage.dart';

class StackBallGame extends EduceGame {
  final questionBallSize = Vector2(80, 44);
  final answerBallSize = Vector2(40, 22);
  final floorHeight = 30;

  bool isTweening = false;
  Stage? stageAnswer;
  Stage? stageQuestion;

  int minMoveCount = 0;
  int currMoveCount = 0;
  late TextComponent minMoveCountText;
  late TextComponent currMoveCountText;
  late TextComponent currStageText;
  int currStage = 0;
  bool isEndGame = false;

  late int limitTime;

  late GameStep gameStep;

  final TextPaint timerPaint = TextPaint(
    style: const TextStyle(color: Colors.black, fontSize: 25),
  );

  bool isSecondHalfQuestion = false;

  StackBallGame();

  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    limitTime = 4 * 60;
    gameStep = GameStep(gameNumber: 1, gameName: '공 옮기기', timeLimit: limitTime, );
    world.add(gameStep);
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

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   int remainTime = max(0, (limitTime - limitTimer.current).toInt());
  //   int minuites = remainTime ~/ 60;
  //   int seconds = remainTime % 60;
  //   String strMinutes = NumberFormat('00').format(minuites);
  //   timerPaint.render(canvas, "$strMinutes : $seconds", Vector2(100, 100));
  // }

  @override
  void endGame() {
    isEndGame = true;
    super.endGame();
  }

  @override
  void resetGame() {
    if (stageAnswer != null) world.remove(stageAnswer!);
    if (stageQuestion != null) world.remove(stageQuestion!);

    currRound++;
    gameStep.updateRound();

    isSecondHalfQuestion = isSecondHalf;

    while (true) {
      int numPillars = isSecondHalf ? 4 : 3;

      int suffleCount = Random().nextInt(2) + numPillars;

      stageQuestion = Stage(
          position: Vector2(840, 546),
          numPillars: numPillars,
          isAnswer: false,
          suffleCount: numPillars * 2,
          refStage: null);
      world.add(stageQuestion!);

      stageAnswer = Stage(
          position: Vector2(250, 400),
          numPillars: numPillars,
          isAnswer: true,
          suffleCount: suffleCount,
          refStage: stageQuestion);
      world.add(stageAnswer!);

      if (compareStage() == true) {
        if (stageAnswer != null) world.remove(stageAnswer!);
        if (stageQuestion != null) world.remove(stageQuestion!);
      } else {
        minMoveCount = suffleCount;
        break;
      }
    }
    currMoveCount = 0;
    currStage++;
    updateMinMoveCount();
    updateCurrMoveCount();
    updateCurrStageCount();

    // EndGamePopup endGamePopup = EndGamePopup(
    //   position: Vector2(640, 360),
    //   point: 100
    // );
    // world.add(endGamePopup);
  }

  @override
  void initGame() {
    super.initGame();

    const Color bottomColor = Color.fromARGB(255, 237, 237, 237);
    world.add(ColorRectComponent(
        anchor: Anchor.bottomCenter,
        position: Vector2(640, 720),
        size: Vector2(1280, 144),
        color: bottomColor));

    const Color answerBackgroundColor = Color.fromARGB(255, 247, 247, 247);
    world.add(ColorRectComponent(
        anchor: Anchor.topCenter,
        position: Vector2(250, 150),
        size: Vector2(300, 325),
        color: answerBackgroundColor));

    const Color scoreBackgroundColor = Colors.white;
    world.add(ColorRectComponent(
        anchor: Anchor.topCenter,
        position: Vector2(250, 475),
        size: Vector2(300, 173),
        color: scoreBackgroundColor));

    world.add(TextComponent(
      anchor: Anchor.bottomCenter,
      text: '* 공과 기둥을 클릭하여 공을 원하는 위치로 움직이세요.',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 115, 117, 126),
        ),
      ),
      position: Vector2(840, 620),
    ));

    world.add(currStageText = TextComponent(
      anchor: Anchor.topCenter,
      text: '보기 ${currStage + 1}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 115, 117, 126),
        ),
      ),
      position: Vector2(250, 180),
    ));

    world.add(TextComponent(
      anchor: Anchor.topCenter,
      text: '최소 이동 횟수',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 115, 117, 126),
        ),
      ),
      position: Vector2(180, 500),
    ));

    world.add(TextComponent(
      anchor: Anchor.topCenter,
      text: '현재 이동 횟수',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 115, 117, 126),
        ),
      ),
      position: Vector2(320, 500),
    ));

    world.add(minMoveCountText = TextComponent(
      anchor: Anchor.topCenter,
      text: minMoveCount.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 60,
          color: Color.fromARGB(255, 52, 186, 204),
        ),
      ),
      position: Vector2(180, 540),
    ));

    world.add(currMoveCountText = TextComponent(
      anchor: Anchor.topCenter,
      text: currMoveCount.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 60,
          color: Color.fromARGB(255, 255, 59, 59),
        ),
      ),
      position: Vector2(320, 540),
    ));

    world.add(
      GiveupButton(
        position: Vector2(250, 685)
      )
    );

    
  }

  bool compareStage() {
    for (int i = 0; i < stageAnswer!.lstPillars.length; ++i) {
      if (stageAnswer!.lstPillars[i].compare(stageQuestion!.lstPillars[i].stack) == false) {
        return false;
      }
    }
    return true;
  }

  void checkCorrect() {
    if (compareStage() == false) return;

    if( isSecondHalfQuestion ){
      //if( stageAnswer!.lstPillars.length == 3 ) {
      if( minMoveCount < currMoveCount ) {
        currScore += 200;
      } else {
        currScore += 250;
      }
    } else {
      //if( stageAnswer!.lstPillars.length == 3 ) {
      if( minMoveCount < currMoveCount ) {
        currScore += 100;
      } else {
        currScore += 150;
      }
    }
    gameStep.updateScore(currScore);

    resetGame();
  }

  void updateCurrMoveCount() {
    currMoveCountText.text = currMoveCount.toString();
  }

  void updateMinMoveCount() {
    minMoveCountText.text = minMoveCount.toString();
  }

  void updateCurrStageCount() {
    currStageText.text = '보기 $currStage';
  }
}
