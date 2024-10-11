import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'sort_ball_game.dart';

@RoutePage()
class SortBallPage extends StatefulWidget {
  const SortBallPage({super.key});

  @override
  State<SortBallPage> createState() => _SortBallPageState();
}

class _SortBallPageState extends State<SortBallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SortBallGame(context: context),
    );
  }
}
