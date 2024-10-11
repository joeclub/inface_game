import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../models/base/game/sort_ball_model.dart';
import 'ball.dart';
import 'ball_socket.dart';

class Answer extends PositionComponent with HasGameRef {
  final List<SortBallModel> lstAnswer;
  late NineTileBoxComponent tileBox;
  List<BallSocket> lstBallSockets = [];
  Answer({required super.position, required this.lstAnswer});

  @override
  Future<void> onLoad() async {
    final Sprite sprite =
        await gameRef.loadSprite('games/sortball/bottomBg.png');
    NineTileBox nineTileBox = NineTileBox(sprite)
      ..setGrid(leftWidth: 90, rightWidth: 90, topHeight: 1, bottomHeight: 1);
    nineTileBox = nineTileBox;
    anchor = Anchor.center;

    double tileBoxWidth = (lstAnswer.length - 1) * 150 + 200;
    Vector2 tileBoxSize = Vector2(tileBoxWidth, 90);

    tileBox = NineTileBoxComponent(
      nineTileBox: nineTileBox,
      position: -tileBoxSize * 0.5,
      size: tileBoxSize,
    );

    add(tileBox);

    lstAnswer.sort((a, b) {
      int aWeight = int.parse(a.weight);
      int bWeight = int.parse(b.weight);
      if (aWeight < bWeight) {
        return -1;
      } else {
        return 1;
      }
    });

    double startPos = -(lstAnswer.length - 1) * 150 * 0.5;
    for (int i = 0; i < lstAnswer.length; ++i) {
      BallSocket socket =
          BallSocket(position: Vector2(startPos + i * 150, 0), isScale: false);
      add(socket);
      lstBallSockets.add(socket);
    }

    startPos = -(lstAnswer.length - 2) * 150 * 0.5;
    for (int i = 0; i < lstAnswer.length - 1; ++i) {
      String signText = '<';
      if (lstAnswer[i].weight == lstAnswer[i + 1].weight) {
        signText = '=';
      }
      add(TextComponent(
        anchor: Anchor.center,
        text: signText,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        position: Vector2(startPos + i * 150, 0),
      ));
    }

    super.onLoad();
  }

  bool setBall(Ball ball) {
    for (int i = 0; i < lstBallSockets.length; ++i) {
      if (lstBallSockets[i].setBall(ball, position)) {
        return true;
      }
    }

    return false;
  }

  void removeBall(Ball ball) {
    for (int i = 0; i < lstBallSockets.length; ++i) {
      if (lstBallSockets[i].ball == ball) {
        lstBallSockets[i].ball = null;
      }
    }
  }

  bool checkBall() {
    for (int i = 0; i < lstBallSockets.length; ++i) {
      if (lstBallSockets[i].ball == null) {
        return false;
      }
    }

    for (int i = 0; i < lstBallSockets.length; ++i) {
      int weight = int.parse(lstAnswer[i].weight);
      if (lstBallSockets[i].ball!.weight != weight) {
        return false;
      }
    }

    return true;
  }
}
