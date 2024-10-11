import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:inface/routes/app_router.gr.dart';

import 'educe_game.dart';

class GameBackButton extends SpriteComponent with HasGameRef<EduceGame>, TapCallbacks {
  BuildContext context;
  GameBackButton({required super.position, required this.context});

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    String spriteName = 'left_key';
    size = Vector2.all(50);
    sprite = await gameRef.loadSprite('games/common/$spriteName.png');
    return super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    //Flame.device.setOrientation(DeviceOrientation.portraitUp);
    
    //AutoRouter.of(context).back();
    //AutoRouter.of(context).maybePop<bool>(true);
    //AutoRouter.of(context).replaceAll([const SplashRoute()]);
    AutoRouter.of(context).popUntil((route) => route.settings.name == 'SplashRoute');
    AutoRouter.of(context).maybePop();
    AutoRouter.of(context).push(const SplashRoute());
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
