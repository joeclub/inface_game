import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_text_color_game.dart';

@RoutePage()
class MatchTextColorPage extends StatefulWidget {
  const MatchTextColorPage({super.key});

  @override
  State<MatchTextColorPage> createState() => _MatchTextColorPageState();
}

class _MatchTextColorPageState extends State<MatchTextColorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchTextColorGame(context: context),
    );
  }
}
