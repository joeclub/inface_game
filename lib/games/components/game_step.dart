import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/base/game/game_desc_model.dart';
import '../../util.dart';
import 'color_rect_component.dart';
import 'countdown.dart';
import 'educe_game.dart';
import 'game_backbutton.dart';
import 'game_desc.dart';
import 'input_ui.dart';

class GameStep extends PositionComponent with HasGameRef<EduceGame> {
  final int timeLimit;
  final int gameNumber;
  final String gameName;
  late int halfTime;
  late Timer limitTimer;
  late TextComponent timerText;
  late ColorRectComponent background;
  late ColorRectComponent background2;

  late ColorRectComponent backgroundReady;
  late ColorRectComponent backgroundPlaying;
  late ColorRectComponent backgroundEndGame;

  late TextComponent gameNameText;
  late TextComponent gameNameText2;

  late TextComponent scoreText;

  late InputUI inputUI;
  GameDesc? gameDesc;

  late Sprite sprite;

  late TextComponent readyText;
  late TextComponent playingText;
  late TextComponent endGameText;

  late GameBackButton backButton;

  final bool isCat;

  int step = 0;
  double currTime = 0;

  List<GameDescModel> lstGameDesc = [];

  int gameDescIndex;

  bool isKeyboardControl;

  bool isHalfTime;

  GameStep( {
    required this.timeLimit,
    required this.gameNumber,
    required this.gameName,
    this.isCat = false,
    this.gameDescIndex = 0,
    this.isKeyboardControl = false,
    this.isHalfTime = false,
  });

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    limitTimer = Timer(timeLimit.toDouble());
    halfTime = timeLimit ~/ 2;

    String json = await rootBundle.loadString('assets/games/GameDesc.json');
    lstGameDesc = gameDescModelFromJson(json);

