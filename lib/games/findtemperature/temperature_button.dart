import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'find_temperature_game.dart';

class TemperatureButton extends SpriteComponent with HasGameRef<FindTemperatureGame>, HasVisibility, TapCallbacks {
  TemperatureButton( {required super.position, required this.spriteDefault, required this.spritePressed, required this.isSun} );
  
  Sprite spriteDefault;
  Sprite spritePressed;
  bool isTappable = false;
  bool isSun;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(186, 66);
    sprite = spriteDefault;

    return super.onLoad();
  }
  
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    if( isTappable == false ) return;

    sprite = spritePressed;
    gameRef.tapButton(isSun);
  }

  void reset(){
    sprite = spriteDefault;
  }
}