import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'defending_ball_game.dart';


@RoutePage()
class DefendingBallPage extends StatefulWidget {
  const DefendingBallPage({super.key});

  @override
  State<DefendingBallPage> createState() => _DefendingBallPageState();
}

class _DefendingBallPageState extends State<DefendingBallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: DefendingBallGame(context: context),
    );
  }
}
