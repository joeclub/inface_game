import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'emitter.dart';

enum PatternCheckType
{
  shape,
  color,
  count,
}


class ComparePatternGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  
  late Emitter emitter;

  late PatternType lastType;
  late PatternColor lastColor;
  late int lastCount;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  late TextComponent questionText;

  bool isMatched = false;
  bool prevSame = false;

  late Sprite bgSprite;
  late Sprite guideSprite;

  List<Sprite> lstPatterns = [];

  ComparePatternGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    for( int i=0; i<PatternType.values.length; ++i){
      Sprite sprite = await loadSprite('games/comparepattern/${PatternType.values[i].name}.png');
      lstPatterns.add(sprite);
    }

    // ignore: use_build_context_synchronously
    gameStep = GameStep(gameNumber: 17, gameName: '패턴 비교하기', timeLimit: limitTime, gameDescIndex: 17, isKeyboardControl: true);
    world.add(gameStep);

    bgSprite = await loadSprite('games/selectshape/bg_gradation.png');
    guideSprite = await loadSprite('games/compareprevcard/txt_key.png');
    

    // Future.delayed(const Duration(seconds: 7), (){
    //   resetGame();
    // });
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
    SpriteComponent background = SpriteComponent(
      sprite: bgSprite,
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      anchor: Anchor.center
    );
    world.add(background);

    SpriteComponent guide = SpriteComponent(
      sprite: guideSprite,
      position: Vector2(640, 620),
      size: Vector2(446, 30),
      anchor: Anchor.center
    );
    guide.paint.filterQuality = FilterQuality.high;
    world.add(guide);

    leftButton = AnswerButton(
      position: Vector2(300, 420), 
      isLeft: true,
    );
    world.add(leftButton);
    leftButton.isVisible = false;

    rightButton = AnswerButton(
      position: Vector2(980, 420), 
      isLeft: false,
    );
    world.add(rightButton);
    rightButton.isVisible = false;

    questionText = TextComponent(
      anchor: Anchor.center,
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      position: Vector2(640, 220),
    );
    world.add(questionText);

    emitter = Emitter(
      position: Vector2(640, 420),
      lstPatterns: lstPatterns,
    );
    world.add(emitter);

    PatternType patternType = PatternType.values[Random().nextInt(PatternType.values.length)];
    PatternColor patternColor = PatternColor.values[Random().nextInt(PatternColor.values.length)];
    int patternCount = Random().nextInt(4) + 3;

    emitter.emit(patternType, patternColor, patternCount);
    lastType = patternType;
    lastColor = patternColor;
    lastCount = patternCount;
  }

  @override
  void resetGame() async {
    await Future.delayed(const Duration(seconds: 3), (){
    });

    resetGame2();
  }

  void resetGame2(){
    currRound++;
    gameStep.updateRound();

    leftButton.isVisible = true;
    rightButton.isVisible = true;
    prevSame = Random().nextInt(2) == 0;

    PatternCheckType patternChechType = PatternCheckType.values[Random().nextInt(PatternCheckType.values.length)];

    PatternType patternType = PatternType.circle;
    PatternColor patternColor = PatternColor.blue;
    int patternCount = 3;

    String typeText = '';
    String sameText = '';

    isMatched = Random().nextInt(2) == 0;

    if( prevSame ){
      if( isMatched ) { 
        sameText = Random().nextInt(2) == 0 ? '같습니다.' : '다르지 않습니다.';
      } else {
        sameText = Random().nextInt(2) == 0 ? '다릅니다.' : '같지 않습니다.';
      }
    } else {
      if( isMatched ) { 
        sameText = Random().nextInt(2) == 0 ? '다릅니다.' : '같지 않습니다.';
      } else {
        sameText = Random().nextInt(2) == 0 ? '같습니다.' : '다르지 않습니다.';
      }
    }

    switch(patternChechType){
      case PatternCheckType.shape:{
        typeText = "모양이";
        if( prevSame ){
          patternType = lastType; 
        } else {
          while(true){
            patternType = PatternType.values[Random().nextInt(PatternType.values.length)];
            if( patternType != lastType ){
              break;
            }
          }
        }
        patternColor = PatternColor.values[Random().nextInt(PatternColor.values.length)];
        patternCount = Random().nextInt(4) + 3;
      }
      break;
      case PatternCheckType.color:{
        typeText = "색상이";
        if( prevSame ){
          patternColor = lastColor; 
        } else {
          while(true){
            patternColor = PatternColor.values[Random().nextInt(PatternColor.values.length)];
            if( patternColor != lastColor ){
              break;
            }
          }
        }
        patternType = PatternType.values[Random().nextInt(PatternType.values.length)];
        patternCount = Random().nextInt(4) + 3;
      }
      break;
      case PatternCheckType.count:{
        typeText = "개수가";
        if( prevSame ){
          patternCount = lastCount; 
        } else {
          while(true){
            patternCount = Random().nextInt(4) + 3;
            if( patternCount != lastCount ){
              break;
            }
          }
        }
        patternType = PatternType.values[Random().nextInt(PatternType.values.length)];
        patternColor = PatternColor.values[Random().nextInt(PatternColor.values.length)];
      }
      break;
    }

    emitter.emit(patternType, patternColor, patternCount);
    lastType = patternType;
    lastColor = patternColor;
    lastCount = patternCount;

    questionText.text = "이전 패턴과 $typeText $sameText";
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