import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'control_button_game.dart';

@RoutePage()
class ControlButtonPage extends StatefulWidget {
  const ControlButtonPage({super.key});

  @override
  State<ControlButtonPage> createState() => _ControlButtonPageState();
}

class _ControlButtonPageState extends State<ControlButtonPage> {

  final ControlButtonGame _game = ControlButtonGame(hasFirstHalfScore: false, hasRoundScore: false, isEP: false);

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
