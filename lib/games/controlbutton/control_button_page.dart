import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'control_button_game.dart';

@RoutePage()
class ControlButtonPage extends StatefulWidget {
  const ControlButtonPage({super.key});

  @override
  State<ControlButtonPage> createState() => _ControlButtonPageState();
}

class _ControlButtonPageState extends State<ControlButtonPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: ControlButtonGame(context: context),
    );
  }
}
