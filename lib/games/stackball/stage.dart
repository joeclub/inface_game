import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';

import 'ball.dart';
import 'basket.dart';
import 'floor.dart';
import 'pillar.dart';

class Stage extends PositionComponent {
  final questionBallSize = Vector2(80, 44);
  final answerBallSize = Vector2(40, 22);
  final floorHeight = 30;
  final int numPillars;
  int numBalls = 0;
  final int suffleCount;

  final Stage? refStage;

  bool isAnswer;

  List<Pillar> lstPillars = <Pillar>[];
  List<Ball> lstBalls = <Ball>[];
  Basket? basket;

  Stage(
      {required super.position,
      required this.numPillars,
      required this.isAnswer,
      required this.suffleCount,
      required this.refStage});

  @override
  FutureOr<void> onLoad() {
    numBalls = numPillars;

    if (isAnswer == false) {
      basket = Basket()..position = Vector2(0, -350);
      add(basket!);
    }

    //addPillar();

    final floor = Floor()
      ..position = Vector2(0, 0)
      ..size = isAnswer ? Vector2(240, 15) : resizeVector(Vector2(600, 30));
    add(floor);

    addPillars();
    return super.onLoad();
  }

  void addPillars() {
    double startPos = isAnswer ? -80 : resizeScalar(-180);
    double interval = isAnswer ? 160 : resizeScalar(360);
    if (refStage == null) {
      List<int> lstBalls = <int>[];

      for (int i = 0; i < numBalls; ++i) {
        lstBalls.add(i);
      }

      lstBalls.shuffle();
      for (int i = 0; i < numPillars; ++i) {
        Pillar p = Pillar(maxBalls: numBalls - i, stage: this)
          ..position = Vector2(startPos + i * interval / (numPillars - 1), 0)
          ..size = resizeVector(Vector2(20, (numPillars - i) * 44));

        if (i == 0) {
          for (int j = 0; j < numBalls; ++j) {
            p.pushBall(lstBalls[j]);
          }
        }
        lstPillars.add(p);
        add(p);
      }
    } else {
      for (int i = 0; i < numPillars; ++i) {
        Pillar p = Pillar(maxBalls: numBalls - i, stage: this)
          ..position = Vector2(startPos + i * interval / (numPillars - 1), 0)
          ..size = resizeVector(Vector2(20, (numPillars - i) * 44));

        List<int> ballList = refStage!.lstPillars[i].stack.toList();
        for (int j = 0; j < ballList.length; ++j) {
          p.pushBall(ballList[j]);
        }

        lstPillars.add(p);
        add(p);
      }
    }

    suffleBalls(suffleCount, refStage != null);

    for (int i = 0; i < numPillars; ++i) {
      lstPillars[i].createBallInstance();
    }
  }

  void addBall(Ball ball) {
    lstBalls.add(ball);
    add(ball);
  }

  void suffleBalls(int moveCount, bool checkHistory) {
    int maxSuffleCount = 10;
    int suffleCount = 0;
    while (true) {
      int lastPillar = -1;
      for (int i = 0; i < moveCount; ++i) {
        int fromPillar = 0;
        while (true) {
          int random = Random().nextInt(numPillars);
          if (lastPillar != random) {
            if (lstPillars[random].getSize() > 0) {
              fromPillar = random;
              break;
            }
          }
        }

        int toPillar = 0;
        while (true) {
          int random = Random().nextInt(numPillars);
          if (random != fromPillar) {
            if (lstPillars[random].remainCount() > 0) {
              toPillar = random;
              break;
            }
          }
        }

        if (lstPillars[toPillar].stack.size() + 1 == numBalls) {
          --i;
          continue;
        }

        lastPillar = toPillar;

        int ball = lstPillars[fromPillar].popBall();
        lstPillars[toPillar].pushBall(ball);

        //List<int> history = [];
        //history.add(ball);
      }

      if (checkHistory == false) break;
      //history = history.toSet().toList();

      suffleCount++;
      if (suffleCount >= maxSuffleCount) break;

      bool match = false;
      for (int i = 0; i < lstPillars.length; ++i) {
        List<int> lhs = lstPillars[i].stack.toList();
        List<int> rhs = refStage!.lstPillars[i].stack.toList();

        int stackCount = min(lhs.length, rhs.length);
        for (int j = 0; j < stackCount; ++j) {
          if (lhs[j] == rhs[j]) {
            match = true;
            break;
          }
        }
        if (match) break;
      }

      if (match == false) {
        break;
      } else {
        for (int i = 0; i < lstPillars.length; ++i) {
          //lstPillars[i].stack = refStage!.lstPillars[i].stack;
          lstPillars[i].stack.clear();
          List<int> temp = refStage!.lstPillars[i].stack.toList();
          for (int j = 0; j < temp.length; ++j) {
            lstPillars[i].stack.push(temp[j]);
          }
        }
      }
    }
  }

  Vector2 resizeVector(Vector2 s) {
    return s * (isAnswer ? 0.5 : 1);
  }

  double resizeScalar(double s) {
    return s * (isAnswer ? 0.5 : 1);
  }
}
