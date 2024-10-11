import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'match_nth_card_game.dart';

class AnswerButton extends SpriteComponent with HasGameRef<MatchNthCardGame>, TapCallbacks, HasVisibility {
  AnswerButton({required super.position, required this.isLeft});

  bool isLeft;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    String spriteName = isLeft ? 'left_key' : 'right_key';
    size = Vector2.all(45);
    sprite = await gameRef.loadSprite('games/common/$spriteName.png');
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onClick();
  }

  void onClick(){
    gameRef.checkCard(isLeft);
  }
}
