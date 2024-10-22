import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_nth_card_game.dart';

@RoutePage()
class MatchNthCardPage extends StatefulWidget {
  const MatchNthCardPage({super.key});

  @override
  State<MatchNthCardPage> createState() => _MatchNthCardPageState();
}

class _MatchNthCardPageState extends State<MatchNthCardPage> {
  
  final MatchNthCardGame _game = MatchNthCardGame();

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
