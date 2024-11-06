import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/sortball/sort_ball_game.dart';

import '../components/color_rect_component.dart';
import 'ball.dart';
import 'ball_socket.dart';

class Scale extends PositionComponent with HasGameRef<SortBallGame> {
  late SpriteComponent scaleBase;
  late BallSocket leftSocket;
  late BallSocket rightSocket;

  late TextComponent sign;

  Scale({required super.position});

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;

    leftSocket = BallSocket(position: Vector2(-220, -50), isScale: true);
    rightSocket = BallSocket(position: Vector2(220, -50), isScale: true);
    add(leftSocket);
    add(rightSocket);

    Vector2 scaleBasePos = Vector2(0, 30);
    Sprite spriteBallScale = await gameRef.loadSprite('games/sortball/ballscale.png');
    SpriteComponent ballScaleComponent = SpriteComponent(
        sprite: spriteBallScale,
        position: scaleBasePos,
        anchor: Anchor.center,
        size: Vector2(660, 75));
    ballScaleComponent.paint.filterQuality = FilterQuality.high;
    add(ballScaleComponent);

    add(SpriteComponent(
        sprite: await gameRef.loadSprite('games/sortball/spots.png'),
        position: Vector2(-90, -50),
        anchor: Anchor.center,
        size: Vector2(100, 4)));

    add(SpriteComponent(
        sprite: await gameRef.loadSprite('games/sortball/spots.png'),
        position: Vector2(90, -50),
        anchor: Anchor.center,
        size: Vector2(100, 4)));

    add(ColorRectComponent(
        color: const Color.fromARGB(255, 226, 226, 226),
        position: Vector2(0, -50),
        anchor: Anchor.center,
        size: Vector2(60, 60)));

    add(ColorRectComponent(
        color: Colors.white,
        position: Vector2(0, -50),
        anchor: Anchor.center,
        size: Vector2(57, 57)));

    add(sign = TextComponent(
      anchor: Anchor.center,
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 50,
          color: Colors.black,
        ),
      ),
      position: Vector2(0, -50),
    ));

    return super.onLoad();
  }

  bool setBall(Ball ball) {
    if (leftSocket.setBall(ball, position)) {
      checkBall(checkTry: true);
      return true;
    }

    if (rightSocket.setBall(ball, position)) {
      checkBall(checkTry: true);
      return true;
    }

    return false;
  }

  void checkBall({bool checkTry = false}) {
    if (leftSocket.ball != null && rightSocket.ball != null) {
      if (leftSocket.ball!.weight > rightSocket.ball!.weight) {
        sign.text = '>';
      } else if (leftSocket.ball!.weight < rightSocket.ball!.weight) {
        sign.text = '<';
      } else {
        sign.text = '=';
      }
      if( checkTry == true ){
        gameRef.addTry();
      }
      
    } else {
      sign.text = '';
    }
  }

  void removeBall(Ball ball) {
    if (leftSocket.ball == ball) {
      leftSocket.ball = null;
    }

    if (rightSocket.ball == ball) {
      rightSocket.ball = null;
    }
    checkBall();
  }
}
