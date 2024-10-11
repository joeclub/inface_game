import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'find_temperature_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<FindTemperatureGame>, HasVisibility, TapCallbacks {
  AnswerButton({required super.position});

  late Sprite spriteDefault;
  late Sprite spriteRight;
  late Sprite spriteWrong;

  bool isRight = false;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2.all(60);
    sprite = spriteDefault = await gameRef.loadSprite('games/findtile/btn_next_gray.png');
    spriteRight = await gameRef.loadSprite('games/findtile/btn_next_green.png');
    spriteWrong = await gameRef.loadSprite('games/findtile/btn_next_red.png');

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    sprite = spriteDefault;

    if( isRight ){
      gameRef.currScore += 100;
    }
    gameRef.gameStep.updateScore(gameRef.currScore);
    gameRef.resetGame();
  }

  void setRight(bool isRight){
    this.isRight = isRight;
    sprite = isRight ? spriteRight : spriteWrong;
  }
}
