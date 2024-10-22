import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'stacking_boxes_game.dart';

@RoutePage()
class StackingBoxesPage extends StatefulWidget {
  const StackingBoxesPage({super.key});

  @override
  State<StackingBoxesPage> createState() => _StackingBoxesPageState();
}

class _StackingBoxesPageState extends State<StackingBoxesPage> {
  
  final StackingBoxesGame _game = StackingBoxesGame();

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
