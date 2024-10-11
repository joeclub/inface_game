import 'dart:async';

import 'package:flame/components.dart';

class CorrectEffect extends SpriteComponent with HasGameRef {
  CorrectEffect({required super.position, required this.isCorrect, required this.isLeft});
  bool isCorrect;
  bool isLeft;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(34, 34);

    String incorrectSpriteName = isLeft ? "leftError" : "rightError";
    String spriteName = isCorrect ? "complite" : incorrectSpriteName;

    sprite = await gameRef.loadSprite('games/changedirection/$spriteName.png');

    

    if( isCorrect == false ){
      String maleSpriteName = isLeft ? "errorRIghtArrow" : "errorLeftArrow";
      Sprite maleSprite = await gameRef.loadSprite('games/changedirection/$maleSpriteName.png');
      //Vector2 offset = Vector2(isLeft ? -17 : 17, 0);
      add(
        SpriteComponent(
          sprite: maleSprite,
          position: size * 0.5,// + offset,
          anchor: isLeft ? Anchor.centerRight : Anchor.centerLeft,
          size: Vector2(17, 34),
        )
      );
    }

    String spriteAlphaName = isCorrect ? "greenCircle" : "redCircle";
    Sprite spriteAlpha = await gameRef.loadSprite('games/changedirection/$spriteAlphaName.png');

    add(
        SpriteComponent(
          sprite: spriteAlpha,
          position: size * 0.5,
          anchor: Anchor.center,
          size: Vector2(68, 68),
        )
      );

    return super.onLoad();
  }
}