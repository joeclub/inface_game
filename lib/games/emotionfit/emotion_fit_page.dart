import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'emotion_fit_game.dart';

@RoutePage()
class EmotionFitPage extends StatefulWidget {
  const EmotionFitPage({super.key});

  @override
  State<EmotionFitPage> createState() => _EmotionFitPageState();
}

class _EmotionFitPageState extends State<EmotionFitPage> {
  
  final EmotionFitGame _game = EmotionFitGame(hasFirstHalfScore: false, hasRoundScore: false, isEP: false);

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
