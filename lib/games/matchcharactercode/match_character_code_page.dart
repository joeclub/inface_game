import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_character_code_game.dart';

@RoutePage()
class MatchCharacterCodePage extends StatefulWidget {
  const MatchCharacterCodePage({super.key});

  @override
  State<MatchCharacterCodePage> createState() => _MatchCharacterCodePageState();
}

class _MatchCharacterCodePageState extends State<MatchCharacterCodePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchCharacterCodeGame(context: context),
    );
  }
}
