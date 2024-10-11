import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import '../routes/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   _asyncInitState();    
    // });
  }

  // _asyncInitState() async {
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("스플래쉬"),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const StackBallRoute());
                },
                child: const Text("공 옮기기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const SortBallRoute());
                },
                child: const Text("무거운 순서대로 나열하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const CardFlipRoute());
                },
                child: const Text("카드 뒤집기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const BlowBalloonRoute());
                },
                child: const Text("풍선 불기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ChangeDirectionRoute());
                },
                child: const Text("방향 바꾸기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchTextColorRoute());
                },
                child: const Text("단어의 색-의미 분류"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchNthCardRoute());
                },
                child: const Text("N번째 카드 맞추기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const EmotionFitRoute());
                },
                child: const Text("감정 맞히기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const StackingBoxesRoute());
                },
                child: const Text("상자 쌓기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchWeatherRoute());
                },
                child: const Text("날씨 맞추기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchCharacterCodeRoute());
                },
                child: const Text("문자 코드 분류하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchMouthLengthRoute());
                },
                child: const Text("입 길이 판단하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchEmotionRoute());
                },
                child: const Text("같은 감정 맞히기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const DefendingBallRoute());
                },
                child: const Text("공 막아 내기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const FindTileRoute());
                },
                child: const Text("타일 위치 기억하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const FindTemperatureRoute());
                },
                child: const Text("기온 맞히기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const SelectShapeRoute());
                },
                child: const Text("도형 고르기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ComparePatternRoute());
                },
                child: const Text("패턴 비교하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ComparePrevCardRoute());
                },
                child: const Text("이전 카드와 비교하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ConnectHappinessCardRoute());
                },
                child: const Text("행복카드 연결하기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ControlButtonRoute());
                },
                child: const Text("버튼 조작"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const TrafficLightRoute());
                },
                child: const Text("신호등"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const ComparePictureRoute());
                },
                child: const Text("그림 비교"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const MatchClipRoute());
                },
                child: const Text("클립맞히기"),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const CompareFigureRoute());
                },
                child: const Text("도형 비교"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
