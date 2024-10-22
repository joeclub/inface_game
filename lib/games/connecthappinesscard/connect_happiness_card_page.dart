import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'connect_happiness_card_game.dart';

@RoutePage()
class ConnectHappinessCardPage extends StatefulWidget {
  const ConnectHappinessCardPage({super.key});

  @override
  State<ConnectHappinessCardPage> createState() => _ConnectHappinessCardPageState();
}

class _ConnectHappinessCardPageState extends State<ConnectHappinessCardPage> {

  final ConnectHappinessCardGame _game = ConnectHappinessCardGame();

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
