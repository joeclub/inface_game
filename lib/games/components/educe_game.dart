import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:inface/game_manager.dart';
import 'package:inface/services/game/send_game_score_service.dart';
//import 'package:flutter/services.dart';

import 'background.dart';
import 'end_game_popup.dart';

class EduceGame extends FlameGame {
  final screenSize = Vector2(1280, 720);
  BuildContext? context;

  int currScore = 0;
  int currRound = 0;

  double currTime = 0;
  bool isInit = false;

  bool isLoadedGame = false;

  bool isEP;
  bool isNextGame = false;

  bool showEndGamePopup = false;

  bool hasFirstHalfScore;
  bool hasRoundScore;
  bool isSecondHalf = false;

  bool sendFirstHalfScore = false;

  EduceGame({this.hasFirstHalfScore = true, this.hasRoundScore = false, this.isEP = false})
  {
    isEP = GameManager().ep == '1';
  }
  
  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    //Flame.device.setOrientation(DeviceOrientation.landscapeRight);
    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    // add(
    //   TimerComponent(
    //     period: 1,
    //     repeat: true,
    //     autoStart: true,
    //     onTick: (){
    //       if( isNextGame == true){
    //         GameManager().playNextGame(context!);
    //       }
    //     }
    //   )
    // );

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

  @override
  void update(double dt) {
    super.update(dt);

    if( isSecondHalf == true ){
      if( sendFirstHalfScore == false) {
        SendGameScoreService sendGameScoreService = SendGameScoreService();
        if( hasRoundScore ){
          sendGameScoreService.getGameScoreWithRound(
            userId: GameManager().id,
            gameId: GameManager().lstGames[GameManager().currGame],
            half: 1,
            score: currScore,
            round: currRound,
          );
        } else {
          sendGameScoreService.getGameScore(
            userId: GameManager().id,
            gameId: GameManager().lstGames[GameManager().currGame],
            half: 1,
            score: currScore
          );
        }
        sendFirstHalfScore = true;
      }
    }
  }

  void initGame(){

  }

  void resetGame(){
  }

  void endGame(){
    isNextGame = true;

    bool isEndGame = GameManager().currGame + 1 == GameManager().lstGames.length;

    if( showEndGamePopup == false ){
      SendGameScoreService sendGameScoreService = SendGameScoreService();
      if( isEndGame == false ) {
        EndGamePopup endGamePopup = EndGamePopup(
          position: Vector2(640, 360),
          point: currScore,
        );
        world.add(endGamePopup);

        if( hasRoundScore ){
          sendGameScoreService.getGameScoreWithRound(
            userId: GameManager().id,
            gameId: GameManager().lstGames[GameManager().currGame],
            half: 2,
            score: currScore,
            round: currRound,
          );
        } else {
          sendGameScoreService.getGameScore(
            userId: GameManager().id,
            gameId: GameManager().lstGames[GameManager().currGame],
            half: 2,
            score: currScore
          );
        }
      } else {
        sendGameScoreService.getGameComplete(userId: GameManager().id );
      }
      
      showEndGamePopup = true;
    }
    
  }
}
