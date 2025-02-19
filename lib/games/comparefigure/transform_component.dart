import 'dart:async';

import 'package:flame/components.dart';

import 'compare_figure_game.dart';

class TransformComponent extends SpriteComponent with HasGameRef<CompareFigureGame> {
  TransformComponent({required super.position, required this.lstTransforms});
  
  List<bool> lstTransforms;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(60, 78);
    sprite = gameRef.operatorSprite0;

    Sprite dot = await gameRef.loadSprite('games/comparefigure/dot.png');

    for( int i=0; i<lstTransforms.length; ++i) {
      if(lstTransforms[i] == false ) continue;
      SpriteComponent spriteComponent = SpriteComponent(
        anchor: Anchor.center,
        position: size * 0.5 + Vector2(0, -25 + i * 25 ),
        size: Vector2.all(16),
        sprite: dot,
      );
      add(spriteComponent);
    }

    return super.onLoad();
  }
  
}