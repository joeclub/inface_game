import 'package:auto_route/auto_route.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../components/game_backbutton.dart';
import 'compare_picture_game.dart';

@RoutePage()
class ComparePicturePage extends StatefulWidget {
  const ComparePicturePage({super.key});

  @override
  State<ComparePicturePage> createState() => _ComparePicturePageState();
}

class _ComparePicturePageState extends State<ComparePicturePage> {

  final ComparePictureGame _game = ComparePictureGame(hasFirstHalfScore: false, hasRoundScore: false, isEP: false);

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
