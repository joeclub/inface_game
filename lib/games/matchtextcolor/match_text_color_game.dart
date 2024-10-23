import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/base/game/match_text_color_model.dart';
import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';

class MatchTextColorGame extends EduceGame with KeyboardEvents {
  final limitTime = 2 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  List<MatchTextColorModel> lstTextColorData = [];

  bool isMatched = false;

  TextComponent? leftText;
  TextComponent? rightText;

  MatchTextColorGame();

  late Sprite backgroundSprite;
  late Sprite descSprite;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    String json = await rootBundle.loadString('assets/games/matchtextcolor/MatchTextColor.json');
    lstTextColorData = matchTextColorModelFromJson(json);

    // ignore: use_build_context_synchronously
    gameStep = GameStep(gameNumber: 6, gameName: '단어의 색-의미 분류', timeLimit: limitTime, gameDescIndex: 5, isKeyboardControl: true, isHalfTime: true);
    world.add(gameStep);

    backgroundSprite = await loadSprite('games/matchtextcolor/background.png');
    descSprite = await loadSprite('games/matchtextcolor/label.png');
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
  void initGame() {
    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 234, 236, 245),
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      anchor: Anchor.center
    );
    world.add(background);

    SpriteComponent leftBackground1 = SpriteComponent(
      sprite: backgroundSprite,
      position: Vector2(480, 420),
      size: Vector2(337, 337),
      anchor: Anchor.center
    );
    world.add(leftBackground1);

    ColorRectComponent leftBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2(480, 420),
      size: Vector2(298, 298),
      anchor: Anchor.center
    );
    world.add(leftBackground2);

    SpriteComponent rightBackground1 = SpriteComponent(
      sprite: backgroundSprite,
      position: Vector2(800, 420),
      size: Vector2(337, 337),
      anchor: Anchor.center
    );
    world.add(rightBackground1);

    ColorRectComponent rightBackground2 = ColorRectComponent(
      color: Colors.white,
      position: Vector2(800, 420),
      size: Vector2(298, 298),
      anchor: Anchor.center
    );
    world.add(rightBackground2);

    leftButton = AnswerButton(
      position: Vector2(230, 420), 
      isLeft: true,
    );
    world.add(leftButton);

    rightButton = AnswerButton(
      position: Vector2(1050, 420), 
      isLeft: false,
    );
    world.add(rightButton);

    SpriteComponent desc = SpriteComponent(
      sprite: descSprite,
      position: Vector2(640, 630),
      size: Vector2(445, 30),
      anchor: Anchor.center
    );
    world.add(desc);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    if( leftText != null ) world.remove(leftText!);
    if( rightText != null ) world.remove(rightText!);

    int leftIndex = Random().nextInt(lstTextColorData.length);
    isMatched = Random().nextInt(2) == 0;

    String strLeftText = lstTextColorData[leftIndex].colorName;
    //int leftColorIndex = Random().nextInt(lstTextColorData.length);

    //MatchTextColorModel leftColorModel = lstTextColorData[leftColorIndex];
    //Color leftColor = Color.fromARGB(255, int.parse(leftColorModel.red), int.parse(leftColorModel.green), int.parse(leftColorModel.blue));
    leftText = TextComponent(
      anchor: Anchor.center,
      text: strLeftText,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 50, color: Colors.black),//leftColor),
      ),
      position: Vector2(480, 420),
    );
    world.add(leftText!);

    String strRightText = lstTextColorData[Random().nextInt(lstTextColorData.length)].colorName;
    int rightColorIndex = 0;
    if( isMatched ){
      rightColorIndex = leftIndex;
    } else {
      while(true){
        rightColorIndex = Random().nextInt(lstTextColorData.length);
        if( rightColorIndex != leftIndex ) break;
      }
    }

    MatchTextColorModel rightColorModel = lstTextColorData[rightColorIndex];
    Color rightColor = Color.fromARGB(255, int.parse(rightColorModel.red), int.parse(rightColorModel.green), int.parse(rightColorModel.blue));
    rightText = TextComponent(
      anchor: Anchor.center,
      text: strRightText,
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 50, color: rightColor),
      ),
      position: Vector2(800, 420),
    );
    world.add(rightText!);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if( gameStep.step < 2 ) return KeyEventResult.ignored;
    final isKeyDown = event is KeyDownEvent;

    final isLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if( isKeyDown ) {
      if( isLeft ) {
        leftButton.onClick();
        return KeyEventResult.handled;
      } else if ( isRight ) {
        rightButton.onClick();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}