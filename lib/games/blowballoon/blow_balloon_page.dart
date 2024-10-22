import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:inface/games/components/game_backbutton.dart';

import 'blow_balloon_game.dart';

@RoutePage()
class BlowBalloonPage extends StatefulWidget {
  const BlowBalloonPage({super.key});

  @override
  State<BlowBalloonPage> createState() => _BlowBalloonPageState();
}

class _BlowBalloonPageState extends State<BlowBalloonPage> {

  final BlowBalloonGame _game = BlowBalloonGame();

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
