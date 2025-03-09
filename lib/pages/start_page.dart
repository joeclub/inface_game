import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:inface/game_manager.dart';
import 'package:inface/routes/app_router.gr.dart';


@RoutePage()
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();

    AutoRouter.of(context).replace(const SplashRoute());
    //GameManager().playNextGame(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
