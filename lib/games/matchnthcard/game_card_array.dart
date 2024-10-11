import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'array_card.dart';
import 'game_card.dart';
import 'match_nth_card_game.dart';

class GameCardArray extends PositionComponent with HasGameRef<MatchNthCardGame> {
  GameCardArray( {required super.position, required this.round, required this.nth} );
  
  int round;
  int nth;
  late Sprite cardBack;
  //late List<Sprite> lstCards = [];
  late Sprite cardFront;
  List<int> lstCardIndices = [];
  List<ArrayCard> lstArrayCards = [];

  MatchNthCardPhase currPhase = MatchNthCardPhase.ready;

  TextComponent? roundText;
  TextComponent? missionText;
  ColorRectComponent? missionBackground;
  bool isEnd = false;

  late SpriteComponent readySprite;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.zero();
    cardBack = await gameRef.loadSprite('games/matchnthcard/cardBack.png');
    // Sprite cardSprite = await gameRef.loadSprite('games/matchnthcard/card1.png');
    // lstCards.add(cardSprite);
    // cardSprite = await gameRef.loadSprite('games/matchnthcard/card2.png');
    // lstCards.add(cardSprite);
    // cardSprite = await gameRef.loadSprite('games/matchnthcard/card3.png');
    // lstCards.add(cardSprite);
    // cardSprite = await gameRef.loadSprite('games/matchnthcard/card4.png');
    // lstCards.add(cardSprite);
    cardFront = await gameRef.loadSprite('games/matchnthcard/card_white.png');

    currPhase = MatchNthCardPhase.ready;

    readySprite = SpriteComponent(
      sprite: cardBack,
      anchor: Anchor.center,
      size: Vector2(300, 308),
    );

    add(readySprite);

    roundText = TextComponent(
      anchor: Anchor.center,
      text: 'Round $round',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 48, color: Colors.white,),
      ),
      position: readySprite.size * 0.5,
    );
    readySprite.add(roundText!);

    missionBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: Vector2(150, 240),
      size: Vector2(258, 72),
    );
    readySprite.add(missionBackground!);

    missionText = TextComponent(
      anchor: Anchor.center,
      text: '$nth번째 전 카드 맞추기',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 115, 117, 126)),
      ),
      position: missionBackground!.size * 0.5,
    );
    missionBackground!.add(missionText!);

    Future.delayed(const Duration(seconds: 2), (){
      // roundText!.text = 'START';
      // if( missionBackground != null ){
      //   readySprite.remove(missionBackground!);
      //   missionBackground = null;
      //   Future.delayed(const Duration(seconds: 2), (){
      //     createCard();
      //     nextPhase();
      //   });
      // }
      createCard();
      nextPhase();
    });

    return super.onLoad();
  }

  void nextPhase(){
    if( currPhase == MatchNthCardPhase.ready ){
      remove(readySprite);
    }
    currPhase = MatchNthCardPhase.values[currPhase.index + 1];
    nextCard();
  }

  void nextCard(){
    if( isEnd ) return;
    int cardIndex = getNextCard();

    int spriteIndex = 0;
    while(true){
      spriteIndex = Random().nextInt(lstArrayCards.length);
      if(cardIndex == lstArrayCards[spriteIndex].cardIndex){
        break;
      }
    }
    lstArrayCards[spriteIndex].flip();
  }

  void createCard(){
    for(int i=0; i<12; ++i){
      int x = i % 4;
      int y = i ~/ 4;
      double startX = -240;
      double startY = -160;
      ArrayCard card = ArrayCard(
        position: Vector2( startX + x * 160, startY + y * 160 ),
        sprite: cardBack,
        parentArray: this,
        cardFront: cardFront,
        cardIndex: i,
      );
      lstArrayCards.add(card);
      add(card);
    }
  }

  int getNextCard(){
    if(currPhase == MatchNthCardPhase.preview){
      int index = Random().nextInt(12);
      lstCardIndices.add(index);
      return index;
    } else if(currPhase == MatchNthCardPhase.game){
      bool match = Random().nextInt(2) == 0;
      int count = lstCardIndices.length;
      int index = lstCardIndices[count-nth];
      if( match ){
        lstCardIndices.add(index);
        return index;
      } else {
        while(true){
          int newIndex = Random().nextInt(12);
          if( index != newIndex){
            lstCardIndices.add(newIndex);
            return newIndex;
          }
        }        
      }
    }
    return -1;
  }

  bool isCorrect(bool isMatched){
    bool match = lstCardIndices[lstCardIndices.length-1] == lstCardIndices[lstCardIndices.length-nth-1];
    return isMatched == match;
  }
}