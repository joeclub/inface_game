import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/color_rect_component.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'answer_button.dart';
import 'correct_box.dart';
import 'game_card.dart';
import 'game_card_array.dart';

class MatchNthCardGame extends EduceGame with KeyboardEvents {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  bool isGameEnd = false;

  late TextComponent missionText;
  int currNthCard = 0;
  double currRoundTime = 0;

  GameCard? card;
  GameCardArray? cardArray;

  late AnswerButton leftButton;
  late AnswerButton rightButton;

  late CorrectBox correctBox;

  MatchNthCardGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 7, gameName: 'N번째 카드 맞추기', timeLimit: limitTime, gameDescIndex: 6, isKeyboardControl: true);
    world.add(gameStep);

    
  }

  @override
  void update(double dt) {
    super.update(dt);

    currRoundTime += dt;

    if (gameStep.limitTimer.current > gameStep.halfTime) {
      isSecondHalf = true;
    }

    if (gameStep.limitTimer.finished) {
      endGame();
    }

    if( currRoundTime > 60 && isGameEnd == false){
      currRoundTime = 0;
      resetGame();
    }
  }

  void endGame() {
    isGameEnd = true;
    correctBox.hide();
    if( card != null ){
      world.remove(card!);
      card!.isEnd = true;
      card = null;
    }

    if( cardArray != null ){
      world.remove(cardArray!);
      cardArray!.isEnd = true;
      cardArray = null;
    }
  }

  @override
  void initGame(){
    ColorRectComponent missionBackground1 = ColorRectComponent(
      anchor: Anchor.center,
      color: const Color.fromARGB(255, 226, 226, 226),
      position: Vector2(168, 170),
      size: Vector2(260, 74),
    );
    world.add(missionBackground1);

    ColorRectComponent missionBackground2 = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: missionBackground1.size * 0.5,
      size: Vector2(258, 72),
    );
    missionBackground1.add(missionBackground2);

    missionText = TextComponent(
      anchor: Anchor.center,
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: missionBackground1.size * 0.5,
    );
    missionBackground1.add(missionText);

    leftButton = AnswerButton(
      position: Vector2(200, 420),
      isLeft: true,
    );
    world.add(leftButton);

    rightButton = AnswerButton(
      position: Vector2(1080, 420),
      isLeft: false,
    );
    world.add(rightButton);

    leftButton.isVisible = false;
    rightButton.isVisible = false;

    correctBox = CorrectBox(
      position: Vector2(168, 250),
    );
    world.add(correctBox);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    showAnswerButton(false);
    correctBox.hide();
    if( card != null ){
      world.remove(card!);
      card!.isEnd = true;
      card = null;
    }

    if( cardArray != null ){
      world.remove(cardArray!);
      cardArray!.isEnd = true;
      cardArray = null;
    }
    currRound++;

    currNthCard = (currRound % 2) == 1 ? 2 : 3;
    missionText.text = '$currNthCard번째 전 카드 맞추기';

    if( isSecondHalf ){
      cardArray = GameCardArray(
        position: Vector2(640, 420),
        round: currRound,
        nth: currNthCard,
      );
      world.add(cardArray!);
    } else {
      card = GameCard(
        position: Vector2(640, 420),
        round: currRound,
        nth: currNthCard,
      );
      world.add(card!);
    }
  }

  void showAnswerButton(bool show){
    leftButton.isVisible = rightButton.isVisible = show;
  }

  void checkCard(bool isMatched){
    showAnswerButton(false);
    bool result = false;
    if( card != null ){
      if( card!.currPhase != MatchNthCardPhase.game) return;
      result = card!.isCorrect(isMatched);
      if( result ) currScore += 100;
    } else if( cardArray != null ){
      if( cardArray!.currPhase != MatchNthCardPhase.game) return;
      result = cardArray!.isCorrect(isMatched);
      if( result ) currScore += 200;
    }

    gameStep.updateScore(currScore);
    
    correctBox.setCorrect(result);
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