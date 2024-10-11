import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../components/color_rect_component.dart';
import 'match_weather_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<MatchWeatherGame>, TapCallbacks, HasVisibility {
  AnswerButton({required super.position, required this.isSunny});

  bool isSunny;
  late Sprite normalSprite;
  late Sprite pressSprite;

  ColorRectComponent? correct; 

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    String spriteName = isSunny ? 'btn_w_good' : 'btn_w_bad';
    String pressSpriteName = isSunny ? 'btn_w_good_press' : 'btn_w_bad_press';
    size = Vector2(180, 60);
    normalSprite = sprite = await gameRef.loadSprite('games/matchweather/$spriteName.png');
    pressSprite = await gameRef.loadSprite('games/matchweather/$pressSpriteName.png');
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    setTapUp();
    gameRef.checkAnswer(isSunny);
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
    sprite = pressSprite;
  }

  void setTapUp(){
    sprite = normalSprite;
  }

  void addColor(bool isCorrect){
    if( correct != null ) remove(correct!);
    correct = ColorRectComponent(
      color: isCorrect ? const Color.fromARGB(128, 0, 255, 0) : const Color.fromARGB(128, 255, 0, 0),
      position: size * 0.5,
      size: size,
      anchor: Anchor.center
    );
    add(correct!);
  }

  void removeColor(){
    if( correct != null ) remove(correct!);
    correct = null;
  }
}
