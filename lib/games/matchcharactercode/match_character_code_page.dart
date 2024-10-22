import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_character_code_game.dart';

@RoutePage()
class MatchCharacterCodePage extends StatefulWidget {
  const MatchCharacterCodePage({super.key});

  @override
  State<MatchCharacterCodePage> createState() => _MatchCharacterCodePageState();
}

class _MatchCharacterCodePageState extends State<MatchCharacterCodePage> {
  
  final MatchCharacterCodeGame _game = MatchCharacterCodeGame();

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
