import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'blow_balloon_game.dart';

@RoutePage()
class BlowBalloonPage extends StatefulWidget {
  const BlowBalloonPage({super.key});

  @override
  State<BlowBalloonPage> createState() => _BlowBalloonPageState();
}

class _BlowBalloonPageState extends State<BlowBalloonPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: BlowBalloonGame(context: context),
    );
  }
}
