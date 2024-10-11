import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'connect_happiness_card_game.dart';

class SelectButton extends SpriteComponent with HasGameRef<ConnectHappinessCardGame>, TapCallbacks {
  SelectButton({required super.position});

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(260, 70);
    sprite = await gameRef.loadSprite('games/connecthappinesscard/btn_fin.png');
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if( gameRef.isStageEnding ) return;
    gameRef.onClickConfirm();
  }
}
