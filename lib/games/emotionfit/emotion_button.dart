import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'emotion_button_selected.dart';
import 'emotion_fit_game.dart';

class EmotionButton extends SpriteComponent with HasGameRef<EmotionFitGame>, TapCallbacks  {
  String buttonText;
  int buttonIndex;
  late EmotionButtonSelected tapDownSprite;
  late TextComponent buttonTextComponent;
  EmotionButton({required super.position, required this.buttonText, required this.buttonIndex});
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(160, 90);
    sprite = await gameRef.loadSprite('games/emotionfit/emotion_white.png');

    tapDownSprite = EmotionButtonSelected(
      position: size * 0.5,
    );
    add(tapDownSprite);
    tapDownSprite.isVisible = false;

    buttonTextComponent = TextComponent(
      anchor: Anchor.center,
      text: buttonText,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 19, color: Color.fromARGB(255, 104, 106, 115)),
      ),
      position: size * 0.5,
    );

    add(buttonTextComponent);

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    setTapUp();
    if( gameRef.emotionIndex == buttonIndex ){
      gameRef.currScore += 20;
    }
    gameRef.gameStep.updateScore(gameRef.currScore);
    gameRef.resetGame();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    setTapDown();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    setTapUp();
    super.onTapCancel(event);
  }

  void setTapDown(){
    tapDownSprite.isVisible = true;
    buttonTextComponent.textRenderer = TextPaint(
      style: const TextStyle(fontSize: 19, color: Colors.white),
    );
  }

  void setTapUp(){
    tapDownSprite.isVisible = false;
    buttonTextComponent.textRenderer = TextPaint(
      style: const TextStyle(fontSize: 19, color: Color.fromARGB(255, 104, 106, 115)),
    );
  }
}
