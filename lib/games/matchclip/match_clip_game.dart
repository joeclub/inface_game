import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'clip_button.dart';
import 'clip_sprite_component.dart';
import 'color_button.dart';
import 'submit_button.dart';

class MatchClipGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;

  ColorRectComponent? background;

  int questionIndex = 0;
  int questionColor = 0;
  int questionClip = 0;

  List<Sprite> lstClipSprites = [];
  late Sprite clipSprite;
  late Sprite selectedSprite;
  late Sprite questionSprite;
  late Sprite checkSprite;

  List<ColorButton> lstColorButtons = [];
  List<ClipButton> lstClipButtons = [];

  int currColorButton = -1;
  int currClipButton = -1;

  bool isSecondHalfQuestion = false;
  
  MatchClipGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 1, gameName: '클립 맞히기', isCat: true, timeLimit: limitTime, gameDescIndex: 23);
    world.add(gameStep);

    Sprite redSprite = await loadSprite('games/matchclip/clip_red.png');
    Sprite greenSprite = await loadSprite('games/matchclip/clip_green.png');
    Sprite blueSprite = await loadSprite('games/matchclip/clip_blue.png');
    lstClipSprites.add(redSprite);
    lstClipSprites.add(greenSprite);
    lstClipSprites.add(blueSprite);

    clipSprite = await loadSprite('games/matchclip/clip_grey.png');
    selectedSprite = await loadSprite('games/matchclip/clip_selected.png');
    questionSprite = await loadSprite('games/matchclip/matter.png');

    checkSprite = await loadSprite('games/matchclip/check.png');
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
  }

  @override
  void resetGame(){
    if( background != null ){
      world.remove(background!);
    }

    currRound++;
    gameStep.updateRound();

    lstColorButtons.clear();
    lstClipButtons.clear();

    currColorButton = -1;
    currClipButton = -1;

    isSecondHalfQuestion = isSecondHalf;

    background = ColorRectComponent(
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      anchor: Anchor.center
    );
    world.add(background!);

    ColorRectComponent leftBackground = ColorRectComponent(
      color: const Color.fromARGB(255, 246, 246, 246),
      position: background!.size * 0.5 + Vector2(-219, 0),
      size: Vector2(569, 542),
      anchor: Anchor.center
    );
    background!.add(leftBackground);

    ColorRectComponent rightBackground = ColorRectComponent(
      color: Colors.white,
      position: background!.size * 0.5 + Vector2(285, 0),
      size: Vector2(438, 542),
      anchor: Anchor.center
    );
    background!.add(rightBackground);

    ColorRectComponent separator = ColorRectComponent(
      color: const Color.fromARGB(255, 226, 226, 226),
      position: rightBackground.size * 0.5,
      size: Vector2(386, 2),
      anchor: Anchor.center
    );
    rightBackground.add(separator);

    int colorCount = Random().nextInt(3) + (isSecondHalf ? 4 : 1);
    int rotationCount = Random().nextInt(3) + 4;
    List<int> lstColors = [0, 1, 2];
    List<int> lstRotations = [0, 1, 2, 3];
    lstColors.shuffle();
    lstRotations.shuffle();
    List<int> lstColorLine0 = [];
    List<int> lstRotationLine0 = [];
    switch(colorCount){
      case 1:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[0]);

        if( isSecondHalf ){
          lstColorLine0.add(lstColors[0]);
          lstColorLine0.add(lstColors[0]);
        }
      }
      break;
      case 2:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[1]);
        if( isSecondHalf ){
          lstColorLine0.add(lstColors[0]);
          lstColorLine0.add(lstColors[0]);
        }
      }
      break;
      case 3:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[1]);
        if( isSecondHalf ){
          lstColorLine0.add(lstColors[0]);
          lstColorLine0.add(lstColors[1]);
        }
      }
      break;
      case 4:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[1]);
        if( isSecondHalf ){
          lstColorLine0.add(lstColors[1]);
          lstColorLine0.add(lstColors[1]);
        }
      }
      break;
      case 5:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[1]);
        lstColorLine0.add(lstColors[2]);
        if( isSecondHalf ){
          lstColorLine0.add(lstColors[0]);
          lstColorLine0.add(lstColors[1]);
        }
      }
      break;
      case 6:{
        lstColorLine0.add(lstColors[0]);
        lstColorLine0.add(lstColors[1]);
        lstColorLine0.add(lstColors[2]);
        if( isSecondHalf ){
          lstColorLine0.add(lstColors[0]);
          lstColorLine0.add(lstColors[1]);
        }
      }
      break;
    }

    switch(rotationCount){
      case 1:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[0]);

        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[0]);
          lstRotationLine0.add(lstColors[0]);
        }
      }
      break;
      case 2:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[1]);
        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[0]);
          lstRotationLine0.add(lstColors[0]);
        }
      }
      break;
      case 3:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[1]);
        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[0]);
          lstRotationLine0.add(lstColors[1]);
        }
      }
      break;
      case 4:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[1]);
        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[1]);
          lstRotationLine0.add(lstColors[1]);
        }
      }
      break;
      case 5:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[1]);
        lstRotationLine0.add(lstRotations[2]);
        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[0]);
          lstRotationLine0.add(lstColors[1]);
        }
      }
      break;
      case 6:{
        lstRotationLine0.add(lstRotations[0]);
        lstRotationLine0.add(lstRotations[1]);
        lstRotationLine0.add(lstRotations[2]);
        if( isSecondHalf ){
          lstRotationLine0.add(lstColors[0]);
          lstRotationLine0.add(lstColors[1]);
        }
      }
      break;
    }

    lstColorLine0.shuffle();
    lstRotationLine0.shuffle();
    List<int> lstColorLine1 = [];
    List<int> lstRotationLine1 = [];
    List<int> lstColorLine2 = [];
    List<int> lstRotationLine2 = [];
    lstColorLine1 = [...lstColorLine0];
    lstColorLine2 = [...lstColorLine0];
    lstRotationLine1 = [...lstRotationLine0];
    lstRotationLine2 = [...lstRotationLine0];
    lstColorLine1.shuffle();
    lstColorLine2.shuffle();
    lstRotationLine1.shuffle();
    lstRotationLine2.shuffle();

    List<int> lstColorLine = [...lstColorLine0];
    lstColorLine.addAll(lstColorLine1);
    lstColorLine.addAll(lstColorLine2);

    List<int> lstRotationLine = [...lstRotationLine0];
    lstRotationLine.addAll(lstRotationLine1);
    lstRotationLine.addAll(lstRotationLine2);

    if( isSecondHalf ){
      List<int> lstColorLine3 = [...lstColorLine0];
      List<int> lstRotationLine3 = [...lstRotationLine0];
      List<int> lstColorLine4 = [...lstColorLine0];
      List<int> lstRotationLine4 = [...lstRotationLine0];

      lstColorLine3.shuffle();
      lstColorLine4.shuffle();
      lstRotationLine3.shuffle();
      lstRotationLine4.shuffle();

      lstColorLine.addAll(lstColorLine3);
      lstColorLine.addAll(lstColorLine4);

      lstRotationLine.addAll(lstRotationLine3);
      lstRotationLine.addAll(lstRotationLine4);
    }
    

    questionIndex = Random().nextInt(lstRotationLine.length);

    questionColor = lstColorLine[questionIndex];
    questionClip = lstRotationLine[questionIndex];

    Vector2 startPos = isSecondHalf ? Vector2(-220, -220) : Vector2(-110, -110);
    startPos += leftBackground.size * 0.5;
    for( int i=0; i<lstColorLine.length; ++i ){
      int x = i % (isSecondHalf ? 5 : 3);
      int y = i ~/ (isSecondHalf ? 5 : 3);
      if( i == questionIndex ){
        SpriteComponent q = SpriteComponent(
          sprite: questionSprite,
          position: startPos + Vector2( x * 110, y * 110),
          size: Vector2.all(60),
          anchor: Anchor.center,
        );
        leftBackground.add(q);
      } else {
        ClipSpriteComponent clip = ClipSpriteComponent(
          position: startPos + Vector2( x * 110, y * 110),
          spriteIndex: lstColorLine[i],
          rotationIndex: lstRotationLine[i],
        );
        leftBackground.add(clip);
      }
    }

    ColorButton btnRed = ColorButton(
      position: rightBackground.size * 0.5 + Vector2(-130, -130),
      colorIndex: 0,
    );
    rightBackground.add(btnRed);
    lstColorButtons.add(btnRed);

    ColorButton btnGreen = ColorButton(
      position: rightBackground.size * 0.5 + Vector2(0, -130),
      colorIndex: 1,
    );
    rightBackground.add(btnGreen);
    lstColorButtons.add(btnGreen);

    ColorButton btnBlue = ColorButton(
      position: rightBackground.size * 0.5 + Vector2(130, -130),
      colorIndex: 2,
    );
    rightBackground.add(btnBlue);
    lstColorButtons.add(btnBlue);

    for( int i=0; i<4; ++i){
      double startPos = -150;
      ClipButton btnClip = ClipButton(
        position: rightBackground.size * 0.5 + Vector2(startPos + i * 100, 130),
        clipIndex: i
      );
      rightBackground.add(btnClip);
      lstClipButtons.add(btnClip);
    }

    SubmitButton submitButton = SubmitButton(
      position: rightBackground.size * 0.5 + Vector2(130, 232),
    );
    rightBackground.add(submitButton);
  }

  void onClickColorButton(int index){
    currColorButton = index;
    for( int i=0; i<lstColorButtons.length; ++i){
      lstColorButtons[i].checkVisible(i==currColorButton);
    }
  }

  void onClickClipButton(int index){
    currClipButton = index;
    for( int i=0; i<lstClipButtons.length; ++i){
      lstClipButtons[i].checkSelected(i==currClipButton);
    }
  }

  void submit(){
    if( currColorButton < 0 || currClipButton < 0 ) return;
    if( currColorButton == questionColor && currClipButton == questionClip ){
      if( isSecondHalfQuestion ){
        currScore += 100;
      } else {
        currScore += 50;
      }
      gameStep.updateScore(currScore);
    }
    resetGame();
  }
}