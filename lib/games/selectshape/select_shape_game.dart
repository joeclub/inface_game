import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'game_card.dart';

enum ShapeType{
  // ignore: constant_identifier_names
  shape_cir_bl,
  // ignore: constant_identifier_names
  shape_cir_gr,
  // ignore: constant_identifier_names
  shape_cir_re,
  // ignore: constant_identifier_names
  shape_cir_yl,
  // ignore: constant_identifier_names
  shape_sqr_bl,
  // ignore: constant_identifier_names
  shape_sqr_gr,
  // ignore: constant_identifier_names
  shape_sqr_re,
  // ignore: constant_identifier_names
  shape_sqr_yl,
  // ignore: constant_identifier_names
  shape_str_bl,
  // ignore: constant_identifier_names
  shape_str_gr,
  // ignore: constant_identifier_names
  shape_str_re,
  // ignore: constant_identifier_names
  shape_str_yl,
  // ignore: constant_identifier_names
  shape_tri_bl,
  // ignore: constant_identifier_names
  shape_tri_gr,
  // ignore: constant_identifier_names
  shape_tri_re,
  // ignore: constant_identifier_names
  shape_tri_yl,
}

class SelectShapeGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;

  bool isMatched = false;

  late ClipComponent clipComponent;
  late TextComponent conditionTitleText;
  late TextComponent conditionText1;
  late TextComponent conditionText2;
  late TextComponent separatorText;
  late SpriteComponent conditionBackground;

  late Sprite bgSprite;
  late Sprite conditionBackgroundSprite;

  Timer? timer;
  int cardCount = 0;

  SelectShapeGame({required super.hasFirstHalfScore, required super.hasRoundScore, required super.isEP});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 16, gameName: '도형 고르기', timeLimit: limitTime, gameDescIndex: 16 );
    world.add(gameStep);

    bgSprite = await loadSprite('games/selectshape/bg_gradation.png');
    
    conditionBackgroundSprite = await loadSprite('games/selectshape/Rectangle 3192.png');

  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameStep.limitTimer.current > gameStep.halfTime) {
      isSecondHalf = true;
    }
    if (gameStep.limitTimer.finished) {
      endGame();
    } else {
      if( timer != null ){
        timer!.update(dt);
      }
    }
  }

  @override
  void endGame() {
    super.endGame();
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

    clipComponent = ClipComponent.rectangle(
      position: Vector2.zero(),
      size: background.size,
    );
    background.add(clipComponent);

    conditionBackground = SpriteComponent(
      sprite: conditionBackgroundSprite,
      position: Vector2(640, 650),
      size: Vector2(560, 60),
      anchor: Anchor.center
    );
    world.add(conditionBackground);

    conditionTitleText = TextComponent(
      anchor: Anchor.center,
      text: '조건',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 97, 229, 247)),
      ),
      position: Vector2(100, 30),
    );
    //conditionBackground.add(conditionTitleText);

    separatorText = TextComponent(
      anchor: Anchor.center,
      text: '|',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 97, 229, 247)),
      ),
      position: Vector2(300, 30),
    );
    //conditionBackground.add(separatorText);

    conditionText1 = TextComponent(
      anchor: Anchor.center,
      text: '세모 모양',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      position: Vector2(200, 30),
    );
    //conditionBackground.add(conditionText1);

    conditionText2 = TextComponent(
      anchor: Anchor.center,
      text: '빨강도형',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      position: Vector2(400, 30),
    );

    //conditionBackground.add(conditionText2);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    
    if( conditionBackground.children.contains(conditionTitleText)){
      conditionBackground.remove(conditionTitleText);
    }
    if( conditionBackground.children.contains(separatorText)){
      conditionBackground.remove(separatorText);
    }
    if( conditionBackground.children.contains(conditionText1)){
      conditionBackground.remove(conditionText1);
    }
    if( conditionBackground.children.contains(conditionText2)){
      conditionBackground.remove(conditionText2);
    }

    bool isTwoConditions = Random().nextInt(2) == 0;
    int shapeIndex = Random().nextInt(ShapeType.values.length);
    
    if( isTwoConditions ){
      conditionBackground.add(conditionTitleText);
      conditionBackground.add(separatorText);
      conditionBackground.add(conditionText1);
      conditionText1.position = Vector2(200, 30);
      conditionBackground.add(conditionText2);

      conditionText1.text = getShapeName(shapeIndex);
      conditionText2.text = getColorName(shapeIndex);
    } else {
      conditionBackground.add(conditionTitleText);
      conditionBackground.add(conditionText1);
      conditionText1.position = separatorText.position;
      conditionText1.text = getShapeName(shapeIndex);
    }

    timer = Timer(
      1.5,
      onTick: (){
        if( cardCount == 7 ){
          timer = null;
          Future.delayed(const Duration(seconds: 5), (){   
            cardCount = 0;
            resetGame();
          });
        } else{
          createCard(isTwoConditions, shapeIndex);
          cardCount++;
        }
      },
      repeat: true,
    );
  }

  void createCard(bool isTwoConditions, int shapeIndex){
    for( int i=0; i<3; ++i){
      double startPos = 325;
      int cardShapeIndex = 0;
      bool isCorrect = Random().nextInt(5) == 0;
      if( isTwoConditions ){
        if( isCorrect ) {
          cardShapeIndex = shapeIndex;
        } else {
          while( true ){
            cardShapeIndex = Random().nextInt(ShapeType.values.length);
            if( cardShapeIndex != shapeIndex ){
              break;
            }
          }
        }
      } else {
        if( isCorrect ) {
          int startIndex = (shapeIndex ~/ 4) * 4;
          cardShapeIndex = startIndex + Random().nextInt(4);
        } else {
          int startIndex1 = (shapeIndex ~/ 4);
          int startIndex2 = 0;
          while( true ){
            startIndex2 = Random().nextInt(4);
            if( startIndex1 != startIndex2 ) {
              break;
            }
          }

          int startIndex = startIndex2 * 4;
          cardShapeIndex = startIndex + Random().nextInt(4);
        }
      }

      GameCard card = GameCard(
        position: Vector2(startPos + i * 180, -100),
        shapeIndex: cardShapeIndex,
        isCorrect: isCorrect,
        parentClip: clipComponent,
      );
      clipComponent.add(card);
    }
  }

  String getShapeName(int shapeIndex){
    int index = shapeIndex ~/ 4;
    switch(index){
      case 0: return '동그라미 모양';
      case 1: return '네모 모양';
      case 2: return '별 모양';
      case 3: return '세모 모양';
    }
    return '';
  }

  String getColorName(int shapeIndex){
    int index = shapeIndex % 4;
    switch(index){
      case 0: return '파랑 도형';
      case 1: return '초록 도형';
      case 2: return '빨강 도형';
      case 3: return '노랑 도형';
    }
    return '';
  }
}