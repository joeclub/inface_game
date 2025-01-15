import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';

class MatchMouthLengthGame extends EduceGame with KeyboardEvents {
  final limitTime = 2 * 60;
  late GameStep gameStep;
  bool isGameEnd = false;

  int matchScore = 20;

  bool isMatched = false;
  bool isButtonTapped = false;

  late Sprite defaultMouthSprite;
  List<Sprite> lstMouthSprites = [];

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  SpriteComponent? face;
  late Sprite spriteInfo;

  MatchMouthLengthGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 12, gameName: '입 길이 판단하기', timeLimit: limitTime, gameDescIndex: 11, isKeyboardControl: true, isHalfTime: true);
    world.add(gameStep);

    spriteInfo = await loadSprite('games/matchmouthlength/Group 1880.png');

    defaultMouthSprite = await loadSprite('games/matchmouthlength/FACE1_0.png'); 
    lstMouthSprites.add(await loadSprite('games/matchmouthlength/FACE1_1.png'));
    lstMouthSprites.add(await loadSprite('games/matchmouthlength/FACE1_2.png'));
    lstMouthSprites.add(await loadSprite('games/matchmouthlength/FACE1_3.png'));
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
    isGameEnd = true;
    super.endGame();
  }

  @override
  void initGame(){
    SpriteComponent info = SpriteComponent(
      sprite: spriteInfo,
      position: Vector2(640, 650),
      size: Vector2(445, 30),
      anchor: Anchor.center,
    );
    info.paint.filterQuality = FilterQuality.high;
    world.add(info);

    leftButton = AnswerButton(
      position: Vector2(230, 400), 
      isLeft: true,
    );
    world.add(leftButton);

    rightButton = AnswerButton(
      position: Vector2(1050, 400), 
      isLeft: false,
    );
    world.add(rightButton);

    showButton(false);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    matchScore = isSecondHalf ? 30 : 20;

    if( face != null ){
      world.remove(face!);
    }
    showButton(false);

    isMatched = Random().nextInt(2) == 0;
    int length0 = Random().nextInt(lstMouthSprites.length);
    int length1 = 0;
    if( isMatched ){
      length1 = length0;
    } else {
      while(true){
        length1 = Random().nextInt(lstMouthSprites.length);
        if( length0 != length1){
          break;
        }
      }
    }

    face = SpriteComponent(
      sprite: defaultMouthSprite,
      position: Vector2(640, 400),
      size: Vector2.all(330),
      anchor: Anchor.center,
    );
    face!.paint.filterQuality = FilterQuality.high;
    world.add(face!);

    
    Future.delayed(const Duration(milliseconds: 500), (){
      face!.sprite = lstMouthSprites[length0];
      Future.delayed(const Duration(milliseconds: 500), (){
        face!.sprite = defaultMouthSprite;
        Future.delayed(const Duration(milliseconds: 500), (){
          face!.sprite = lstMouthSprites[length1];
          showButton(true);
        });
      });
    });
  }

  void showButton( isShow ){
    leftButton.isVisible = isShow;
    rightButton.isVisible = isShow;
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
        if( leftButton.isVisible ){
          leftButton.onClick();
        }
        
        return KeyEventResult.handled;
      } else if ( isRight ) {
        if( rightButton.isVisible ) {
          rightButton.onClick();
        }
        
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}