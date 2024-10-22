import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'compare_pattern_game.dart';

@RoutePage()
class ComparePatternPage extends StatefulWidget {
  const ComparePatternPage({super.key});

  @override
  State<ComparePatternPage> createState() => _ComparePatternPageState();
}

class _ComparePatternPageState extends State<ComparePatternPage> {

  final ComparePatternGame _game = ComparePatternGame();

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
