import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'defending_ball_game.dart';


@RoutePage()
class DefendingBallPage extends StatefulWidget {
  const DefendingBallPage({super.key});

  @override
  State<DefendingBallPage> createState() => _DefendingBallPageState();
}

class _DefendingBallPageState extends State<DefendingBallPage> {
  
  final DefendingBallGame _game = DefendingBallGame();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameBackButton.context = context;
    return GameWidget(
      game: _game,
    );
  }
}
