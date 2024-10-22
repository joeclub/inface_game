import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer.dart';
import 'compare_component.dart';
import 'figure.dart';
import 'question_mark.dart';
import 'submit_button.dart';
import 'transform_component.dart';

class CompareFigureGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  List<Sprite> lstRects = [];
  List<Sprite> lstCircles = [];

  late Sprite operatorSprite0;
  late Sprite operatorSprite1;

  late Sprite figureBackgroundSprite;
  late Sprite arrowSprite;

  late ColorRectComponent background3;
  PositionComponent? gameParent;

  int inputFigureIndex = -1;
  bool inputIsCircle = false;

  int outputFigureIndex = -1;
  bool outputIsCircle = false;

  int compareFigureIndex = -1;
  bool compareIsCircle = false;

  bool isSecondHalfQuestion = false;

  List<bool> lstTransforms0 = [];
  List<bool> lstTransforms1 = [];
  List<bool> lstCompare = [];

  List<bool> lstChecked = [];
  List<Answer> lstAnswers = [];
  
  CompareFigureGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 1, gameName: '도형 비교', timeLimit: limitTime, isCat: true, gameDescIndex: 24);
    world.add(gameStep);

    Sprite rect0 = await loadSprite('games/comparefigure/shape_A.png');
    Sprite rect1 = await loadSprite('games/comparefigure/shape_B.png');
    Sprite rect2 = await loadSprite('games/comparefigure/shape_C.png');
    Sprite rect3 = await loadSprite('games/comparefigure/shape_D.png');
    lstRects.add(rect0);
    lstRects.add(rect1);
    lstRects.add(rect2);
    lstRects.add(rect3);

    Sprite circle0 = await loadSprite('games/comparefigure/shape_AB.png');
    Sprite circle1 = await loadSprite('games/comparefigure/shape_AC.png');
    Sprite circle2 = await loadSprite('games/comparefigure/shape_AD.png');
    Sprite circle3 = await loadSprite('games/comparefigure/shape_BC.png');
    lstCircles.add(circle0);
    lstCircles.add(circle1);
    lstCircles.add(circle2);
    lstCircles.add(circle3);

    operatorSprite0 = await loadSprite('games/comparefigure/shape_default.png');
    operatorSprite1 = await loadSprite('games/comparefigure/compare_default.png');

    figureBackgroundSprite = await loadSprite('games/comparefigure/Rectangle.png');
    arrowSprite = await loadSprite('games/comparefigure/arrow_right.png');

    //guideSprite = await loadSprite('games/compareprevcard/txt_key.png');
    

    // Future.delayed(const Duration(seconds: 7), (){
    //   resetGame();
    // });

    //initGame();
    //resetGame();
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
      anchor: Anchor.center,
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      color: const Color.fromARGB(255, 193, 196, 208),
    );
    world.add(background);

    ColorRectComponent background2 = ColorRectComponent(
      anchor: Anchor.center,
      position: background.size * 0.5,
      size: Vector2(1006, 540),
      color: Colors.white,
    );
    background.add(background2);

    background3 = ColorRectComponent(
      anchor: Anchor.center,
      position: background.size * 0.5 + Vector2(0, -210),
      size: Vector2(1006, 120),
      color: const Color.fromARGB(255, 247, 247, 247),
    );
    background.add(background3);
    
    initGuide(background3);
  }

  @override
  void resetGame() async {
    currRound++;
    gameStep.updateRound();

    isSecondHalfQuestion = isSecondHalf;

    

    lstChecked.clear();
    for( int i=0; i<4; ++i){
      lstChecked.add(false);
    }

    lstAnswers.clear();

    if( gameParent != null ){
      background3.remove(gameParent!);
    }

    gameParent = PositionComponent(
      position: background3.size * 0.5 + Vector2(-640, -100),

    );

    background3.add(gameParent!);

    inputFigureIndex = Random().nextInt(4);
    inputIsCircle = Random().nextInt(2) == 1;

    if( isSecondHalf ) {      
      while(true){
        outputFigureIndex = inputFigureIndex;
        outputIsCircle = inputIsCircle;
        if(resetCompare()){
          break;
        }
      }
    } else {
      outputFigureIndex = inputFigureIndex;
      outputIsCircle = inputIsCircle;
      setTransform();

      if( lstTransforms0[0] ){
        outputFigureIndex = outputFigureIndex > 1 ? outputFigureIndex - 2 : outputFigureIndex + 2;
      }

      if( lstTransforms0[1] ){
        outputIsCircle = !outputIsCircle;
      }

      if( lstTransforms0[2] ){
        outputFigureIndex = ( outputFigureIndex % 2 ) == 1 ? outputFigureIndex - 1 : outputFigureIndex + 1;
      }

      if( lstTransforms1[0] ){
        outputFigureIndex = outputFigureIndex > 1 ? outputFigureIndex - 2 : outputFigureIndex + 2;
      }

      if( lstTransforms1[1] ){
        outputIsCircle = !outputIsCircle;
      }

      if( lstTransforms1[2] ){
        outputFigureIndex = ( outputFigureIndex % 2 ) == 1 ? outputFigureIndex - 1 : outputFigureIndex + 1;
      }
    }

    if( isSecondHalf ) {
      SpriteComponent figureBackground = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(320, 400),
        size: Vector2.all(118),
        sprite: figureBackgroundSprite,
      );

      gameParent!.add(figureBackground);

      Figure figure = Figure(
        position: figureBackground.size * 0.5 + Vector2(0, -5),
        figureIndex: inputFigureIndex,
        isCircle: inputIsCircle,
      );
      figureBackground.add(figure);

      SpriteComponent arrow0 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(420, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow0);

      TransformComponent transform0 = TransformComponent(
        position: Vector2(500, 400),
        lstTransforms: lstTransforms0,
      );

      gameParent!.add(transform0);

      SpriteComponent arrow1 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(580, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow1);

      TransformComponent transform1 = TransformComponent(
        position: Vector2(660, 400),
        lstTransforms: lstTransforms1,
      );

      gameParent!.add(transform1);

      SpriteComponent arrow3 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(740, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow3);

      CompareComponent compare0 = CompareComponent(
        position: Vector2(820, 400),
        lstTransforms: lstCompare,
      );

      gameParent!.add(compare0);

      SpriteComponent arrow4 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(900, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow4);

      TextComponent textYes = TextComponent(
        anchor: Anchor.center,
        text: 'YES',
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 15, color: Colors.red),
        ),
        position: Vector2( 900, 380 ),
      );
      gameParent!.add(textYes);

      TextComponent textNo = TextComponent(
        anchor: Anchor.centerLeft,
        text: 'NO',
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 133, 58, 253)),
        ),
        position: Vector2( 830, 470 ),
      );
      gameParent!.add(textNo);

      ColorRectComponent line0 = ColorRectComponent(
        anchor: Anchor.center,
        color: const Color.fromARGB(255, 180, 181, 188),
        position: Vector2(820, 470),
        size: Vector2(2, 16),
      );
      gameParent!.add(line0);

      ColorRectComponent line1 = ColorRectComponent(
        anchor: Anchor.centerRight,
        color: const Color.fromARGB(255, 180, 181, 188),
        position: Vector2(820, 478),
        size: Vector2(400, 2),
      );
      gameParent!.add(line1);

      SpriteComponent arrowNo = SpriteComponent(
        anchor: Anchor.bottomCenter,
        position: Vector2(423, 467),
        size: Vector2(23, 6),
        sprite: arrowSprite,
        angle: -pi * 0.5,
      );
      gameParent!.add(arrowNo);

      SpriteComponent figureBackground2 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(820, 270),
        size: Vector2.all(118),
        sprite: figureBackgroundSprite,
      );

      gameParent!.add(figureBackground2);

      SpriteComponent compareSpriteComponent = SpriteComponent(
        anchor: Anchor.center,
        position: figureBackground2.size * 0.5,
        size: compareFigureIndex > 1 ? Vector2(35, 35) : Vector2(60, 60),
        sprite: compareIsCircle ? lstCircles[compareFigureIndex] : lstRects[compareFigureIndex],
      );

      figureBackground2.add(compareSpriteComponent);

      QuestionMark questionMark = QuestionMark(
        position: Vector2(980, 400),
      );

      gameParent!.add(questionMark);

    } else {
      SpriteComponent figureBackground = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(400, 400),
        size: Vector2.all(118),
        sprite: figureBackgroundSprite,
      );

      gameParent!.add(figureBackground);

      Figure figure = Figure(
        position: figureBackground.size * 0.5 + Vector2(0, -5),
        figureIndex: inputFigureIndex,
        isCircle: inputIsCircle,
      );
      figureBackground.add(figure);

      SpriteComponent arrow0 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(500, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow0);

      TransformComponent transform0 = TransformComponent(
        position: Vector2(580, 400),
        lstTransforms: lstTransforms0,
      );

      gameParent!.add(transform0);

      SpriteComponent arrow1 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(660, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow1);

      TransformComponent transform1 = TransformComponent(
        position: Vector2(740, 400),
        lstTransforms: lstTransforms1,
      );

      gameParent!.add(transform1);

      SpriteComponent arrow3 = SpriteComponent(
        anchor: Anchor.center,
        position: Vector2(820, 400),
        size: Vector2(21, 11),
        sprite: arrowSprite,
      );
      
      gameParent!.add(arrow3);

      QuestionMark questionMark = QuestionMark(
        position: Vector2(900, 400),
      );

      gameParent!.add(questionMark);
    }

    

    Answer answer0 = Answer(
      position: Vector2(420, 500),
      number: 1,
    );
    gameParent!.add(answer0);
    lstAnswers.add(answer0);

    Answer answer1 = Answer(
      position: Vector2(520, 500),
      number: 2,
    );
    gameParent!.add(answer1);
    lstAnswers.add(answer1);

    Answer answer2 = Answer(
      position: Vector2(620, 500),
      number: 3,
    );
    gameParent!.add(answer2);
    lstAnswers.add(answer2);

    Answer answer3 = Answer(
      position: Vector2(720, 500),
      number: 4,
    );
    gameParent!.add(answer3);
    lstAnswers.add(answer3);

    SubmitButton submitButton = SubmitButton(
      position: Vector2(1020, 515),
    );
    gameParent!.add(submitButton);
  }

  void check(int index){
    if( lstChecked[index] == false ){
      int checkCount = 0;
      for( int i=0; i<lstChecked.length; ++i){
        if( lstChecked[i] == true ){
          checkCount++;
        }
      }
      if( checkCount > 1 ) return;
    }

    lstChecked[index] = !lstChecked[index];
    lstAnswers[index].onOff(lstChecked[index]);
  }

  void submit(){
    int checkCount = 0;
    List<int> lstCheckedIndices = [];
    for( int i=0; i<lstChecked.length; ++i){
      if( lstChecked[i] == true ){
        lstCheckedIndices.add(i);
        checkCount++;
      }
    }

    if( checkCount == 0 ) {
      return;
    } else if( checkCount == 1 ) {
      if( lstCheckedIndices[0] == outputFigureIndex && outputIsCircle == false ){
        if( isSecondHalfQuestion ){
          currScore += 200;
        } else {
          currScore += 100;
        }
        gameStep.updateScore(currScore);
      }
    } else {

      int selectedIndex = -1;
      if( lstCheckedIndices[0] == 0 && lstCheckedIndices[1] == 1 ){
        selectedIndex = 0;
      }

      if( lstCheckedIndices[0] == 0 && lstCheckedIndices[1] == 2 ){
        selectedIndex = 1;
      }

      if( lstCheckedIndices[0] == 0 && lstCheckedIndices[1] == 3 ){
        selectedIndex = 2;
      }

      if( lstCheckedIndices[0] == 1 && lstCheckedIndices[1] == 2 ){
        selectedIndex = 3;
      }

      if( selectedIndex == outputFigureIndex && outputIsCircle == true ){
        if( isSecondHalfQuestion ){
          currScore += 200;
        } else {
          currScore += 100;
        }
        gameStep.updateScore(currScore);
      }
    }
    resetGame();
  }

  void setTransform(){
    lstTransforms0.clear();
    lstTransforms1.clear();
    while(true){
      for( int i=0; i<3; ++i) {
        lstTransforms0.add(Random().nextInt(2) == 1);
      }
      if( lstTransforms0[0] == false && lstTransforms0[1] == false && lstTransforms0[2] == false ){
        lstTransforms0.clear();
      } else {
        break;
      }
    }

    while(true){
      for( int i=0; i<3; ++i) {
        lstTransforms1.add(Random().nextInt(2) == 1);
      }
      if( lstTransforms1[0] == false && lstTransforms1[1] == false && lstTransforms1[2] == false ){
        lstTransforms1.clear();
      } else {
        break;
      }
    }
  }

  bool resetCompare(){
    setTransform();

    compareFigureIndex = Random().nextInt(4);
    compareIsCircle = Random().nextInt(2) == 1;

    lstCompare.clear();
    while(true){
      for( int i=0; i<3; ++i) {
        lstCompare.add(Random().nextInt(2) == 1);
      }
      if( lstCompare[0] == false && lstCompare[1] == false && lstCompare[2] == false ){
        lstCompare.clear();
      } else {
        break;
      }
    }

    bool pass = false;
    for( int i=0; i<5; ++i){
      if( lstTransforms0[0] ){
        outputFigureIndex = outputFigureIndex > 1 ? outputFigureIndex - 2 : outputFigureIndex + 2;
      }

      if( lstTransforms0[1] ){
        outputIsCircle = !outputIsCircle;
      }

      if( lstTransforms0[2] ){
        outputFigureIndex = ( outputFigureIndex % 2 ) == 1 ? outputFigureIndex - 1 : outputFigureIndex + 1;
      }

      if( lstTransforms1[0] ){
        outputFigureIndex = outputFigureIndex > 1 ? outputFigureIndex - 2 : outputFigureIndex + 2;
      }

      if( lstTransforms1[1] ){
        outputIsCircle = !outputIsCircle;
      }

      if( lstTransforms1[2] ){
        outputFigureIndex = ( outputFigureIndex % 2 ) == 1 ? outputFigureIndex - 1 : outputFigureIndex + 1;
      }

      if( lstCompare[0] ){
        bool compare0 = outputFigureIndex > 1;
        bool compare1 = compareFigureIndex > 1;
        if( compare0 != compare1 ) continue;
      }

      if( lstCompare[1] ){
        if( outputIsCircle != compareIsCircle ) continue;
      }

      if( lstCompare[2] ){
        bool compare0 = ( outputFigureIndex % 2 ) == 1;
        bool compare1 = ( compareFigureIndex % 2 ) == 1;
        if( compare0 != compare1 ) continue;
      }
      pass = true;
      break;
    }
    return pass;
  }

  void initGuide(ColorRectComponent parentBackground) {
    SpriteComponent a = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 50, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(55),
      sprite: lstRects[0],
    );
    parentBackground.add(a);

    TextComponent textA = TextComponent(
      anchor: Anchor.center,
      text: 'A',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 50, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textA);

    SpriteComponent b = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 130, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(55),
      sprite: lstRects[1],
    );
    parentBackground.add(b);

    TextComponent textB = TextComponent(
      anchor: Anchor.center,
      text: 'B',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 130, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textB);

    SpriteComponent c = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 210, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(30),
      sprite: lstRects[2],
    );
    parentBackground.add(c);

    TextComponent textC = TextComponent(
      anchor: Anchor.center,
      text: 'C',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 210, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textC);

    SpriteComponent d = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 290, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(30),
      sprite: lstRects[3],
    );
    parentBackground.add(d);

    TextComponent textD = TextComponent(
      anchor: Anchor.center,
      text: 'D',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 290, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textD);

    ColorRectComponent separator0 = ColorRectComponent(
      anchor: Anchor.center,
      position: parentBackground.size * 0.5 + Vector2(-174, 0),
      size: Vector2(2, 72),
      color: const Color.fromARGB(255, 226, 226, 226),
    );
    parentBackground.add(separator0);

    SpriteComponent ab = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 380, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(55),
      sprite: lstCircles[0],
    );
    parentBackground.add(ab);

    TextComponent textAB = TextComponent(
      anchor: Anchor.center,
      text: 'AB',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 380, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textAB);

    SpriteComponent ac = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 460, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(55),
      sprite: lstCircles[1],
    );
    parentBackground.add(ac);

    TextComponent textAC = TextComponent(
      anchor: Anchor.center,
      text: 'AC',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 460, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textAC);

    SpriteComponent ad = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 540, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(30),
      sprite: lstCircles[2],
    );
    parentBackground.add(ad);

    TextComponent textAD = TextComponent(
      anchor: Anchor.center,
      text: 'AD',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 540, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textAD);

    SpriteComponent bc = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 620, parentBackground.size.y * 0.5 -10 ),
      size: Vector2.all(30),
      sprite: lstCircles[3],
    );
    parentBackground.add(bc);

    TextComponent textBC = TextComponent(
      anchor: Anchor.center,
      text: 'BC',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 620, parentBackground.size.y * 0.5 + 35 ),
    );
    parentBackground.add(textBC);

    ColorRectComponent separator1 = ColorRectComponent(
      anchor: Anchor.center,
      position: parentBackground.size * 0.5 + Vector2(176, 0),
      size: Vector2(2, 72),
      color: const Color.fromARGB(255, 226, 226, 226),
    );
    parentBackground.add(separator1);

    TextComponent textTransform = TextComponent(
      anchor: Anchor.center,
      text: '변환',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 720, parentBackground.size.y * 0.5 ),
    );
    parentBackground.add(textTransform);

    SpriteComponent operator0 = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 785, parentBackground.size.y * 0.5 ),
      size: Vector2(70, 78),
      sprite: operatorSprite0,
    );
    parentBackground.add(operator0);

    TextComponent textTransform0 = TextComponent(
      anchor: Anchor.center,
      text: '크기',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: operator0.size * 0.5 + Vector2( 0, -25 ),
    );
    operator0.add(textTransform0);

    TextComponent textTransform1 = TextComponent(
      anchor: Anchor.center,
      text: '모양',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: operator0.size * 0.5 + Vector2( 0, 0 ),
    );
    operator0.add(textTransform1);

    TextComponent textTransform2 = TextComponent(
      anchor: Anchor.center,
      text: '색깔',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: operator0.size * 0.5 + Vector2( 0, 25 ),
    );
    operator0.add(textTransform2);

    ColorRectComponent separator2 = ColorRectComponent(
      anchor: Anchor.center,
      position: parentBackground.size * 0.5 + Vector2(350, 0),
      size: Vector2(2, 72),
      color: const Color.fromARGB(255, 226, 226, 226),
    );
    parentBackground.add(separator2);

    TextComponent textCompare = TextComponent(
      anchor: Anchor.center,
      text: '비교',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 17, color: Colors.black),
      ),
      position: Vector2( 890, parentBackground.size.y * 0.5 ),
    );
    parentBackground.add(textCompare);

    SpriteComponent operator1 = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2( 955, parentBackground.size.y * 0.5 ),
      size: Vector2(75, 80),
      sprite: operatorSprite1,
    );
    parentBackground.add(operator1);

    TextComponent textTransform10 = TextComponent(
      anchor: Anchor.center,
      text: '크기',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
      position: operator1.size * 0.5 + Vector2( 0, -20 ),
    );
    operator1.add(textTransform10);

    TextComponent textTransform11 = TextComponent(
      anchor: Anchor.center,
      text: '모양',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
      position: operator1.size * 0.5 + Vector2( 0, 0 ),
    );
    operator1.add(textTransform11);

    TextComponent textTransform12 = TextComponent(
      anchor: Anchor.center,
      text: '색깔',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 13, color: Colors.black),
      ),
      position: operator1.size * 0.5 + Vector2( 0, 20 ),
    );
    operator1.add(textTransform12);
  }
}