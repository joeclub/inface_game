import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'connect_happiness_card_game.dart';

@RoutePage()
class ConnectHappinessCardPage extends StatefulWidget {
  const ConnectHappinessCardPage({super.key});

  @override
  State<ConnectHappinessCardPage> createState() => _ConnectHappinessCardPageState();
}

class _ConnectHappinessCardPageState extends State<ConnectHappinessCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: ConnectHappinessCardGame(context: context),
    );
  }
}
