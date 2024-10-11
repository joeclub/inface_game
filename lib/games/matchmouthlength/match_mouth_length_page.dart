import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_mouth_length_game.dart';

@RoutePage()
class MatchMouthLengthPage extends StatefulWidget {
  const MatchMouthLengthPage({super.key});

  @override
  State<MatchMouthLengthPage> createState() => _MatchMouthLengthPageState();
}

class _MatchMouthLengthPageState extends State<MatchMouthLengthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchMouthLengthGame(context: context),
    );
  }
}
