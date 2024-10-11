import 'dart:async';

import 'package:flame/components.dart';
import 'package:inface/games/blowballoon/pump_count.dart';

class Pump extends SpriteComponent with HasGameRef {
  Pump({required super.position});

  late PumpCount pumpCount;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = Vector2(430, 165);
    sprite = await gameRef.loadSprite('games/blowballoon/pump.png');
    pumpCount = PumpCount(position: Vector2(size.x * 0.5, 110));
    add(pumpCount);
    return super.onLoad();
  }

  void setPumpCount(int count){
    pumpCount.setPumpCount(count);
  }
}
