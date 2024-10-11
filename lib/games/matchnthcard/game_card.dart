import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/color_rect_component.dart';

import 'match_nth_card_game.dart';

enum MatchNthCardPhase{
  ready,
  preview,
  game,
}

class GameCard extends SpriteComponent with HasGameRef<MatchNthCardGame>, HasVisibility {
  GameCard( {required super.position, required this.round, required this.nth} );
  
  int round;
  int nth;
  late Sprite cardBack;
  late List<Sprite> lstCards = [];
  List<int> lstCardIndices = [];

  MatchNthCardPhase currPhase = MatchNthCardPhase.ready;

  TextComponent? roundText;
  TextComponent? missionText;
  ColorRectComponent? missionBackground;
  bool isEnd = false;
  
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(300, 308);
    cardBack = await gameRef.loadSprite('games/matchnthcard/cardBack.png');
    Sprite cardSprite = await gameRef.loadSprite('games/matchnthcard/card1.png');
    lstCards.add(cardSprite);
    cardSprite = await gameRef.loadSprite('games/matchnthcard/card2.png');
    lstCards.add(cardSprite);
    cardSprite = await gameRef.loadSprite('games/matchnthcard/card3.png');
    lstCards.add(cardSprite);
    cardSprite = await gameRef.loadSprite('games/matchnthcard/card4.png');
    lstCards.add(cardSprite);

    sprite = cardBack;

    currPhase = MatchNthCardPhase.ready;

    roundText = TextComponent(
      anchor: Anchor.center,
      text: 'Round $round',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 48, color: Colors.white,),
      ),
      position: size * 0.5,
    );
    add(roundText!);

    missionBackground = ColorRectComponent(
      anchor: Anchor.center,
      color: Colors.white,
      position: Vector2(150, 240),
      size: Vector2(258, 72),
    );
    add(missionBackground!);

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
      //   remove(missionBackground!);
      //   missionBackground = null;
      //   Future.delayed(const Duration(seconds: 2), (){
      //     nextPhase();
      //   });
      // }
      nextPhase();
    });

    return super.onLoad();
  }

  void nextPhase(){
    if( currPhase == MatchNthCardPhase.ready ){
      if( roundText != null ){
        remove(roundText!);
      }

      if( missionBackground != null ){
        remove(missionBackground!);
      }
    }
    currPhase = MatchNthCardPhase.values[currPhase.index + 1];
    nextCard();
  }

  void nextCard(){
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          if( isEnd ) return;
          int cardIndex = getNextCard();
          sprite = lstCards[cardIndex];
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
                if( isEnd ) return;
                if(currPhase == MatchNthCardPhase.game){
                  gameRef.showAnswerButton(true);
                }
                
                Future.delayed(const Duration(seconds: 3), (){
                  if( isEnd ) return;
                  if( lstCardIndices.length == nth){
                    nextPhase();
                  } else {
                    nextCard();
                  }
                  
                  if(currPhase == MatchNthCardPhase.game){
                    gameRef.showAnswerButton(false);
                    gameRef.correctBox.hide();
                  }
                });
              }
            ),
          );
        }
      )
    );
  }

  int getNextCard(){
    if(currPhase == MatchNthCardPhase.preview){
      int index = Random().nextInt(lstCards.length);
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
          int newIndex = Random().nextInt(lstCards.length);
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