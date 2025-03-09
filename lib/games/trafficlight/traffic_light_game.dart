import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer.dart';
import 'question.dart';
import 'submit_button.dart';
import 'traffic_light.dart';

class TrafficLightGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;

  TrafficLightGame();

  List<Sprite> lstContidions = [];
  List<Vector2> lstConditionSizes = [];

  List<String> lstApplyText = [];
  List<String> lstNotApplyText = [];

  List<int> lstApplyLights = [];

  List<Answer> lstAnswers = [];
  List<bool> lstCheck = [];

  Question? question;

  bool isSecondHalfQuestion = false;

  int firstHalfScore = 0;
  int secondHalfScore = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 3, gameName: '신호등', isCat: true, timeLimit: limitTime, gameDescIndex: 21);
    world.add(gameStep);

    Sprite sprite0 = await loadSprite('games/trafficlight/answer_dir1.png');
    Sprite sprite1 = await loadSprite('games/trafficlight/answer_dir2.png');
    Sprite sprite2 = await loadSprite('games/trafficlight/answer_dir3.png');
    Sprite sprite3 = await loadSprite('games/trafficlight/answer_dir4.png');
    Sprite sprite4 = await loadSprite('games/trafficlight/condi_2.png');
    Sprite sprite5 = await loadSprite('games/trafficlight/condi_1.png');
    lstContidions.add(sprite0);
    lstContidions.add(sprite1);
    lstContidions.add(sprite2);
    lstContidions.add(sprite3);
    lstContidions.add(sprite4);
    lstContidions.add(sprite5);

    lstConditionSizes.add(Vector2(30, 60));
    lstConditionSizes.add(Vector2(30, 60));
    lstConditionSizes.add(Vector2(30, 60));
    lstConditionSizes.add(Vector2(30, 60));
    lstConditionSizes.add(Vector2(60, 30));
    lstConditionSizes.add(Vector2(60, 60));

    lstApplyText.add('초록, 파랑 통과');
    lstApplyText.add('빨강, 주황 통과');
    lstApplyText.add('주황, 초록 통과');
    lstApplyText.add('빨강, 파랑 통과');
    lstApplyText.add('모두 통과');
    lstApplyText.add(' 중복된 색은 통과 못 함,\n중복되지 않은 색만 통과.');

    lstApplyLights.add(12);
    lstApplyLights.add(3);
    lstApplyLights.add(6);
    lstApplyLights.add(9);

    lstNotApplyText.add('모두 통과');
    lstNotApplyText.add('모두 통과');
    lstNotApplyText.add('모두 통과');
    lstNotApplyText.add('모두 통과');
    lstNotApplyText.add('    모두\n통과못함');
    lstNotApplyText.add('모두 통과');

    // initGame();
    // resetGame();
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
    super.endGame();
  }

  @override
  void initGame(){

    ColorRectComponent background = ColorRectComponent(
      color: const Color.fromARGB(255, 180, 181, 188),
      position: Vector2(202, 403),
      size: Vector2(322, 544),
      anchor: Anchor.center
    );
    world.add(background);

    ColorRectComponent bottomBackground = ColorRectComponent(
      color: Colors.white,
      position: background.size * 0.5,
      size: Vector2(318, 540),
      anchor: Anchor.center
    );
    background.add(bottomBackground);

    ColorRectComponent topBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 247, 247, 247),
      position: background.size * 0.5 + Vector2(0, -248),
      size: Vector2(318, 45),
      anchor: Anchor.center
    );
    background.add(topBackground);

    ColorRectComponent line1 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(-73.5, 0),
      size: Vector2(2, 540),
      anchor: Anchor.center
    );
    background.add(line1);

    ColorRectComponent line2 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(75, 0),
      size: Vector2(2, 540),
      anchor: Anchor.center
    );
    background.add(line2);

    ColorRectComponent line3 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(0, -143),
      size: Vector2(318, 2),
      anchor: Anchor.center
    );
    background.add(line3);

    ColorRectComponent line4 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(0, -60),
      size: Vector2(318, 2),
      anchor: Anchor.center
    );
    background.add(line4);

    ColorRectComponent line5 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(0, 23),
      size: Vector2(318, 2),
      anchor: Anchor.center
    );
    background.add(line5);

    ColorRectComponent line6 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(0, 106),
      size: Vector2(318, 2),
      anchor: Anchor.center
    );
    background.add(line6);

    ColorRectComponent line7 = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: background.size * 0.5 + Vector2(0, 189),
      size: Vector2(318, 2),
      anchor: Anchor.center
    );
    background.add(line7);

    TextComponent text1 = TextComponent(
      anchor: Anchor.center,
      text: '도형',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: background.size * 0.5 + Vector2(-115, -247),
    );
    background.add(text1);

    TextComponent text2 = TextComponent(
      anchor: Anchor.center,
      text: '적용시',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: background.size * 0.5 + Vector2(0, -247),
    );
    background.add(text2);

    TextComponent text3 = TextComponent(
      anchor: Anchor.center,
      text: '미적용시',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      position: background.size * 0.5 + Vector2(115, -247),
    );
    background.add(text3);

    for( int i=0; i<lstContidions.length; ++i){
      SpriteComponent condition = SpriteComponent(
        anchor: Anchor.center,
        position: background.size * 0.5 + Vector2(-115, -185) + Vector2( 0, i * 83),
        size: lstConditionSizes[i],
        sprite: lstContidions[i]
      );
      condition.paint.filterQuality = FilterQuality.high;
      background.add(condition);
    }

    for( int i=0; i<lstApplyLights.length; ++i){
      TrafficLight trafficLight = TrafficLight(
        position: background.size * 0.5 + Vector2(-50, -185) + Vector2( 0, i * 83),
        isExample: true,
        on: lstApplyLights[i],
      );
      background.add(trafficLight);  
    }

    for( int i=0; i<lstApplyText.length; ++i){
      double startX = i > 3 ? 0 : -20;
      TextComponent text1 = TextComponent(
        anchor: i > 3 ? Anchor.center : Anchor.centerLeft,
        text: lstApplyText[i],
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 112, 112, 112)),
        ),
        position: background.size * 0.5 + Vector2(startX, -185) + Vector2( 0, i * 83),
      );
      background.add(text1);
    }

    for( int i=0; i<lstNotApplyText.length; ++i){
      TextComponent text1 = TextComponent(
        anchor: Anchor.center,
        text: lstNotApplyText[i],
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 13, color: Color.fromARGB(255, 112, 112, 112)),
        ),
        position: background.size * 0.5 + Vector2(115, -185) + Vector2( 0, i * 83),
      );
      background.add(text1);
    }

    SubmitButton submitButton = SubmitButton(
      position: Vector2(750, 650),
    );
    world.add(submitButton);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    isSecondHalfQuestion = isSecondHalf;
    
    for( int i=0; i<lstAnswers.length; ++i){
      world.remove(lstAnswers[i]);
    }
    lstAnswers.clear();
    lstCheck.clear();
    if( question != null ) {
      world.remove(question!);
    }
    question = Question(
      position: Vector2(600, 250),
      isSecondHalf: isSecondHalf,
    );
    world.add(question!);

    for( int i=0; i<(isSecondHalf ? 4 : 5); ++i){
      Answer answer = Answer(
        position: Vector2(560 + i * 100, 500),
        number: i+1,
        isSecondHalf: isSecondHalf
      );
      world.add(answer);  
      lstAnswers.add(answer);
      lstCheck.add(false);
    } 
  }

  void check(int index){
    if( index == 4 ){
      if( lstCheck[4] == false ){
        for( int i=0; i<4; ++i){
          lstCheck[i] = false;
          lstAnswers[i].onOff(false);  
        }
        lstCheck[4] = !lstCheck[4];
        lstAnswers[4].onOff(lstCheck[4]);
      } else {
        lstCheck[4] = !lstCheck[4];
        lstAnswers[4].onOff(lstCheck[4]);
      }
    } else {
      if( question != null ){
        if( question!.isSecondHalf ){

        } else {
          lstCheck[4] = false;
          lstAnswers[4].onOff(false);    
        }
        lstCheck[index] = !lstCheck[index];
        lstAnswers[index].onOff(lstCheck[index]);
      }
    }
  }

  void submit(){
    bool isChecked = false;
    for( int i=0; i<lstCheck.length; ++i ){
      if( lstCheck[i] == true ){
        isChecked = true;
        break;
      }
    }
    
    if( isChecked == false ) return;

    if( question != null ){
      if( isSecondHalfQuestion ){
        int checkValue = 0;
        for( int i=0; i<lstCheck.length; ++i ){
          if( lstCheck[i] ){
            checkValue += (1 << i);
          }
        }

        if( question!.secondHalfFilter == checkValue ){
          secondHalfScore += 200;
        } else {
          secondHalfScore -= 40;
        } 
        secondHalfScore = max(0, secondHalfScore);
        currScore = firstHalfScore + secondHalfScore;
        gameStep.updateScore(currScore);
      } else {
        int checkValue = 0;
        if( lstCheck[4] ) {

        } else {
          for( int i=0; i<lstCheck.length-1; ++i ){
            if( lstCheck[i] ){
              checkValue += (1 << i);
            }
          }
        }
        
        if( question!.output == checkValue ){
          firstHalfScore += 100;
        } else {          
          firstHalfScore -= 20;
        }
        firstHalfScore = max(0, firstHalfScore);
        currScore = firstHalfScore + secondHalfScore;
        gameStep.updateScore(currScore);
      }
    }
    resetGame();
  }
}