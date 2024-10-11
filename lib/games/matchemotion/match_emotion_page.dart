import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'match_emotion_game.dart';

@RoutePage()
class MatchEmotionPage extends StatefulWidget {
  const MatchEmotionPage({super.key});

  @override
  State<MatchEmotionPage> createState() => _MatchEmotionPageState();
}

class _MatchEmotionPageState extends State<MatchEmotionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MatchEmotionGame(context: context),
    );
  }
}
