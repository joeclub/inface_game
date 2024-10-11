import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'sort_ball_game.dart';

class Ball extends SpriteComponent with HasGameRef<SortBallGame>, DragCallbacks {
  Ball( {required super.position, required this.weight, required this.ballIndex} );
  
  bool dragStart = false;
  int ballIndex;
  int weight;
  Vector2 oldPos = Vector2.zero();
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(50);
    sprite = await gameRef.loadSprite('games/sortball/ball$ballIndex.png');
    oldPos = Vector2.copy(position);
    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    gameRef.ballDragStart(this);
    super.onDragStart(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (gameRef.setBall(this)) {
    } else {
      position = Vector2.copy(oldPos);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }
}
