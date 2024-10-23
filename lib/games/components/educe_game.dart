import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'background.dart';

class EduceGame extends FlameGame {
  final screenSize = Vector2(1280, 720);
  BuildContext? context;

  int currScore = 0;
  int currRound = 0;

  double currTime = 0;
  bool isInit = false;

  bool isLoadedGame = false;

  EduceGame();
  
  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    //Flame.device.setOrientation(DeviceOrientation.landscapeRight);
    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    camera.viewport = FixedResolutionViewport(resolution: screenSize);
    camera.backdrop.add(Background(size: screenSize));

    camera.moveTo(screenSize * 0.5);
    super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);

  //   if( isInit == false ){
  //     currTime += dt;
  //     if( currTime > 4.1 ){
  //       initGame();
  //       resetGame();
  //       isInit = true;
  //     }
  //   }
  // }

  void initGame(){

  }

  void resetGame(){
  }
}
