import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'compare_figure_game.dart';

@RoutePage()
class CompareFigurePage extends StatefulWidget {
  const CompareFigurePage({super.key});

  @override
  State<CompareFigurePage> createState() => _CompareFigurePageState();
}

class _CompareFigurePageState extends State<CompareFigurePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: CompareFigureGame(context: context),
    );
  }
}