    sprite = await gameRef.loadSprite('common/clock_blue.png');
    init();
  }

  void init(){
    position = Vector2(0, 0);

    backgroundReady = ColorRectComponent(
        color: const Color.fromARGB(255, 51, 60, 100),
        position: Vector2(0, 0),
        size: Vector2(426.6, 60),
        anchor: Anchor.topLeft);
    add(backgroundReady);

    readyText = TextComponent()
      ..anchor = Anchor.center
      ..text = '게임 안내'
      ..position = backgroundReady.size * 0.5
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 20,
          color: BasicPalette.white.color,
        ),
      );
    backgroundReady.add(readyText);

    backgroundPlaying = ColorRectComponent(
        color: const Color.fromARGB(255, 52, 186, 204),
        position: Vector2(426.6, 0),
        size: Vector2(426.6, 60),
        anchor: Anchor.topLeft);
    add(backgroundPlaying);

    playingText = TextComponent()
      ..anchor = Anchor.center
      ..text = '게임 진행'
      ..position = backgroundPlaying.size * 0.5
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 20,
          color: BasicPalette.white.color,
        ),
      );
    backgroundPlaying.add(playingText);

    backgroundEndGame = ColorRectComponent(
        color: const Color.fromARGB(255, 51, 60, 100),
        position: Vector2(426.6 * 2, 0),
        size: Vector2(426.6, 60),
        anchor: Anchor.topLeft);
    add(backgroundEndGame);

    endGameText = TextComponent()
      ..anchor = Anchor.center
      ..text = '게임 종료'
      ..position = backgroundEndGame.size * 0.5
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 20,
          color: BasicPalette.white.color,
        ),
      );
    backgroundEndGame.add(endGameText);

    background = ColorRectComponent(
        color: const Color.fromARGB(255, 247, 247, 247),
        position: Vector2(0, 60),
        size: Vector2(1280, 60),
        anchor: Anchor.topLeft);
    add(background);

    background2 = ColorRectComponent(
        color: BasicPalette.white.color,
        position: Vector2(60, 1),
        size: Vector2(1050, 58),
        anchor: Anchor.topLeft);
    background.add(background2);

    SpriteComponent clock = SpriteComponent(
      anchor: Anchor.centerLeft,
      sprite: sprite,
      position: Vector2(1135, 30),
      size: Vector2(30, 30),
    );
    background.add(clock);

    timerText = TextComponent()
      ..anchor = Anchor.centerLeft
      ..text = isHalfTime ? '02:00' : '04:00'
      ..position = Vector2(1180, 30)
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 25,
          color: BasicPalette.black.color,
        ),
      );
    background.add(timerText);

    TextComponent gameText = TextComponent()
      ..anchor = Anchor.center
      ..text = isCat ? 'CAT' : 'GAME'
      ..position = Vector2(28.75, 15)
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 13,
          color: BasicPalette.black.color,
        ),
      );
    background.add(gameText);

    String strGameNumber = NumberFormat('00').format(gameNumber);
    TextComponent gameNumberText = TextComponent()
      ..anchor = Anchor.center
      ..text = strGameNumber
      ..position = Vector2(28.75, 38)
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 30,
          color: BasicPalette.black.color,
        ),
      );
    background.add(gameNumberText);

    gameNameText = TextComponent()
      ..anchor = Anchor.centerLeft
      ..text = gameName
      ..position = Vector2(80, 30)
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontWeight: F.SemiBold,
          fontSize: 15,
          color: BasicPalette.black.color,
        ),
      );
    background.add(gameNameText);

    gameNameText2 = TextComponent()
      ..anchor = Anchor.centerLeft
      ..text = ''
      ..position = Vector2(62, 8)
      ..textRenderer = TextPaint(
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 115, 117, 126),
        ),
      );
    gameNameText.add(gameNameText2);

    //Countdown countdown = Countdown();
    //gameRef.world.add(countdown);

    inputUI = InputUI(
      position: Vector2(640, 420),
      isKeyboardControl: isKeyboardControl,
      parentGameStep: this,
    );
    gameRef.world.add(inputUI);

    backButton = GameBackButton(
      position: Vector2(50, 30),
    );
    gameRef.world.add(backButton);

    scoreText = TextComponent()
      ..anchor = Anchor.center
      ..text = '0'
      ..position = Vector2(640, 30)
      ..textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 40,
          color: BasicPalette.red.color,
        ),
      );
    background.add(scoreText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if( step == 0 ){
      // readyText.text = '게임 안내';
      // playingText.text = '게임 진행';
      // endGameText.text = '게임 종료';
      
    } else if( step == 1){
      currTime += dt;
      if( currTime > 4.5 ){
        step++;
      }

      if( gameRef.isInit == false ){
        gameRef.currTime += dt;
        if( gameRef.currTime > 4.1 ){
          gameRef.initGame();
          gameRef.resetGame();
          gameRef.isInit = true;
        }
      }
    }
    else {
      limitTimer.update(dt);

      int remainTime = max(0, (timeLimit - limitTimer.current).toInt());
      int minuites = remainTime ~/ 60;
      int seconds = remainTime % 60;
      String strMinutes = NumberFormat('00').format(minuites);
      String strSeconds = NumberFormat('00').format(seconds);
      timerText.text = "$strMinutes:$strSeconds";
    }
  }

  void updateScore(int score){
    scoreText.text = score.toString();
  }

  void showGameDesc(){
    gameRef.world.remove(inputUI);
    gameDesc = GameDesc(
      position: Vector2(640, 420),
      gameDescModel: lstGameDesc[gameDescIndex],
      parentGameStep: this,
    );
    gameRef.world.add(gameDesc!);
  }

  void startGame(){
    step++;
    if( gameDesc != null ) {
      gameRef.world.remove(gameDesc!);
    }
    
    Countdown countdown = Countdown();
    gameRef.world.add(countdown);
  }

  void updateRound(){
    gameNameText.text = 'ROUND ${gameRef.currRound}';
    gameNameText2.text = lstGameDesc[gameDescIndex].desc;
    int length = gameRef.currRound.toString().length - 1;
    gameNameText2.position = Vector2(62, 8) + Vector2(length*10, 0);

  }
}
