import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'routes/app_router.gr.dart';

class GameManager {
  static final GameManager _instance = GameManager._internal();

  factory GameManager()=>_instance;
  GameManager._internal();

  String id = '';
  String ep = '';
  List<String> lstGames = [];
  int currGame = -1;
  BuildContext? context;

  void playNextGame(BuildContext context){
    this.context = context;
    currGame++;
    if( currGame >= lstGames.length ) return;
    String strGameIndex = lstGames[currGame];
    switch(strGameIndex){
      // "공 옮기기"
      case '1':{
        setGame(const StackBallRoute());
      }
      break;
      // "무거운 순서대로 나열하기"
      case '2':{
        setGame(const SortBallRoute());
      }
      break;
      // "카드 뒤집기"
      case '3':{
        setGame(const CardFlipRoute());
      }
      // "풍선 불기"
      case '4':{
        setGame(const BlowBalloonRoute());
      }
      break;
      // "방향 바꾸기"
      case '5':{
        setGame(const ChangeDirectionRoute());
      }
      // "단어의 색-의미 분류"
      case '6':{
        setGame(const MatchTextColorRoute());
      }
      break;
      // "N번째 카드 맞추기"
      case '7':{
        setGame(const MatchNthCardRoute());
      }
      break;
      // "감정 맞히기"
      case '8':{
        setGame(const EmotionFitRoute());
      }
      break;
      // "상자 쌓기"
      case '9':{
        setGame(StackingBoxesRoute());
      }
      break;
      // "날씨 맞히기"
      case '10':{
        setGame(const MatchWeatherRoute());
      }
      break;
      // "문자 코드 분류하기"
      case '11':{
        setGame(const MatchCharacterCodeRoute());
      }
      break;
      // "입 길이 판단하기"
      case '12':{
        setGame(const MatchMouthLengthRoute());
      }
      break;
      // "도형 비교"
      case '13':{
        setGame(const CompareFigureRoute());
      }
      break;
      // "신호등"
      case '14':{
        setGame(const TrafficLightRoute());
      }
      break;
      // "퍼즐 맞추기"
      case '15':{
        setGame(const MatchPuzzleRoute());
      }
      break;
      // "그림 비교"
      case '16':{
        setGame(const ComparePictureRoute());
      }
      break;
      // "클립맞히기"
      case '17':{
        setGame(const MatchClipRoute());
      }
      break;
      // "버튼 조작"
      case '18':{
        setGame(const ControlButtonRoute());
      }
      break;
      // "같은 감정 맞히기"
      case '21':{
        setGame(const MatchEmotionRoute());
      }
      break;
      // "공 막아 내기"
      case '22':{
        setGame(const DefendingBallRoute());
      }
      break;
      // "타일 위치 기억하기"
      case '23':{
        setGame(const FindTileRoute());
      }
      break;
      // "기온 맞히기"
      case '24':{
        setGame(const FindTemperatureRoute());
      }
      break;
      // "도형 고르기"
      case '25':{
        setGame(const SelectShapeRoute());
      }
      break;
      // "패턴 비교하기"
      case '26':{
        setGame(const ComparePatternRoute());
      }
      break;
      // "이전 카드와 비교하기"
      case '27':{
        setGame(const ComparePrevCardRoute());
      }
      break;
      // "카메라 위치 찾기"
      case '28':{
        return;
      }
      // "행복카드 연결하기"
      case '29':{
        setGame(const ConnectHappinessCardRoute());
      }
      break;
      default: return;
    }
  }

  void setGame(PageRouteInfo route){
    AutoRouter.of(context!).replace(route);
  }
}