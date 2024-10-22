import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'stack_ball_game.dart';

@RoutePage()
class StackBallPage extends StatefulWidget {
  const StackBallPage({super.key});

  @override
  State<StackBallPage> createState() => _StackBallPageState();
}

class _StackBallPageState extends State<StackBallPage> {
  
  final StackBallGame _game = StackBallGame();

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
