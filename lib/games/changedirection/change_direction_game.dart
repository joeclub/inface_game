import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'pipe.dart';

class ChangeDirectionGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  double roundTime = 0;

  List<Pipe> lstPipes = [];

  late TextComponent countText;
  int count = 0;

  ChangeDirectionGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 5, gameName: '방향 바꾸기', timeLimit: limitTime, gameDescIndex: 4);
    world.add(gameStep);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if( gameStep.step == 2 ) {
      roundTime += dt;
      if(roundTime > 20){
        roundTime = 0;
        resetGame();
      }
    }
    
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
    TextComponent countTitle = TextComponent(
      anchor: Anchor.center,
      text: '맞춘 조각 개수',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      position: Vector2(950, 90),
    );
    world.add(countTitle);

    countText = TextComponent(
      anchor: Anchor.centerRight,
      text: '0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 52, 186, 204)),
      ),
      position: Vector2(1080, 90),
    );
    world.add(countText);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();
    
    for( int i=0; i<lstPipes.length; ++i){
      lstPipes[i].isDestroyed = true;
    }
    world.removeAll(lstPipes);
    lstPipes.clear();

    int numPipes = 0;
    if( isSecondHalf ){
      numPipes = Random().nextInt(2) + 5;
    } else {
      numPipes = Random().nextInt(3) + 2;
    }
    double pipeOffset = 80;
    double startY = 420 - (numPipes-1) * pipeOffset * 0.5;
    for( int i=0; i<numPipes; ++i){
      Pipe pipe = Pipe(position: Vector2(640, startY + i * pipeOffset));
      world.add(pipe);

      lstPipes.add(pipe);
    }
  }

  void refreshPipe(Pipe pipe){
    if( pipe.isDestroyed ) return;
    Vector2 pos = pipe.position.xy;
    world.remove(pipe);
    lstPipes.remove(pipe);
    Pipe newPipe = Pipe(position: pos);
    world.add(newPipe);
    lstPipes.add(newPipe);
  }
}