import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_puzzle_game.dart';

@RoutePage()
class MatchPuzzlePage extends StatefulWidget {
  const MatchPuzzlePage({super.key});

  @override
  State<MatchPuzzlePage> createState() => _MatchPuzzlePagetate();
}

class _MatchPuzzlePagetate extends State<MatchPuzzlePage> {
  
  final MatchPuzzleGame _game = MatchPuzzleGame();

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
