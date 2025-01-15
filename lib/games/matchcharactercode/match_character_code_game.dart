import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';

class MatchCharacterCodeGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isGameEnd = false;

  int matchScore = 20;

  bool isMatched = false;

  List<String> lstConsonants = [ "ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ" ];
  List<String> lstVowels = [ "ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ" ];

  late Sprite firstHalfBackground;
  late Sprite secondHalfBackground;

  SpriteComponent? background;

  late Sprite spriteInfo;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  MatchCharacterCodeGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 11, gameName: '문자 코드 분류하기', timeLimit: limitTime, gameDescIndex: 10, isKeyboardControl: true);
    world.add(gameStep);

    firstHalfBackground = await loadSprite('games/matchcharactercode/herf_1.png');
    secondHalfBackground = await loadSprite('games/matchcharactercode/herf_2.png');

    spriteInfo = await loadSprite('games/matchcharactercode/Group 1881.png');
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
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    if( background != null ){
      world.remove(background!);
    }

    bool isNumber = Random().nextInt(2) == 0;
    int odd = Random().nextInt(2);
    bool isVowel = Random().nextInt(2) == 0;

    int number = Random().nextInt(9) + 1;
    String text = '';
    if( isVowel ){
      text = lstVowels[Random().nextInt(lstVowels.length)];
    } else {
      text = lstConsonants[Random().nextInt(lstConsonants.length)];
    }

    if( isNumber ){
      isMatched = (number % 2) == odd;
    } else {
      isMatched = Random().nextInt(2) == 0;
    }

    if( isSecondHalf ){
      matchScore = 50;
      background = SpriteComponent(
        sprite: secondHalfBackground,
        position: Vector2(640, 400),
        size: Vector2(320, 367),
        anchor: Anchor.center,
      );
      world.add(background!);

      Vector2 posOffset = Vector2.zero();

      if( isNumber ){
        if( isMatched ){
          if( (number % 2) == 1 ){
            posOffset += Vector2(-70, 0);
          } else {
            posOffset += Vector2(70, 0);
          }
        } else {
          if( (number % 2) == 1 ){
            posOffset += Vector2(70, 0);
          } else {
            posOffset += Vector2(-70, 0);
          }
        }
      } else {
        if( isMatched ){
          if( isVowel ){
            posOffset += Vector2(-70, 0);
          } else {
            posOffset += Vector2(70, 0);
          }
        } else {
          if( isVowel ){
            posOffset += Vector2(70, 0);
          } else {
            posOffset += Vector2(-70, 0);
          }
        }
      }

      background!.add(
        TextComponent(
          text: number.toString(),
          anchor: Anchor.centerRight,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 50, color: Colors.black),
          ),
          position: background!.size * 0.5 + Vector2(0, isNumber ? -70 : 70) + posOffset,
        ),
      );

      background!.add(
        TextComponent(
          text: text,
          anchor: Anchor.centerLeft,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 50, color: Colors.black),
          ),
          position: background!.size * 0.5 + Vector2(0, isNumber ? -70 : 70) + posOffset,
        ),
      );

      background!.add(
        TextComponent(
          text: '홀수',
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, -180) + Vector2( -70, 0),
        ),
      );

      background!.add(
        TextComponent(
          text: '짝수',
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, -180) + Vector2( 70, 0),
        ),
      );

      background!.add(
        TextComponent(
          text: '모음',
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, 180) + Vector2( -70, 0),
        ),
      );

      background!.add(
        TextComponent(
          text: '자음',
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, 180) + Vector2( 70, 0),
        ),
      );


    } else {
      matchScore = 20;
      background = SpriteComponent(
        sprite: firstHalfBackground,
        position: Vector2(640, 400),
        size: Vector2(160, 367),
        anchor: Anchor.center,
      );
      world.add(background!);

      background!.add(
        TextComponent(
          text: number.toString(),
          anchor: Anchor.centerRight,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 50, color: Colors.black),
          ),
          position: background!.size * 0.5 + Vector2(0, isNumber ? -70 : 70),
        ),
      );

      background!.add(
        TextComponent(
          text: text,
          anchor: Anchor.centerLeft,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 50, color: Colors.black),
          ),
          position: background!.size * 0.5 + Vector2(0, isNumber ? -70 : 70),
        ),
      );

      background!.add(
        TextComponent(
          text: ( odd == 0 ) ? '짝수' : '홀수',
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, -180),
        ),
      );

      String text2;
      if( isMatched ){
        text2 = isVowel ? '모음' : '자음';
      } else {
        text2 = isVowel ? '자음' : '모음';
      }
      background!.add(
        TextComponent(
          text: text2,
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 115, 117, 126)),
          ),
          position: background!.size * 0.5 + Vector2(0, 180),
        ),
      );

    }
    
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