import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'defending_ball_game.dart';
import 'lane.dart';

enum BallType{
  blue,
  orange,
  purple,
}

class Ball extends SpriteComponent with HasGameRef<DefendingBallGame>{
  Ball( {required super.position, required this.ballIndex, required this.parentLane} );
  
  int ballIndex;
  late Sprite spriteTouch;
  late Sprite spriteVanish;
  Lane parentLane;

  bool isDefended = false;
  bool isStop = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(100);
    String ballName = BallType.values[ballIndex].name;
    sprite = await gameRef.loadSprite('games/defendingball/ball_${ballName}_def.png');
    spriteTouch = await gameRef.loadSprite('games/defendingball/ball_${ballName}_touch.png');
    spriteVanish = await gameRef.loadSprite('games/defendingball/ball_${ballName}_vanish.png');

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if( isStop ) return;
    Vector2 pos = position;
    pos.y += dt * 150;

    if( pos.y > 460 ){
      // pos.y = 460;
      // position = pos;
      // addEffect();
      // isStop = true;
      //parentLane.resetDefend();
      parentLane.checkBall(this);
    }
  }

  void addEffect(){
    sprite = isDefended ? spriteVanish : spriteTouch;
    add(
      OpacityEffect.to(0, EffectController(duration: 0.5)),
    );
  }

  void removeBall(double height, bool defend){
    isDefended = defend;
    Vector2 pos = position;
    pos.y = height;
    position = pos;
    addEffect();
    isStop = true;
  }
}
