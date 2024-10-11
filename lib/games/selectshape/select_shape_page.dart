import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'select_shape_game.dart';

@RoutePage()
class SelectShapePage extends StatefulWidget {
  const SelectShapePage({super.key});

  @override
  State<SelectShapePage> createState() => _SelectShapePageState();
}

class _SelectShapePageState extends State<SelectShapePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SelectShapeGame(context: context),
    );
  }
}
