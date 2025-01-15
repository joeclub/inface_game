import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import '../emotionfit/emotion_fit_game.dart';
import 'emotion.dart';
import 'next_button.dart';

class MatchEmotionGame extends EduceGame {
  final limitTime = 2 * 60;
  late GameStep gameStep;
  bool isGameEnd = false;

  TextComponent? question;
  List<int> lstEmotionCount = [];
  List<String> lstEmotionText = [];

  List<Emotion> lstEmotionComponents = [];

  late NextButton nextButton;
  int selectedEmotionCount = 0;
  int correctCount = 0;
  int emotionIndex = 0;
  List<int> lstEmotionIndices = [];

  MatchEmotionGame({required super.hasFirstHalfScore, required super.hasRoundScore, required super.isEP});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 3, gameName: '같은 감정 맞히기', timeLimit: limitTime, isCat: true, gameDescIndex: 12, isHalfTime: true );
    world.add(gameStep);
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
    lstEmotionCount.add(46);
    lstEmotionCount.add(22);
    lstEmotionCount.add(11);
    lstEmotionCount.add(27);
    lstEmotionCount.add(46);
    lstEmotionCount.add(28);
    lstEmotionCount.add(19);
    lstEmotionCount.add(28);

    lstEmotionText.add('침착');
    lstEmotionText.add('놀람');
    lstEmotionText.add('슬픔');
    lstEmotionText.add('분노');
    lstEmotionText.add('혼란');
    lstEmotionText.add('공포');
    lstEmotionText.add('혐오');
    lstEmotionText.add('기쁨');

    nextButton = NextButton(position: Vector2(1100, 440));
    world.add(nextButton);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    
    if( question != null ) {
      world.remove(question!);
    }

    for( int i=0; i<lstEmotionComponents.length; ++i){
      world.remove(lstEmotionComponents[i]);
    }
    lstEmotionComponents.clear();

    selectedEmotionCount = 0;

    emotionIndex = Random().nextInt(lstEmotionText.length);

    question = TextComponent(
      text: '${lstEmotionText[emotionIndex]}표정',
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 52, 186, 204),),
      ),
      position: Vector2(480, 170),
    );
    world.add(question!);
    question!.add(
      TextComponent(
        text: '을 짓고 있는 얼굴을 모두 고르세요.',
        anchor: Anchor.centerLeft,
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 18, color: Colors.black,),
        ),
        position: Vector2(68, 14),
      ),
    );

    correctCount = Random().nextInt(6) + 1;

    //String emotionName = EmotionType.values[emotionIndex].name;

    lstEmotionIndices.clear();
    for( int i=0; i<correctCount; ++i){
      lstEmotionIndices.add(emotionIndex);
    }
    for( int i=correctCount; i<6; ++i){
      while(true){
        int nextIndex = Random().nextInt(6);
        if( nextIndex != emotionIndex ){
          lstEmotionIndices.add(nextIndex);
          break;
        }
      }
    }
    lstEmotionIndices.shuffle();

    List<List<int>> lstSeq = [];
    for( int i=0; i<lstEmotionCount.length; ++i){
      List<int> lst = [];
      for( int j=0; j<lstEmotionCount[i]; ++j){
        lst.add(j);
      }
      lst.shuffle();
      lstSeq.add(lst);
    }

    Vector2 startPos = Vector2(400, 320);
    for( int i=0; i<6; ++i){
      int index = lstEmotionIndices[i];
      String emotionName2 = EmotionType.values[lstEmotionIndices[i]].name;
      int index2 = lstSeq[index][i] + 1;
      String emotionFileName = emotionName2 + index2.toString();
      String spriteName = '$emotionName2/$emotionFileName.jpg';

      int x = i % 3;
      int y = i ~/ 3;
      Emotion emotion = Emotion(
        position: Vector2(x * 240, y * 240) + startPos,
        spriteName: spriteName,
        emotionIndex: lstEmotionIndices[i],
      );
      world.add(emotion);
      lstEmotionComponents.add(emotion);
    }
  }

  void addSelectedEmotion(int selected){
    selectedEmotionCount += selected;
    nextButton.updateButtonState(selectedEmotionCount);
  }
}