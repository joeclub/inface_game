import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inface/games/components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';

class ComparePictureGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  late Sprite guide;
  bool isMatched = false;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  late ColorRectComponent background1;

  SpriteComponent? leftPicture;
  SpriteComponent? rightPicture;
  
  ComparePictureGame({required super.context});
  
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // ignore: use_build_context_synchronously
    gameStep = GameStep(gameNumber: 1, gameName: '그림 비교', isCat: true, timeLimit: limitTime, context: context, gameDescIndex: 22, isKeyboardControl: true);
    world.add(gameStep);

    guide = await loadSprite('games/comparepicture/Group.png');
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
  void initGame(){
    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      anchor: Anchor.center
    );
    world.add(background);

    background1 = ColorRectComponent(
      color: const Color.fromARGB(255, 234, 236, 245),
      position: background.size * 0.5,
      size: Vector2(1008, 542),
      anchor: Anchor.center
    );
    background.add(background1);

    SpriteComponent spriteComponent = SpriteComponent(
      sprite: guide,
      position: background1.size * 0.5 + Vector2( 0, 200),
      size: Vector2(445, 30),
      anchor: Anchor.center,
    );

    background1.add(spriteComponent);

    leftButton = AnswerButton(
      position: background1.size * 0.5 + Vector2(-400, 0), 
      isLeft: true,
    );
    background1.add(leftButton);
    leftButton.isVisible = false;

    rightButton = AnswerButton(
      position: background1.size * 0.5 + Vector2(400, 0), 
      isLeft: false,
    );
    background1.add(rightButton);
    rightButton.isVisible = false;

    SpriteComponent guideComponent = SpriteComponent(
      sprite: guide,
      position: background1.size * 0.5 + Vector2( 0, 200),
      size: Vector2(445, 30),
      anchor: Anchor.center,
    );

    background1.add(guideComponent);
  }

  @override
  void resetGame() async {
    currRound++;
    gameStep.updateRound();
    
    leftButton.isVisible = true;
    rightButton.isVisible = true;

    if( leftPicture != null ){
      background1.remove(leftPicture!);
    }

    if( rightPicture != null ){
      background1.remove(rightPicture!);
    }

    isMatched = Random().nextInt(2) == 0;
    int spriteIndex = Random().nextInt(200) + 1;

    String spriteName = '$spriteIndex${isMatched ? '' : '-1'}';
    Sprite leftSprite = await loadSprite('games/comparepicture/$spriteIndex.png');
    Sprite rightSprite = await loadSprite('games/comparepicture/$spriteName.png');

    leftPicture = SpriteComponent(
      sprite: leftSprite,
      position: background1.size * 0.5 + Vector2( -170, 0),
      size: Vector2(300, 250),
      anchor: Anchor.center,
    );

    background1.add(leftPicture!);

    rightPicture = SpriteComponent(
      sprite: rightSprite,
      position: background1.size * 0.5 + Vector2( 170, 0),
      size: Vector2(300, 250),
      anchor: Anchor.center,
    );

    background1.add(rightPicture!);

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