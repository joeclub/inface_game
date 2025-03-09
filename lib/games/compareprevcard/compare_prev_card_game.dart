import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'game_card.dart';

class ComparePrevCardGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  
  List<int> lstCardHistory = [];

  late Sprite cardSprite;
  late ClipComponent clipComponent;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  late GameCard prevCard;

  late Sprite bgSprite;
  late Sprite guideSprite;

  late GameCard card;
  late int cardIndex;

  ComparePrevCardGame({required super.hasFirstHalfScore, required super.hasRoundScore, required super.isEP});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 18, gameName: '이전 카드와 비교하기', timeLimit: limitTime, gameDescIndex: 18, isKeyboardControl: true);
    world.add(gameStep);

    bgSprite = await loadSprite('games/selectshape/bg_gradation.png');
    guideSprite = await loadSprite('games/compareprevcard/txt_key.png');
    cardSprite = await loadSprite('games/compareprevcard/ring_01.png');

    

    
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
    SpriteComponent background = SpriteComponent(
      sprite: bgSprite,
      position: Vector2(640, 420),
      size: Vector2(1010, 544),
      anchor: Anchor.center
    );
    world.add(background);
    
    SpriteComponent guide = SpriteComponent(
      sprite: guideSprite,
      position: Vector2(640, 640),
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

    clipComponent = ClipComponent.rectangle(
      position: background.size * 0.5,
      size: Vector2(1010, 544),
      anchor: Anchor.center,
    );
    background.add(clipComponent);

    cardIndex = Random().nextInt(6);
    lstCardHistory.add(cardIndex);

    card = GameCard(position: clipComponent.size * 0.5, cardIndex: cardIndex, sprite: cardSprite);
    clipComponent.add(card);
  }

  @override
  void resetGame() async {
    Future.delayed(const Duration(seconds: 3), (){
      card.out();
      cardIndex = Random().nextInt(6);
      lstCardHistory.add(cardIndex);

      card = GameCard(position: clipComponent.size * 0.5, cardIndex: cardIndex, sprite: cardSprite);
      clipComponent.add(card);
      Future.delayed(const Duration(seconds: 3), (){
        card.out();
        resetGame2();
      });
    });
  }

  void resetGame2(){
    currRound++;
    gameStep.updateRound();
    
    leftButton.isVisible = true;
    rightButton.isVisible = true;

    int cardIndex = nextCardIndex();
    lstCardHistory.add(cardIndex);

    GameCard card = GameCard(position: clipComponent.size * 0.5, cardIndex: cardIndex, sprite: cardSprite);
    prevCard = card;
    clipComponent.add(card);
  }

  int nextCardIndex(){
    bool matched = Random().nextInt(2) == 0;
    if( matched ){
      return lstCardHistory[lstCardHistory.length-2];
    } else {
      while(true){
        int cardIndex = Random().nextInt(6);
        int prevIndex = lstCardHistory[lstCardHistory.length-2];
        if( cardIndex != prevIndex ) return cardIndex;
      }
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if(showEndGamePopup) return KeyEventResult.ignored;
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