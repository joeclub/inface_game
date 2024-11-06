import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/next_desc_button.dart';

import '../../models/base/game/game_desc_model.dart';
import 'color_rect_component.dart';
import 'game_step.dart';
import 'prev_desc_button.dart';
import 'start_button.dart';

class GameDesc extends ColorRectComponent with HasGameRef {
  GameDesc({required super.position, required this.gameDescModel, required this.parentGameStep})
      : super(
            color: const Color.fromARGB(255, 226, 226, 226),
            size: Vector2(1041, 534),
            anchor: Anchor.center);

  GameDescModel gameDescModel;
  GameStep parentGameStep;

  PositionComponent? leftParent;
  PositionComponent? rightParent;

  late ColorRectComponent leftBackground;
  late ColorRectComponent rightBackground;

  List<Sprite> lstDescSprites = [];

  List<Sprite> lstAddedSprites = [];

  int currDesc = 1;
  
  @override
  FutureOr<void> onLoad() async {
    leftBackground = ColorRectComponent(
      anchor: Anchor.centerRight,
      color: const Color.fromARGB(255, 247, 247, 247),
      position: size * 0.5 + Vector2(-4, 0),
      size: Vector2(515, 532),
    );
    add(leftBackground);

    rightBackground = ColorRectComponent(
      anchor: Anchor.centerLeft,
      color: Colors.white,
      position: size * 0.5 + Vector2(-3, 0),
      size: Vector2(522, 532),
    );
    add(rightBackground);

    if( gameDescModel.image1 != ''){
      Sprite sprite = await gameRef.loadSprite('games/${gameDescModel.image1}');
      lstDescSprites.add(sprite);
    }

    if( gameDescModel.image2 != ''){
      Sprite sprite = await gameRef.loadSprite('games/${gameDescModel.image2}');
      lstDescSprites.add(sprite);
    }

    if( gameDescModel.image3 != ''){
      Sprite sprite = await gameRef.loadSprite('games/${gameDescModel.image3}');
      lstDescSprites.add(sprite);
    }

    if( gameDescModel.addImage1 != null ){
      for( int i=0; i<gameDescModel.addImage1!.length; ++i){
        Sprite sprite = await gameRef.loadSprite('games/${gameDescModel.addImage1![i]}');
        lstAddedSprites.add(sprite);
      }
    }
    
    
    createDesc(currDesc);

    return super.onLoad();
  }

  onClickStart(){
    parentGameStep.startGame();
  }

  createDesc(int desc){
    if( leftParent != null ){
      leftBackground.remove(leftParent!);
    }

    if( rightParent != null ){
      rightBackground.remove(rightParent!);
    }

    leftParent = PositionComponent(
      anchor: Anchor.center,
      position: Vector2.zero(),//leftBackground.size * 0.5,
    );
    leftBackground.add(leftParent!);

    rightParent = PositionComponent(
      anchor: Anchor.center,
      position: Vector2.zero(),//rightBackground.size * 0.5,
    );
    rightBackground.add(rightParent!);

    List<String> descTextList = [];
    if( desc == 1 ){
      descTextList = gameDescModel.desc1;
    } else if ( desc == 2) {
      descTextList = gameDescModel.desc2;
    } else {
      descTextList = gameDescModel.desc3;
    }

    double margin = 0;

    double lastTextY = 0;

    for( int i=0; i<descTextList.length; ++i){
      if( descTextList[i] == '' ) margin += ( gameDescModel.descMargin != null ) ? gameDescModel.descMargin! : 0;
      lastTextY = 30 + i * 21 + margin;
      TextComponent descText = TextComponent(
        anchor: Anchor.centerLeft,
        text: descTextList[i],
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 4, 25)),
        ),
        position: Vector2(30, lastTextY),
      );
      leftParent!.add(descText);
    }

    lastTextY += ( gameDescModel.descEndMargin != null ) ? gameDescModel.descEndMargin! : 50; 

    if( desc == 1 ){
      if(gameDescModel.addImage1 != null){
        for( int i=0; i<lstAddedSprites.length; ++i){
          SpriteComponent addedSprite = SpriteComponent(
            anchor: Anchor.center,
            position: Vector2(gameDescModel.addImage1PosX![i].toDouble(), gameDescModel.addImage1PosY![i].toDouble()),
            size: Vector2(gameDescModel.addImage1SizeX![i].toDouble(), gameDescModel.addImage1SizeY![i].toDouble()),
            sprite: lstAddedSprites[i],
          );
          addedSprite.paint.filterQuality = FilterQuality.high;
          leftParent!.add(addedSprite);
        }
      }
    }

    TextComponent descText = TextComponent(
      anchor: Anchor.centerLeft,
      text: (desc == gameDescModel.descCount) ? '위의 내용을 완전히 이해했으면, 게임을 시작하세요.' : '현재 설명 내용을 완전히 이해했으며, 다음 설명으로 넘어갑니다.',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 4, 25), fontWeight: FontWeight.bold),
      ),
      position: Vector2(30, lastTextY),
    );
    leftParent!.add(descText);

    if( gameDescModel.descCount == 1 ){
      StartButton startButton = StartButton(
        position: Vector2(leftBackground.size.x * 0.5, 480),
        parentGameDesc: this,
      );
      leftParent!.add(startButton);
    } else {
      if( desc < gameDescModel.descCount ) {
        if( desc == 1 ){
          NextDescButton nextDescButton = NextDescButton(
            position: Vector2(leftBackground.size.x * 0.5, 480),
            parentGameDesc: this,
            currDesc: desc,
            numDesc: gameDescModel.descCount,
          );
          leftParent!.add(nextDescButton);
        } else {
          PrevDescButton prevDescButton = PrevDescButton(
            position: Vector2(leftBackground.size.x * 0.5, 480) + Vector2( -80, 0),
            parentGameDesc: this,
          );
          leftParent!.add(prevDescButton);

          NextDescButton nextDescButton = NextDescButton(
            position: Vector2(leftBackground.size.x * 0.5, 480) + Vector2( 80, 0),
            parentGameDesc: this,
            currDesc: desc,
            numDesc: gameDescModel.descCount,
          );
          leftParent!.add(nextDescButton);
        }
      } else {
        PrevDescButton prevDescButton = PrevDescButton(
          position: Vector2(leftBackground.size.x * 0.5, 480) + Vector2( -80, 0),
          parentGameDesc: this,
        );
        leftParent!.add(prevDescButton);

        StartButton startButton = StartButton(
          position: Vector2(leftBackground.size.x * 0.5, 480) + Vector2( 80, 0),
          parentGameDesc: this,
        );
        leftParent!.add(startButton);
      }
    }

    Vector2 imagePos = Vector2.zero();
    if( desc == 1 ){
      imagePos = Vector2(gameDescModel.image1SizeX.toDouble(), gameDescModel.image1SizeY.toDouble());
    } else if ( desc == 2) {
      imagePos = Vector2(gameDescModel.image2SizeX.toDouble(), gameDescModel.image2SizeY.toDouble());
    } else {
      imagePos = Vector2(gameDescModel.image3SizeX.toDouble(), gameDescModel.image3SizeY.toDouble());
    }

    SpriteComponent descSprite = SpriteComponent(
      anchor: Anchor.center,
      position: rightBackground.size * 0.5,
      size: imagePos,
      sprite: lstDescSprites[desc-1],
    );
    descSprite.paint.filterQuality = FilterQuality.high;
    rightParent!.add(descSprite);

    TextComponent exText = TextComponent(
      anchor: Anchor.centerLeft,
      text: '예시',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: Vector2(480, 20),
    );
    rightParent!.add(exText);
  }
}