import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'slot.dart';
import 'submit_button.dart';

class MatchPuzzleGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isGameEnd = false;

  late ColorRectComponent leftBackground;
  late ColorRectComponent rightBackground;

  PositionComponent? leftParent;
  PositionComponent? rightParent;

  late Sprite exampleSprite;
  List<Sprite> lstSprites = [];
  List<Slot> lstSlots = [];
  int selectedSlotIndex = -1;

  bool isSecondHalfQuestion = false;

  MatchPuzzleGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 1, isCat: true, gameName: '퍼즐 맞추기', timeLimit: limitTime, gameDescIndex: 25);
    world.add(gameStep);

    exampleSprite = await loadSprite('games/matchpuzzle/look.png'); 
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
    ColorRectComponent background = ColorRectComponent(
      anchor: Anchor.center,
      color: const Color.fromARGB(255, 193, 196, 208),
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
    );
    world.add(background);

    leftBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: Vector2(182, background.size.y * 0.5),
      size: Vector2(361, 542),
    );
    background.add(leftBackground);

    SpriteComponent example = SpriteComponent(
      sprite: exampleSprite,
      anchor: Anchor.center,
      position: Vector2(55, 35),
      size: Vector2( 80, 40 )
    );
    example.paint.filterQuality = FilterQuality.high;
    leftBackground.add(example);

    rightBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: const Color.fromARGB(255, 247, 247, 247),
      position: Vector2(686, background.size.y * 0.5),
      size: Vector2(645, 542),
    );
    background.add(rightBackground);
  }

  @override
  Future<void> resetGame() async {
    currRound++;
    gameStep.updateRound();

    isSecondHalfQuestion = isSecondHalf;

    lstSprites.clear();
    lstSlots.clear();
    selectedSlotIndex = -1;

    if( leftParent != null ) leftBackground.remove(leftParent!);
    if( rightParent != null ) rightBackground.remove(rightParent!);

    leftParent = PositionComponent(
      position: leftBackground.size * 0.5,
    );
    leftBackground.add(leftParent!);

    rightParent = PositionComponent(
      position: rightBackground.size * 0.5,
    );
    rightBackground.add(rightParent!);

    int puzzleIndex = Random().nextInt(100) + 1;
    puzzleIndex += isSecondHalf ? 100 : 0;

    Sprite leftSprite = await loadSprite('games/matchpuzzle/$puzzleIndex.jpg');

    SpriteComponent leftExample = SpriteComponent(
      anchor: Anchor.center,
      position: Vector2.zero(),
      size: Vector2(333, 250),
      sprite: leftSprite,
    );
    leftExample.paint.filterQuality = FilterQuality.high;
    leftParent!.add(leftExample);

    int pieceCount = 4;
    if( isSecondHalf ) pieceCount = 8;

    
    List<int> lstSequences = [];

    for( int i=0; i<pieceCount; ++i ){
      int spriteIndex = i + 1;
      String pieceFileName = '$puzzleIndex-$spriteIndex';
      Sprite sprite = await loadSprite('games/matchpuzzle/$pieceFileName.png');
      lstSprites.add(sprite);
      lstSequences.add(i);
    }
    lstSequences.shuffle();
    
    Vector2 slotSize = isSecondHalf ? Vector2(50, 250) : Vector2(84, 250);
    double interval = isSecondHalf ? 80 : 162;
    double startPos = -(pieceCount-1) * interval * 0.5;
    for( int i=0; i<pieceCount; ++i ){
      Slot slot = Slot(
        isSecondHalf: isSecondHalf,
        position: Vector2(startPos + i * interval, 0) - slotSize * 0.5,
        puzzleIndex: lstSequences[i],
        slotIndex: i,
      );
      lstSlots.add(slot);
      rightParent!.add(slot);
    }

    SubmitButton submitButton = SubmitButton(
      position: Vector2(230, 230),
    );
    rightParent!.add(submitButton);
  }

  void submit(){
    bool correct = true;
    for( int i=0; i<lstSlots.length; ++i ) {
      if( lstSlots[i].puzzleIndex != i ) {
        correct = false;
        break;
      }
    }

    if( isSecondHalfQuestion ){
      if( correct ) currScore += 50;
    } else {
      if( correct ) currScore += 30;
    }
    gameStep.updateScore(currScore);
    resetGame();
  }
}