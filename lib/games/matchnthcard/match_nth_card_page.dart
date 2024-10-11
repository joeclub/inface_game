import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_nth_card_game.dart';

@RoutePage()
class MatchNthCardPage extends StatefulWidget {
  const MatchNthCardPage({super.key});

  @override
  State<MatchNthCardPage> createState() => _MatchNthCardPageState();
}

class _MatchNthCardPageState extends State<MatchNthCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchNthCardGame(context: context),
    );
  }
}
