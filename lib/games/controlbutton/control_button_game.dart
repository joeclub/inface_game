import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inface/games/components/color_rect_component.dart';
import 'package:inface/games/controlbutton/guage_component.dart';

import '../../models/base/game/control_button_model.dart';
import '../components/educe_game.dart';
import '../components/game_step.dart';
import 'submit_button.dart';
import 'switch_component.dart';

class ControlButtonGame extends EduceGame {
  final limitTime = 4 * 60;
  late GameStep gameStep;
  bool isSecondHalf = false;
  bool isGameEnd = false;

  List<ControlButtonModel> lstButtons = [];
  late Sprite modeTableSprite;
  late PositionComponent buttonParent;

  List<SwitchComponent> lstSwitches = [];
  List<int> lstValue = [650, 1150, 1650, 2150, 2650, 3150, 3650];

  int currValue = 0;
  int currIndex = 0;

  ControlButtonGame();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    gameStep = GameStep(gameNumber: 3, gameName: '버튼 조작', isCat: true, timeLimit: limitTime, gameDescIndex: 20);
    world.add(gameStep);

    String json = await rootBundle.loadString('assets/games/controlbutton/controlbutton.json');
    lstButtons = controlButtonModelFromJson(json);

    modeTableSprite = await loadSprite('games/controlbutton/info.png');

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

  void endGame() {
    isGameEnd = true;

  }

  @override
  void initGame(){
    ColorRectComponent tableBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: const Color.fromARGB(255, 248, 248, 248),
      position: Vector2(640, 248),
      size: Vector2(1020, 244),
    );
    world.add(tableBackground);

    TextComponent tableText = TextComponent(
      anchor: Anchor.center,
      text: '<MODE 테이블>',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: tableBackground.size * 0.5 + Vector2(0, -95),
    );
    tableBackground.add(tableText);

    ColorRectComponent tableBackground2 = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: tableBackground.size * 0.5 + Vector2(0, 20),
      size: Vector2(414, 176),
    );
    tableBackground.add(tableBackground2);

    SpriteComponent modeTable = SpriteComponent(
      anchor: Anchor.center,
      position: tableBackground2.size * 0.5,
      size: Vector2(414, 176),
      sprite: modeTableSprite,
    );
    tableBackground2.add(modeTable);

    buttonParent = PositionComponent(
      anchor: Anchor.center,
      position: Vector2(640, 600),
    );
    world.add(buttonParent);
  }

  @override
  void resetGame(){
    currRound++;
    gameStep.updateRound();

    lstSwitches.clear();
    world.remove(buttonParent);

    currIndex = 0;

    buttonParent = PositionComponent(
      anchor: Anchor.center,
      position: Vector2(640, 0),
    );
    world.add(buttonParent);
        
    ColorRectComponent buttonBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: const Color.fromARGB(255, 138, 138, 138),
      position: Vector2(0, 470),
      size: Vector2(223, 124),
    );
    buttonParent.add(buttonBackground);

    TextComponent onText = TextComponent(
      anchor: Anchor.centerRight,
      text: 'ON',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: Vector2( -120, 408),
    );
    buttonParent.add(onText);

    TextComponent offText = TextComponent(
      anchor: Anchor.centerRight,
      text: 'OFF',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: Vector2( -120, 532),
    );
    buttonParent.add(offText);

    TextComponent onOffText = TextComponent(
      anchor: Anchor.center,
      text: '<ON-OFF 스위치>',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      position: Vector2( 0, 580),
    );
    buttonParent.add(onOffText);

    GuageComponent guage = GuageComponent(
      position: Vector2(0, 650),
    );
    buttonParent.add(guage);

    int index = Random().nextInt(lstButtons.length);
    ControlButtonModel currButton = lstButtons[index];
    currValue = currButton.gage;

    for( int i=0; i<currButton.onOff.length; ++i){
      SwitchComponent switchComponent = SwitchComponent(
        position: Vector2(-82.5 + i * 55, 0) + buttonBackground.size * 0.5,
        switchNumber: i+1,
        isOn: currButton.onOff[i] > 0,
      );
      buttonBackground.add(switchComponent);
      lstSwitches.add(switchComponent);
    }

    SubmitButton submitButton = SubmitButton(
      //position: Vector2(440, 660)
      position: Vector2(550, 245)
    );
    buttonBackground.add(submitButton);
  }

  void submit(){
    int startValue = lstValue[currIndex];
    int endValue = lstValue[currIndex+1];
    if( startValue <= currValue && currValue <= endValue ){
      currScore += 30;
      gameStep.updateScore(currScore);
    }
    resetGame();
  }
}