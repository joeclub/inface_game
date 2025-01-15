import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inface/game_manager.dart';
import 'package:inface/providers/manager_provider.dart';
import 'package:inface/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

final appRouter = AppRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //usePathUrlStrategy();
  setUrlStrategy(XDPathUrlStrategy());

  var uri = Uri.dataFromString(window.location.href);
  Map<String, String> params = uri.queryParameters;
  var id = params['id'];
  var game = params['game'];
  var ep = params['ep'];
  List<String> games = [];
  if( game == null ){
    games = ["1", "2", "3", "4", "5"];
  } else {
    games = game.split(",");
  }
  String id2 = 'aa';
  if( id != null ){
    id2 = id;
  }

  String ep2 = '0';
  if( ep != null ){
    ep2 = ep;
  }

  GameManager().id = id2;
  GameManager().ep = ep2;
  GameManager().lstGames = games;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GameManager().context = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ManagerProvider(),
          lazy: false,
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(600, 1000),
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'inface',
              routerConfig: appRouter.config(),
              //scaffoldMessengerKey: scaffoldMessengerKey,
              theme: ThemeData(
                //timePickerTheme: bbTimePickerTheme,
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.blue,
                //fontFamily: 'Pretendard',
              ),
            );
          }),
    );
  }
}

class XDPathUrlStrategy extends HashUrlStrategy {
  /// Creates an instance of [PathUrlStrategy].
  ///
  /// The [PlatformLocation] parameter is useful for testing to mock out browser
  /// interactions.
  XDPathUrlStrategy([
    super.platformLocation,
  ]) : _basePath = stripTrailingSlash(extractPathname(checkBaseHref(
          platformLocation.getBaseHref(),
        )));

  final String _basePath;

  @override
  String prepareExternalUrl(String internalUrl) {
    if (internalUrl.isNotEmpty && !internalUrl.startsWith('/')) {
      internalUrl = '/$internalUrl';
    }
    return '$_basePath/';
  }
}
