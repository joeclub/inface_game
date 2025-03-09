import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'ball.dart';
import 'defending_ball_game.dart';

enum LaneType{
  blue,
  orange,
  purple,
}

class Lane extends SpriteComponent with HasGameRef<DefendingBallGame>, TapCallbacks {
  Lane( {required super.position, required this.laneIndex, required this.reset} );
  
  int laneIndex;
  double lifeTime = 20;
  double ballInterval = 2;
  bool isLifeEnd = false;

  double currTime = 0;
  double currLifeTime = 0;
  double time = 0;
  Queue<Ball> ballQueue = Queue<Ball>();

  late ClipComponent clipComponent;

  bool isDefend = false;
  bool reset;
  late SpriteComponent defendSpriteComponent;
  int score = 10;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(100, 480);
    String laneName = LaneType.values[laneIndex].name;
    sprite = await gameRef.loadSprite('games/defendingball/lane_$laneName.png');

    Sprite lineSprite = await gameRef.loadSprite('games/defendingball/goleline_default.png');
    add(
      SpriteComponent(
        sprite: lineSprite,
        position: Vector2(50, 480),
        size: Vector2(100, 54),
        anchor: Anchor.bottomCenter,
      ),
    );

    Sprite defendSprite = await gameRef.loadSprite('games/defendingball/goleline_highlight.png');
    defendSpriteComponent = SpriteComponent(
      sprite: defendSprite,
      position: Vector2(50, 480),
      size: Vector2(100, 94),
      anchor: Anchor.bottomCenter,
    );
    //add(defendSpriteComponent);

    clipComponent = ClipComponent.rectangle(
      position: Vector2.zero(),
      size: size,
    );
    add(clipComponent);

    score = gameRef.isSecondHalf ? 20 : 10;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if( gameRef.showEndGamePopup ) return;

    if( isLifeEnd ) return;

    currTime += dt;
    currLifeTime += dt;

    if( currLifeTime > lifeTime ){
      isLifeEnd = true;
      gameRef.removeLane(this, reset);
    }

    if( currTime > ballInterval ){
      currTime = 0;
      createBall();
    }

    if( ballQueue.isEmpty == false ){
      Ball ball = ballQueue.first;
      if( ball.position.y > 400 ){
        if( isDefend ){
          bool defendSuccess = laneIndex != ball.ballIndex;
          ball.removeBall(400, defendSuccess);
          gameRef.addScore(defendSuccess ? score : -score);
          isDefend = false;
          remove(defendSpriteComponent);
        }
        ballQueue.removeFirst();
      }
    }
  }

  void createBall(){
    int ballIndex = Random().nextInt(BallType.values.length);
    Ball ball = Ball(
      position: Vector2(50, -50),
      ballIndex: ballIndex,
      parentLane: this,
    );
    clipComponent.add(ball);
    ballQueue.add(ball);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( isDefend == false ){
      isDefend = true;
      add(defendSpriteComponent);
    }
  }

  void checkBall(Ball ball){
    bool defendSuccess = laneIndex == ball.ballIndex;
    ball.removeBall(460, defendSuccess);
    gameRef.addScore(defendSuccess ? score : -score);
    resetDefend();
  }

  void resetDefend(){
    if( isDefend == true ){
      isDefend = false;
      remove(defendSpriteComponent);
    }
  }

  void removeBall(Ball ball){
    clipComponent.remove(ball);
  }
}