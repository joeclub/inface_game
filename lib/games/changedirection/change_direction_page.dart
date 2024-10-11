import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'change_direction_game.dart';

@RoutePage()
class ChangeDirectionPage extends StatefulWidget {
  const ChangeDirectionPage({super.key});

  @override
  State<ChangeDirectionPage> createState() => _ChangeDirectionPageState();
}

class _ChangeDirectionPageState extends State<ChangeDirectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: ChangeDirectionGame(context: context),
    );
  }
}