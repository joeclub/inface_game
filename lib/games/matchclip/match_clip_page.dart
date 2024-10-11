import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_clip_game.dart';

@RoutePage()
class MatchClipPage extends StatefulWidget {
  const MatchClipPage({super.key});

  @override
  State<MatchClipPage> createState() => _MatchClipPageState();
}

class _MatchClipPageState extends State<MatchClipPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchClipGame(context: context),
    );
  }
}
