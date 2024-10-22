import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'match_clip_game.dart';

@RoutePage()
class MatchClipPage extends StatefulWidget {
  const MatchClipPage({super.key});

  @override
  State<MatchClipPage> createState() => _MatchClipPageState();
}

class _MatchClipPageState extends State<MatchClipPage> {
  
  final MatchClipGame _game = MatchClipGame();

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
