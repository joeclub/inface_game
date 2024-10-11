import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'find_tile_game.dart';


@RoutePage()
class FindTilePage extends StatefulWidget {
  const FindTilePage({super.key});

  @override
  State<FindTilePage> createState() => _FindTilePageState();
}

class _FindTilePageState extends State<FindTilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: FindTileGame(context: context),
    );
  }
}
