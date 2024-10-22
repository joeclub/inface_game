import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'compare_prev_card_game.dart';

@RoutePage()
class ComparePrevCardPage extends StatefulWidget {
  const ComparePrevCardPage({super.key});

  @override
  State<ComparePrevCardPage> createState() => _ComparePrevCardPageState();
}

class _ComparePrevCardPageState extends State<ComparePrevCardPage> {

  final ComparePrevCardGame _game = ComparePrevCardGame();

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
