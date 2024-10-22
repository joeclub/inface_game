import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'tile.dart';

class FindTileGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  bool isGameEnd = false;

  List<Tile> lstTiles = [];
  List<int> lstQuestions = [];
  int numQuestions = 0;

  bool isButtonEnable = false;
  late AnswerButton answerButton;

  late Sprite s;
  late Sprite s0;
  late Sprite s1;
  late Sprite s2;

  FindTileGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 14, gameName: '타일 위치 기억하기', timeLimit: limitTime, gameDescIndex: 14);
    world.add(gameStep);

    s = await loadSprite('games/findtile/bg.png');
    

    s0 = await loadSprite('games/findtile/tile_def.png');
    s1 = await loadSprite('games/findtile/tile_sample.png');
    s2 = await loadSprite('games/findtile/tile_click.png');
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
    isGameEnd = true;

  }

  @override
  void initGame(){
    SpriteComponent background = SpriteComponent(
      sprite: s,
      size: Vector2.all(480),
      position: Vector2(640, 420),
      anchor: Anchor.center,
    );
    world.add(background);

    Vector2 startPos = Vector2.all(126);
    for( int i=0; i<16; ++i){
      int x = i % 4;
      int y = i ~/ 4;
      Tile t = Tile(
        position: Vector2(x * 76, y * 76) + startPos,
        spriteDefault: s0,
        spriteSample: s1,
        spriteClick: s2,
      );
      lstTiles.add(t);
      background.add(t);
    }

    answerButton = AnswerButton(
      position: Vector2(1100, 420),
    );
    world.add(answerButton);
  }

  @override
  void resetGame() async {
    currRound++;
    gameStep.updateRound();
    
    isButtonEnable = false;
    bool noDefaultTile = true;
    for( int i=0; i<lstTiles.length; ++i){
      lstTiles[i].isTappable = false;
      if( lstTiles[i].tileType != TileType.defaultTile ){
        lstTiles[i].flip(TileType.defaultTile);
        noDefaultTile = false;
      }
    }
    if( noDefaultTile == false ){
      await Future.delayed(const Duration(milliseconds: 400));
    }

    lstQuestions.clear();
    for( int i=0; i<16; ++i){
      lstQuestions.add(i);
    }
    lstQuestions.shuffle();
    numQuestions = Random().nextInt(4) + 3;

    for( int i=0; i<numQuestions; ++i){
      lstTiles[lstQuestions[i]].flip(TileType.sample);
    }

    await Future.delayed(const Duration(seconds: 2));

    for( int i=0; i<lstTiles.length; ++i){
      if( lstTiles[i].tileType != TileType.defaultTile ){
        lstTiles[i].flip(TileType.defaultTile);
      }
    }

    await Future.delayed(const Duration(milliseconds: 400));

    for( int i=0; i<lstTiles.length; ++i){
      lstTiles[i].isTappable = true;
    }

    isButtonEnable = true;

  }

  void checkCorrect(){
    bool isWrong = false;
    for( int i=0; i<lstTiles.length; ++i){
      bool isFlipped = lstTiles[i].tileType == TileType.click;
      if( isFlipped){
        bool find = false;
        for( int j=0; j<numQuestions; ++j){
          if( lstQuestions[j] == i ){
            find = true;
            break;
          }
        }

        if( find == false ){
          isWrong = true;
          break;
        }
      }
    }

    if( isWrong ){
      answerButton.setRight(false);
      return;
    }

    int rightCount = 0;
    for( int i=0; i<lstTiles.length; ++i){
      bool isFlipped = lstTiles[i].tileType == TileType.click;
      if( isFlipped){
        for( int j=0; j<numQuestions; ++j){
          if( lstQuestions[j] == i ){
            rightCount++;
            break;
          }
        }
      }
    }

    if( rightCount == numQuestions ){
      answerButton.setRight(true);
      currScore += 20;
      gameStep.updateScore(currScore);
    }
  }
}