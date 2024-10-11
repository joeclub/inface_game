import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'stack_ball_game.dart';

@RoutePage()
class StackBallPage extends StatefulWidget {
  const StackBallPage({super.key});

  @override
  State<StackBallPage> createState() => _StackBallPageState();
}

class _StackBallPageState extends State<StackBallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: StackBallGame(context: context),
    );
  }
}
