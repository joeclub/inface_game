import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_text_color_game.dart';

@RoutePage()
class MatchTextColorPage extends StatefulWidget {
  const MatchTextColorPage({super.key});

  @override
  State<MatchTextColorPage> createState() => _MatchTextColorPageState();
}

class _MatchTextColorPageState extends State<MatchTextColorPage> {
  
  final MatchTextColorGame _game = MatchTextColorGame();

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
