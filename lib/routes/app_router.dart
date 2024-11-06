import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.cupertino(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StartRoute.page,
          path: '/',
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: SplashRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: StackBallRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: SortBallRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: CardFlipRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: BlowBalloonRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ChangeDirectionRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchTextColorRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchNthCardRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: EmotionFitRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: StackingBoxesRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchWeatherRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchCharacterCodeRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchMouthLengthRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchEmotionRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: DefendingBallRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: FindTileRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: FindTemperatureRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: SelectShapeRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ComparePatternRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ComparePrevCardRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ConnectHappinessCardRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ControlButtonRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: TrafficLightRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: ComparePictureRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchClipRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: CompareFigureRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
        AutoRoute(
          page: MatchPuzzleRoute.page,
          type: const CustomRouteType(
              transitionsBuilder: TransitionsBuilders.noTransition),
        ),
      ];
}
