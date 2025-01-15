import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'find_tile_game.dart';


@RoutePage()
class FindTilePage extends StatefulWidget {
  const FindTilePage({super.key});

  @override
  State<FindTilePage> createState() => _FindTilePageState();
}

class _FindTilePageState extends State<FindTilePage> {
  
  final FindTileGame _game = FindTileGame(hasFirstHalfScore: false, hasRoundScore: false, isEP: false);

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
