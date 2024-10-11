import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'connect_happiness_card_game.dart';

enum CardState
{
  closed,
  start,
  end,
  happiness,
  unhappiness,
  success,
  fail,
}

class GameCard extends SpriteComponent with HasGameRef<ConnectHappinessCardGame>, TapCallbacks, HasVisibility {
  GameCard( {required super.position, required this.cardIndex, required this.state} );
  
  late Sprite closed;
  late Sprite happiness;
  late Sprite unhappiness;
  late Sprite success;
  late Sprite fail;

  final int cardIndex;
  bool isFlipped = false;

  CardState state;

  List<GameCard?> lstNeighbor = [];
  bool traverse = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(100, 130);
    closed = await gameRef.loadSprite('games/connecthappinesscard/card_default.png');
    happiness = await gameRef.loadSprite('games/connecthappinesscard/card_yellow.png');
    unhappiness = await gameRef.loadSprite('games/connecthappinesscard/card_red.png');
    success = await gameRef.loadSprite('games/connecthappinesscard/card_blue.png');
    fail = await gameRef.loadSprite('games/connecthappinesscard/card_gray.png');
    sprite = closed;
    isVisible = false;
    init();
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if( gameRef.isStageEnding ) return;
    if( state != CardState.closed ) return;

    bool allClosed = true;
		for (int i = 0; i < lstNeighbor.length; ++i)
		{
			if (lstNeighbor[i]!.state != CardState.closed)
			{
				allClosed = false;
				break;
			}
		}

		if (allClosed) return;

		bool happy = gameRef.checkHappiness(this);
		setState((happy?CardState.happiness:CardState.unhappiness));
		gameRef.checkConnect();

    //flip(force: false, flipSprite: happiness);
  }

  void init(){
    add(
      OpacityEffect.fadeOut(EffectController(
        duration: 0,
      ),
      onComplete: (){
        isVisible = true;
        add(
          OpacityEffect.fadeIn(EffectController(
            duration: 0.2,
          ),
        ));
      })
    );
  }

  void setState(CardState state){
    this.state = state;
    Sprite flipSprite = closed;
    switch(state){
      case CardState.closed: flipSprite = closed; break;
      case CardState.start: flipSprite = happiness; break;
      case CardState.end: flipSprite = happiness; break;
      case CardState.happiness: flipSprite = happiness; break;
      case CardState.unhappiness: flipSprite = unhappiness; break;
      case CardState.success: flipSprite = success; break;
      case CardState.fail: flipSprite = fail; break;
    }
    flip(force: false, flipSprite: flipSprite);
  }

  void flip({bool force = false, required Sprite flipSprite}){
    //if( isFlipped == true ) return;

    //if( gameRef.isTweening == true && force == false) return;

    //isFlipped = true;
    add(
      ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.2),
        onComplete: (){
          sprite = flipSprite;
          add(
            ScaleEffect.to(
              Vector2(1, 1),
              EffectController(duration: 0.2),
              onComplete: (){
              }
            )
          );
        }
      )
    );
  }
}